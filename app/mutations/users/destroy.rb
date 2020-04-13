module Users
  class Destroy < Mutations::Command
    required { duck :user }

    def execute
      user.destroy!
    end
  end
end
