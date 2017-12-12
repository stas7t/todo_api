class Ability
  include CanCan::Ability

  def initialize(user)
    alias_action :create, :read, :update, :destroy, to: :crud
    if user.present?
      can :crud, Project, user_id: user.id
      can :crud, Task, project: { user_id: user.id }
      can :crud, Comment, task: { project: { user_id: user.id } }
    end
  end
end
