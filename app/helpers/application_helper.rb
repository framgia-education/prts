module ApplicationHelper
  def full_title page_title
    base_title = "PRTS"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def index_for object, index, per_page
    (object.to_i - 1) * per_page + index + 1
  end
end
