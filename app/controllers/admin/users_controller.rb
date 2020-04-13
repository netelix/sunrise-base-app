module Admin
  class UsersController < Sunrise::Admin::UsersController
    def live_sessions
      user.live_sessions.filter(params[:session_filter])
    end
  end
end
