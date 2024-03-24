import Foundation

class DessertListViewModel: ObservableObject {
    @Published var meals: [Dessert] = []
    private let api: FetchApi
    
    init(api: FetchApi) {
        self.api = api
    }

    convenience init() {
        // by default use FetchApi(), otherwise use a custom class that inherits from FetchApi
        self.init(api: FetchApi())
    }

    func fetchDesserts() {
        api.fetchDesserts { dessertList in
            if let dessertList = dessertList {
                DispatchQueue.main.async {
                    self.meals = dessertList.meals.sorted()
                }
            }
        }
    }
}
