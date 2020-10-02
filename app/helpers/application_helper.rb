module ApplicationHelper
  def last_announcement
    @last_announcement ||= Announcement.order(published_at: :desc).first
  end

  def body_class(body_class)
    if body_class.present?
      "#{body_class}"
    end
  end

  def embedded_svg(filename, options = {})
    file = File.read(Rails.root.join("frontend", "assets", "svg", filename))
    doc = Nokogiri::HTML::DocumentFragment.parse file
    svg = doc.at_css "svg"
    if options[:class].present?
      svg["class"] = options[:class]
    end
    doc.to_html.html_safe
  end

  def user_avatar(user, size = 100, class_name = "avatar")
    if user.avatar.attached?
      tag.span nil, class: class_name, style: "background-image: url(#{polymorphic_url user.avatar})"
    else
      tag.span "#{user.first_name.first}", class: class_name
    end
  end
end
