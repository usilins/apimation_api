class User
  attr_accessor :user_id

  attr_accessor :email

  attr_accessor :session_cookie

  def initialize(user_id, email)
    @user_id = user_id
    @email = email
    @session_cookie = {}
  end

  def set_session_cookie(session_cookie)
    @session_cookie['dancer.session'] = session_cookie
  end
end

