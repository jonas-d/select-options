module SelectOptionsHelper

  # Parameters
  # collection : collection of ActiveRecord objects
  # text_method: the attribute of ActiveRecord objects to show as text for select options
  # selected   : the currently selected ActiveRecord object
  def through_association_options_for_select(collection, text_method, selected = nil)
    return options_for_select(
      collection.map { |c| [c.send(text_method), c.class.to_s + "=" + c.id.to_s] },
      :selected => (selected.nil? ? nil : selected.class.to_s + "=" + selected.id.to_s))
  end

  # TODO: add a way to pass or just show the currently selected object
  # def through_association_options_for_bip(collection, text_method, selected = nil)
  #   return collection.map { |c| [c.class.to_s + "=" + c.id.to_s, c.send(text_method)] }
  # end

end