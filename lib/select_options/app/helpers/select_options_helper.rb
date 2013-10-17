module SelectOptions

  module Helper

    # Returns select options for UI select elements
    # collection : collection of ActiveRecord objects
    # text_method: the attribute of ActiveRecord objects to show as text for select options
    # selected   : the currently selected ActiveRecord object (nil = none)
    def through_association_options_for_select(collection, text_method, selected = nil)
      separator = "-"
      return options_for_select(
        collection.map { |c| [c.send(text_method), c.class.to_s + separator + c.id.to_s] },
        :selected => (selected.nil? ? nil : selected.class.to_s + separator + selected.id.to_s))
    end

  end

end


ActionView::Base.send :include, SelectOptions::Helper