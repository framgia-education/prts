class Supports::UserSupport
  def total_users
    User.count
  end

  def number_of_admins
    User.number_of_admins
  end

  def number_of_trainers
    User.number_of_trainers
  end

  def number_of_normal_users
    User.number_of_normal_users
  end

  def active_members
    github_account_list = []
    list_account = PullRequest.where(status: :reviewing).group(:github_account).limit(3).order("count_id desc").count(:id)
    list_account.each do |key, value|
      github_account_list << key
    end
    User.where(github_account: github_account_list).sort_by{|u| github_account_list.index(u.github_account)}
  end
end
