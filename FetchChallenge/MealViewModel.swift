import Foundation

class MealViewModel: ObservableObject {
    @Published var meal: Meal?
    private let api: FetchApi
    
    init(api: FetchApi) {
        self.api = api
    }

    convenience init() {
        self.init(api: FetchApi())
    }

    func fetchMeal(mealID: String) {
        api.fetchMeals(mealID: mealID) { meal in
            if let meal = meal {
                let filteredProperties = meal.properties.filter { !$0.value.trimmingCharacters(in: .whitespaces).isEmpty }
                DispatchQueue.main.async {
                    self.meal = Meal(properties: filteredProperties)
                }
            } else {
                DispatchQueue.main.async {
                    self.meal = nil
                }
            }
        }
    }
}
