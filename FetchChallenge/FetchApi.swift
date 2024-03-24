import Foundation

class FetchApi {
    private let baseURL = "https://themealdb.com/api/json/v1/1"

    func fetchDesserts(completion: @escaping (DessertList?) -> ()) {
        let urlString = "\(baseURL)/filter.php?c=Dessert"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                if let data = data {
                    let decodedData = try? JSONDecoder().decode(DessertList.self, from: data)
                    completion(decodedData)
                } else {
                    completion(nil)
                }
            }.resume()
        }
    }

    func fetchMeals(mealID: String, completion: @escaping (Meal?) -> ()) {
        let urlString = "\(baseURL)/lookup.php?i=\(mealID)"
        if let url = URL(string: urlString) {
            URLSession.shared.dataTask(with: url) { data, _, _ in
                guard let data = data else {
                    completion(nil)
                    return
                }
                do {
                    guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {
                        throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])
                    }
                    
                    guard let mealsArray = json["meals"] as? [[String: Any]], let mealData = mealsArray.first else {
                        throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data"])
                    }
                    
                    let meal = Meal(properties: mealData)
                    completion(meal)
                    return
                } catch {
                    completion(nil)
                    return
                }
            }.resume()
        }
    }
}
