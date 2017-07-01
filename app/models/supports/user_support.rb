class Supports::UserSupport
  def total_users
    User.count
  end

  def number_of_admins
    User.admin.size
  end

  def number_of_trainers
    User.trainer.size
  end

  def number_of_normal_users
    User.normal.size
  end

  def active_members
    list_account = PullRequest.merged.group(:github_account)
      .limit(Settings.active_users).order("count_id desc").count(:id)
    User.where(github_account: list_account.keys)
      .sort_by{|user| list_account.keys.index user.github_account}
  end
end
