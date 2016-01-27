module TitleHelper
  def set_title(title)
    content_for :title, title
  end

  def get_title
    if content_for? :title
      "UTU - #{content_for :title}"
    else
      'UTU on Rails'
    end
  end
end