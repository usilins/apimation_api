When(/^I log in apimation as a regular user$/) do
  @test_user = log_in_positive('api_test_account@yopmail.com', 'Parole123')
end

Then(/^I check if I am logged in and I can access my personal information$/) do
  check_if_user_logged_in
end

Then(/^I try to log in apimation with a wrong password$/) do
  @test_user = login_negative('api_test_account@yopmail.com', 'Parole111')
end

Then(/^I check if I am not logged in and cannot access any data$/) do
  check_if_user_not_logged_in
end