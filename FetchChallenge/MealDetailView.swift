import SwiftUI

struct MealsView: View {
    @State private var meal: Meal?
    let mealID: String

    var body: some View {
        ScrollView {
            VStack {
                if let meal = meal {
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
            FetchApi().fetchMeals(mealID: mealID) { meals in
                if let meal = meals {
                    let filteredProperties = meal.properties.filter { !$0.value.trimmingCharacters(in: .whitespaces).isEmpty }
                    self.meal = Meal(properties: filteredProperties)
                } else {
                    self.meal = nil
                }
            }
        }
    }
}
