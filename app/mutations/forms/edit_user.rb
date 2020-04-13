module Forms
  class EditUser < ProcessForm
    required do
      string :email
    end

    optional do
      duck :user

      string :fname, empty: true
      string :lname, empty: true
    end

    def validate
      validate_already_in_use(email, :email, User, user)
    end

    def execute
      create? ? create_user : update_user
    end

    def create_user
      User.create!(user_inputs
                       .merge(password: (0...8).map { (65 + rand(26)).chr }.join))
    end

    def create?
      user.nil?
    end

    def update_user
      user.update!(user_inputs)
    end

    def user_inputs
      %i[fname lname email].map do |field|
        [field, send(field)]
      end.to_h
    end

    def initialize_form
      form.fname = user&.fname
      form.lname = user&.lname
      form.email = user&.email
    end

    def unpermitted_form_input_names
      %i[user]
    end
  end
end
