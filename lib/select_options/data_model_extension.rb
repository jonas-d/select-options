module ActiveRecord

  class Base

    # keep the existing method as UnboundMethod
    old_update_attributes = instance_method(:update_attributes)

    # using define_method allows to still access the old_update_attributes method (which
    # will be otherwise out of scope as this method has the same name)
    # reason: define_method takes a block which encloses the surrounding lexical environment
    define_method(:update_attributes) do |attributes|
      # get all relevant associations
      single_assoc = self.class.identify_single_through_associations
      attributes.each do |key, value|
        if single_assoc.index(key)
          if value.blank?
            # set association to nil, i.e. remove it
            self.send(key.to_s + "=", nil)
          else
            assoc_obj_class = value.split("=")[0].camelize
            assoc_obj_id = value.split("=")[1]
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

    protected

    # returns all ':has_one x :through y' and ':belongs_to x :through y' association names
    def self.identify_single_through_associations
      return reflect_on_all_associations.select { |a|
        (a.macro == :belongs_to || a.macro == :has_one) && !a.options[:through].blank? }.map { |a|
        a.name.to_s
      }
    end

  end

end # ActiveRecord