module ApplicationHelper
  def full_title page_title
    base_title = "PRTS"
    page_title ? page_title + base_title : base_title
  end
end
