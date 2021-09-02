Feature: Verify CRUD operations for product API
  This feature fike will verify all crud operation for product API

  Background: 
    Given url "http://localhost:3030"
    And path "products"
    * def testData = read("../testData/testData.csv")

  Scenario: Get all products from best buy product list
    When method get
    Then status 200
    And match response.limit == 10
    And match response.skip != 5
    And match response.data[0].name == "Duracell - AAA Batteries (4-Pack)"
    And match response.data[0].name contains "Duracell"
    And match response.data[0] contains deep { "name": "Duracell - AAA Batteries (4-Pack)"}
    And match response contains deep {"data" : [{"name": "Duracell - AAA Batteries (4-Pack)"}]}
    And match header Content-Type == "application/json; charset=utf-8"
    And match response.total == "#present"
    And match response.total == "#number"
    And match response.data == "#array"
    And match response.data == "#[10]"
    And match response.id == "#notpresent"

  Scenario: Get products from best buy product list and add limit
    * def limit = 4
    And param $limit = limit
    When method get
    Then status 200
    And match response.limit == limit
    And match response.data == "#[4]"

  Scenario: Get one particular product from the list
    * def productId = 43900
    And path productId
    When method get
    Then status 200
    And match response.id == productId

  Scenario: Add product to the product list
    * def name = "Samsung Mobile"
    Given request
      """
      {
      "name": "#(name)",
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
    When method post
    Then status 201
    Then match response.name == name

  Scenario: Add product to the product list via json file
    * def payload = read("../testData/product.json")
    Given request payload
    When method post
    Then status 201
    Then match response.name == "Iphone"

  Scenario: Add product to the product list via json file and send another get request
    * def payload = read("../testData/product.json")
    Given request payload
    When method post
    Then status 201
    Then match response.name == "Iphone"
    * def productId = response.id
    And path "products/" + productId
    When method get
    Then status 200
    And match response.name == "Iphone"
    And match response.id == productId

  #Data-Driven Testing
  Scenario Outline: Verify add product api with multiple set of test data
    Given request
      """
      {
       "name": "#(name)",
         "type": "Mobile",
         "price": 3000,
         "shipping": 50,
         "upc": "#(upcValue)",
         "description": "Samsung Mobile 53",
         "manufacturer": "Samsung",
         "model": "S53",
         "url": "https://abc.com",
         "image": "string"
         }
      """
    When method post
    Then status <status>
    Then match response.name == "<name>"

    Examples: 
      | name           | upcValue                        | status |
      | Samsung Mobile | ABC                             |    201 |
      | IPhone         | dhsfjsdgf sdgfhsgdf kdsgfdshsdf |    400 |
      | Iphone         | BCD                             |    201 |

  Scenario Outline: Verify add product api with multiple set of test data via csv file
    Given request
      """
      {
       "name": "#(name)",
         "type": "Mobile",
         "price": 3000,
         "shipping": 50,
         "upc": "#(upcValue)",
         "description": "Samsung Mobile 53",
         "manufacturer": "Samsung",
         "model": "S53",
         "url": "https://abc.com",
         "image": "string"
         }
      """
    When method post
    Then status <status>
    Then match response.name == "<name>"

    Examples: 
      | testData |

  Scenario Outline: Verify add product api with multiple set of test data via csv file
    Given request
      """
      {
       "name": "#(name)",
         "type": "Mobile",
         "price": 3000,
         "shipping": 50,
         "upc": "#(upcValue)",
         "description": "Samsung Mobile 53",
         "manufacturer": "Samsung",
         "model": "S53",
         "url": "https://abc.com",
         "image": "string"
         }
      """
    When method post
    Then status <status>
    Then match response.name == "<name>"

    Examples: 
      #| testData |
       | read("../testData/testData.csv") |
