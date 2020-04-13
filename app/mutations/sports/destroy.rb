module Sports
  class Destroy < Mutations::Command
    required { duck :sport }

    def execute
      sport.destroy!
    end
  end
end
