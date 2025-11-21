// Controller used by the Visualforce page ProductListPage.
// Demonstrates how Visualforce calls getProductList() when the page references {!productList}.

public with sharing class SampleController {

    // Getter method: Visualforce will call this when it sees {!productList}
    public List<Product2> getProductList() {
        return [
            SELECT Id, Name, Description, UnitPrice
            FROM Product2
            ORDER BY Name
            LIMIT 50
        ];
    }
}
