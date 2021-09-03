Feature: Send a POST product request
	Scenario:
		Given url _url
    And path _path
     #To add a new product
    * def name = _name
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
    * def productId = response.id