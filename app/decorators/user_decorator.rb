class UserDecorator < ApplicationDecorator
  delegate_all
  
  def name_or_email
    return name if name.present?

    email.split('@')[0]
  end
  
  def gravatar(size: 30, css_class: '')
    #email_hash = Digest::MDS.hexdigest email.strip.downcase
    h.image_tag "https://www.gravatar.com/avatar/#{hash}.jpg?s=#{size}",
                class: "rounded #{css_class}", alt: username#_or_email
  end
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
