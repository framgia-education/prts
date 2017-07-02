module Admin::OfficesHelper
  def total_pull_requests office
    PullRequest.joins(user: [:office]).where(users: {office_id: office.id}).size

    # office.users.map{|user| user.pull_requests.size}.inject :+  => n + 1 queries
  end
end
