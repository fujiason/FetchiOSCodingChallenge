import SwiftUI

struct ContentView: View {
    var body: some View {
        DessertListView()
    }
}

struct DessertListView: View {
    @ObservedObject var viewModel = DessertListViewModel()

    var body: some View {
        NavigationView {
            List(viewModel.meals) { meal in
                NavigationLink(destination: MealsView(mealID: meal.idMeal)) {
                    Text(meal.strMeal)
                }
            }
            .task {
                viewModel.fetchDesserts()
            }
            .navigationTitle("Desserts")
        }
    }
}

struct MealsView: View {
    @ObservedObject var viewModel: MealViewModel
    let mealID: String

    init(mealID: String) {
        self.mealID = mealID
        self.viewModel = MealViewModel()
    }

    var body: some View {
        ScrollView {
            VStack {
                if let meal = viewModel.meal {
                    Text("\(meal.properties["strMeal"] ?? "")")
                        .font(.largeTitle)
                    Text("\(meal.properties["strInstructions"] ?? "")")
                        .padding(.top)
                        .padding(.bottom)
                    HStack {
                        VStack {
                            ForEach(meal.properties.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                if key.starts(with: "strIngredient") {
                                    Text(value)
                                        .padding(.vertical, 2)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                        VStack {
                            ForEach(meal.properties.sorted(by: { $0.key < $1.key }), id: \.key) { key, value in
                                if key.starts(with: "strMeasure") {
                                    Text(value)
                                        .padding(.vertical, 2)
                                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                        }
                    }
                } else {
                    Text("Loading...")
                }
            }
        }
        .padding()
        .task {
            viewModel.fetchMeal(mealID: mealID)
        }
    }
}
