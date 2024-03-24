import Foundation

class FetchApi {
    private let baseURL = "https://themealdb.com/api/json/v1/1"

    func fetchDesserts(completion: @escaping (DessertList?) -> ()) {
        let urlString = "\(baseURL)/filter.php?c=Dessert"
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            let decodedData = try? JSONDecoder().decode(DessertList.self, from: data)
            completion(decodedData)
        }.resume()
    }

    func fetchMeals(mealID: String, completion: @escaping (Meal?) -> ()) {
        let urlString = "\(baseURL)/lookup.php?i=\(mealID)"
        // I wanted to implement guard rather than have a "pyramid of doom" of if and catch statements which
        // all return a completion(nil)
        guard let url = URL(string: urlString) else {
            completion(nil)
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, _, _ in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                guard let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                      let mealsArray = json["meals"] as? [[String: Any]],
                      let mealData = mealsArray.first else {
                    throw NSError(domain: "ParsingError", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to parse JSON"])
                }
                let meal = Meal(properties: mealData)
                completion(meal)
            } catch {
                completion(nil)
            }
        }.resume()
    }
}
