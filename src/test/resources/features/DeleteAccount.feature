#Account should exist to delete. 200 status code
# Meke sure accout that does not exist to get 404 status code 

Feature: Create Account feature 

Background: Test setup and create new account. 
* def createAccount = callonce read('CreateAccount.feature')
* def validToken = createAccount.validToken
* def createdAccountId = createAccount.response.id
And print createAccount 
Given url "https://tek-insurance-api.azurewebsites.net"

Scenario: Successfully delete account 
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete
Then status 200
And assert response == "Account Successfully deleted"
Given path "/api/accounts/delete-account"
And param primaryPersonId = createdAccountId
And header Authorization = "Bearer " + validToken
When method delete 
Then status 404
And print response
And assert response.errorMessage == "Account with id " + createdAccountId + " not exist"