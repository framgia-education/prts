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
end
