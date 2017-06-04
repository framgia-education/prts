module ApplicationHelper
  def full_title page_title
    base_title = "PRTS"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def index_for object, index, per_page
    (object.to_i - 1) * per_page + index + 1
  end

  def flash_class level
    case level
    when :notice then "alert-info"
    when :error then "alert-danger"
    when :alert then "alert-warning"
    when :success then "alert-success"
    end
  end
end
