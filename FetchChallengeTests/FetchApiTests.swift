import XCTest
@testable import FetchChallenge

final class FetchApiTests: XCTestCase {

    var fetchApi: FetchApi!

    override func setUp() {
        super.setUp()
        fetchApi = FetchApi()
    }

    override func tearDown() {
        fetchApi = nil
        super.tearDown()
    }

    func testFetchDesserts() {
        let expectation = self.expectation(description: "Fetch desserts")
        fetchApi.fetchDesserts { dessertList in
            XCTAssertNotNil(dessertList, "Dessert list should not be nil")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

    func testFetchMeals() {
        // random testable mealID
        let mealID = "52772"
        let expectation = self.expectation(description: "Fetch meal")
        fetchApi.fetchMeals(mealID: mealID) { meal in
            XCTAssertNotNil(meal, "Meal should not be nil")
            XCTAssertEqual(meal?.properties["idMeal"], mealID, "Meal ID should match the requested ID")
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}
