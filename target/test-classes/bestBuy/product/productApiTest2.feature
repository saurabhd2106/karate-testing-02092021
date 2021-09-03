Feature: Verify PUT, PATCH and DELETE product request

  Background: 
    Given url "http://localhost:3030"
    And path "products"

  @Sanity @Regression
  Scenario: Update product via PUT
    * def postResponse = call read("postProductRequest.feature") {_url: "http://localhost:3030", _path: "products", _name: "Samsung Mobile" }
    * def productId = postResponse.productId
    * print productId
    #Send a PUT request to update
    Given path productId
    And request
      """
      {
      "name": "Iphone",
      "type": "Mobile",
      "price": 3000,
      "shipping": 50,
      "upc": "Best",
      "description": "Samsung Mobile 53",
      "manufacturer": "Samsung",
      "model": "S53",
      "url": "https://abc.com",
      "image": "string"
      }
      """
    When method put
    Then status 200
    Then match response.name == "Iphone"

  @Ignore
  Scenario: Delete a product
    * def postResponse = call read("postProductRequest.feature") {_url: "http://localhost:3030", _path: "products", _name: "Samsung Mobile" }
    * def productId = postResponse.productId
    * print productId
    Given path productId
    When method delete
    Then status 200
    Given path "products/" + productId
    When method get
    Then status 404
