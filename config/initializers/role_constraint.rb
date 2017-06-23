class RoleConstraint
  def initialize *roles
    @roles = roles
  end

  def matches? request
    user = User.find_by id: request.session["user_id"]
    return false unless user
    @roles.include? user.role.to_sym
  end
end
