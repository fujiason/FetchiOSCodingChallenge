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
        fetchApi.fetchDesserts { dessertList in
            XCTAssertNotNil(dessertList, "Dessert list should not be nil")
        }
    }

    func testFetchMeals() {
        // random testable mealID
        let mealID = "52772"
        fetchApi.fetchMeals(mealID: mealID) { meal in
            XCTAssertNotNil(meal, "Meal should not be nil")
            XCTAssertEqual(meal?.properties["idMeal"], mealID, "Meal ID should match the requested ID")
        }
    }
}
