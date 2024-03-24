import XCTest
@testable import FetchChallenge

class MealViewModelTests: XCTestCase {

    func testFetchMeal_Successful() {
        class MockFetchApi: FetchApi {
            override func fetchMeals(mealID: String, completion: @escaping (Meal?) -> ()) {
                let mealData: [String: Any] = [
                    "idMeal": "123",
                    "strMeal": "Dummy Meal",
                    "strIngredient1": "Milk",
                    "strMeasure1": "1 cup",
                ]
                completion(Meal(properties: mealData))
            }
        }
        let viewModel = MealViewModel(api: MockFetchApi())
        
        viewModel.fetchMeal(mealID: "123")
        
        XCTAssertEqual(viewModel.meal?.properties["idMeal"], "123", "ID should match")
        XCTAssertEqual(viewModel.meal?.properties["strMeal"], "Dummy Meal", "Name should match")
        XCTAssertEqual(viewModel.meal?.properties["strIngredient1"], "Milk", "Ingredient1 should match")
        XCTAssertEqual(viewModel.meal?.properties["strMeasure1"], "1 cup", "Measure1 should match")
    }
    
    func testFetchMeal_Failure() {
        class MockFetchApi: FetchApi {
            override func fetchMeals(mealID: String, completion: @escaping (Meal?) -> ()) {
                completion(nil)
            }
        }
        let viewModel = MealViewModel(api: MockFetchApi())
        
        viewModel.fetchMeal(mealID: "456")
        
        XCTAssertNil(viewModel.meal, "Meal should be nil")
    }
}
