Feature: End to End test for account creation

  Background: 
    Given url "https://tek-insurance-api.azurewebsites.net"
    * def newAccount = callonce read('GenerateToken.feature')
    * def validToken = newAccount.response.token

  Scenario: Create valid account
    Given path "/api/accounts/add-primary-account"
    And header Authorization = "Bearer " + validToken
    * def generateDataObject = Java.type('api.utility.data.GenerateData')
    * def autoEmail = generateDataObject.getEmail()
    And request
      """
      {
      "email": "#(autoEmail)",
      "firstName": "AhmadAhmad",
      "lastName": "GhafoorGhafoor",
      "title": "Mr.",
      "gender": "MALE",
      "maritalStatus": "MARRIED",
      "employmentStatus": "employed",
      "dateOfBirth": "1986-10-10"
      }
      """
    When method post
    Then status 201
    And print response
    And assert response.email == autoEmail
    # Add phone number to the created account
    * def ID = response.id
    And path "/api/accounts/add-account-phone"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = ID
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def phoneNumber = dataGenerator.getPhoneNumber()
    And request
      """
      {
        "phoneNumber": "#(phoneNumber)",
        "phoneExtension": "3543",
        "phoneTime": "Day",
        "phoneType": "Mobile"
      }
      """
    When method post
    Then status 201
    And assert response.phoneNumber == phoneNumber
    # Add address to the created account
    And path "/api/accounts/add-account-address"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = ID
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def getAddress = dataGenerator.getAddress()
    And request
      """
      
      {
      "addressType": "Residential",
      "addressLine1": "#(getAddress)",
      "city": "Fairfax",
      "state": "NY",
      "postalCode": "06545",
      "countryCode": "US",
      "current": true
      }   
      """
    When method post
    Then status 201
    And print response
    # Add Car to created account
    And path "/api/accounts/add-account-car"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = ID
    * def dataGenerator = Java.type('api.utility.data.GenerateData')
    * def getCar = dataGenerator.getCar()
    And request
      """
      {
      "make": "Audi",
      "model": "Q5",
      "year": "2024",
      "licensePlate": "#(getCar)"
      }
      """
    When method post
    Then status 201
    # Delete created account 
    And path "/api/accounts/delete-account"
    And header Authorization = "Bearer " + validToken
    And param primaryPersonId = ID
    When method delete
    Then status 200
    And print response
    And assert response == "Account Successfully deleted"
