require 'test-unit'

def log_in_positive(email, password)
  login_payload_json = { :login => email,
                         :password => password }.to_json


  response = post("https://apimation.com/login",
                  headers: { 'Content-Type' => 'application/json;charset=utf-8' },
                  cookies: {},
                  payload: login_payload_json)

  # Check if 200 OK is received
  assert_equal(200, response.code, "Failed to log in!\nRespones : #{response}")

  response_hash = JSON.parse(response)

  # Check if email in the response is correct
  assert_equal(email, response_hash['email'], 'Users e-mail is not correct!')

  # Check if login in the response is correct
  assert_equal(email, response_hash['login'], 'Users login is not correct!')

  test_user = User.new(response_hash['user_id'], response_hash['email'])

  test_user.set_session_cookie(response.cookies['dancer.session'])

  test_user
end

def check_if_user_logged_in
  user_response = get("https://apimation.com/user",
                      headers: {},
                      cookies: @test_user.session_cookie)

  # Check if 200 OK is received
  assert_equal(200, user_response.code, "Failed to fetch user data!\nResponse : #{user_response}")

  user_response_hash = JSON.parse(user_response)

  # Check if email in the response is correct
  assert_equal(@test_user.email, user_response_hash['email'], 'The email in response is not correct!')

  # Check if user id in the response is correct
  assert_equal(@test_user.user_id, user_response_hash['user_id'], 'The user id in response is not correct!')
end

def login_negative(email, password)
  login_payload_json = { :login => email,
                         :password => password }.to_json


  response = post("https://apimation.com/login",
                  headers: { 'Content-Type' => 'application/json;charset=utf-8' },
                  cookies: {},
                  payload: login_payload_json)

  # Check if error 400 is returned
  assert_equal(400, response.code, "Wrong error has been returned!\nResponse : #{response}")

  test_user = User.new(nil, 'api_test_account@yopmail.com')
  test_user.set_session_cookie(response.cookies['dancer.session'])

  test_user
end

def check_if_user_not_logged_in
  user_response = get("https://apimation.com/user",
                      headers: {},
                      cookies: @test_user.session_cookie)

  # Check if 400 error is received
  assert_equal(400, user_response.code, "Wrong error code has been received!\nResponse : #{user_response}")
end

