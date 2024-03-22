import SwiftUI

struct MealListView: View {
    @State private var meals: [MealPreview] = []

    var body: some View {
        NavigationView {
            List(meals) { meal in
                NavigationLink(destination: MealDetailView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .navigationTitle("Desserts")
            .task {
                FetchApi().fetchDesserts { mealList in
                    if let mealList = mealList {
                        meals = mealList.meals.sorted()
                    }
                }
            }
        }
    }
}
