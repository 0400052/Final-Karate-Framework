@Regression
Feature: Create Account feature

  Background: Setup test and generate token.
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def result = callonce read('GenerateToken.feature')
    * def validToken = result.response.token

  
  Scenario: Create valid account
  Given path "/api/accounts/add-primary-account"
  And header Authorization = "Bearer " + validToken
  #calling java class in feature file. this utility will create object from java class.
  * def generateDataObject = Java.type('api.utility.data.GenerateData')
  * def autoEmail = generateDataObject.getEmail()
  And request 
  """
  {
  "email": "#(autoEmail)",
  "firstName": "Ahmad",
  "lastName": "Ghafoor",
  "title": "Mr.",
  "gender": "MALE",
  "maritalStatus": "MARRIED",
  "employmentStatus": "employed",
  "dateOfBirth": "2023-08-07"
}
  
  
  """
  When method post 
  Then status 201
  And print response 
  And assert response.email == autoEmail
  
  # using delete endpoint to remove generate account for continous execution
  #Given path"/api/accounts/delete-account"
  #And param primaryPersonId = response.id
  #And header authorization = "Bearer " + validToken
  #When method delete
  #And status 200
  #And print response
  #And assert response == "Account Successfully deleted"
