import SwiftUI

struct DessertListView: View {
    @State private var meals: [Dessert] = []

    var body: some View {
        NavigationView {
            List(meals) { meal in
                NavigationLink(destination: MealsView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .task {
                FetchApi().fetchDesserts { dessertList in
                    if let dessertList = dessertList {
                        meals = dessertList.meals.sorted()
                    }
                }
            }
            .navigationTitle("Desserts")
        }
    }
}
