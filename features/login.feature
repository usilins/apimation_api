@login
Feature: Login test cases
  Test the login functionality of apimation.com

  Scenario: Login - positive
    When I log in apimation as a regular user
    Then I check if I am logged in and I can access my personal information

  Scenario: Login - negative
    When I try to log in apimation with a wrong password
    Then I check if I am not logged in and cannot access any data