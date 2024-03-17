import Foundation

class FetchApi {
    private let baseURL = "https://themealdb.com/api/json/v1/1"

    func fetchDesserts(completion: @escaping (MealList?) -> ()) {
        let urlString = "\(baseURL)/filter.php?c=Dessert"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    let decodedData = try? JSONDecoder().decode(MealList.self, from: data)
                    completion(decodedData)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }

    func fetchMealDetail(mealID: String, completion: @escaping (Meal?) -> ()) {
        let urlString = "\(baseURL)/lookup.php?i=\(mealID)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    do {
                        guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                            completion(nil)
                            return
                        }
                        if let mealsArray = json["meals"] as? [[String: Any]], let mealData = mealsArray.first {
                            let meal = Meal(properties: mealData)
                            completion(meal)
                        } else {
                            completion(nil)
                        }
                    } catch {
                        completion(nil)
                    }
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }
}
