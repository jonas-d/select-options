module SelectOptions

  module ActiveRecordExtension

    extend ActiveSupport::Concern


    module ClassMethods
    
      def replace_update_attributes_method
        # keep the existing method as UnboundMethod
        old_update_attributes = instance_method(:update_attributes)

        # using define_method allows to still access the old_update_attributes method (which
        # will be otherwise out of scope as this method has the same name)
        # reason: define_method takes a block which encloses the surrounding lexical environment
        define_method(:update_attributes) do |attributes|
          seperator = "-"
          # get all relevant associations
          single_assoc = self.class.identify_single_through_associations
          attributes.each do |key, value|
            if single_assoc.index(key)
              if value.blank?
                # set association to nil, i.e. remove it
                self.send(key.to_s + "=", nil)
              else
                assoc_obj_class = value.split(seperator)[0].camelize
                assoc_obj_id = value.split(seperator)[1]
                if Object.const_defined?(assoc_obj_class) && (assoc_obj_class.constantize < ActiveRecord::Base)
                  self.send(key.to_s + "=", assoc_obj_class.constantize.find_by_id(assoc_obj_id))
                else
                  return false
                end
              end
              attributes.delete(key)
            end
          end
          # update all other attributes
          old_update_attributes.bind(self).call(attributes)
        end
      end

      # returns all 'has_one x :through y' association names ('belongs_to :through' does not exist)
      def identify_single_through_associations
        return reflect_on_all_associations.select { |a|
          (a.macro == :has_one) && !a.options[:through].blank? }.map { |a|
          a.name.to_s
        }
      end
    end # ClassMethods

  end # ActiveRecordExtension

end # SelectOptions


ActiveRecord::Base.send :include, SelectOptions::ActiveRecordExtension
ActiveRecord::Base.replace_update_attributes_method
