module ContactsHelper
  def nested_contacts(contacts)
    contacts.map do |contact, sub_contact|
      render(contact) + content_tag(:div, nested_contacts(sub_contact), :class => "nested_items")
    end.join.html_safe
  end
end
