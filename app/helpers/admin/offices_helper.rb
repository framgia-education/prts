module Admin::OfficesHelper
  def total_pull_requests office
    total = 0
    office.users.each do |user|
      total += user.pull_requests.size
    end
    total
  end
end
