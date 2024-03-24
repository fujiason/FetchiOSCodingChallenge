import XCTest
@testable import FetchChallenge

class DessertListViewModelTests: XCTestCase {

    func testFetchDesserts() {
        class MockFetchApi: FetchApi {
            override func fetchDesserts(completion: @escaping (DessertList?) -> ()) {
                let dessert1 = Dessert(idMeal: "1", strMeal: "Dessert1")
                let dessert2 = Dessert(idMeal: "2", strMeal: "Dessert2")
                let dessertList = DessertList(meals: [dessert1, dessert2])
                completion(dessertList)
            }
        }
        
        let viewModel = DessertListViewModel(api: MockFetchApi())
        
        viewModel.fetchDesserts()
        
        XCTAssertEqual(viewModel.meals.count, 2, "ViewModel should have 2 desserts")
        XCTAssertEqual(viewModel.meals[0].strMeal, "Dessert1", "Dessert name should match")
        XCTAssertEqual(viewModel.meals[1].strMeal, "Dessert2", "Dessert name should match")
    }
}
