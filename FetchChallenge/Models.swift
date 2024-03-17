import Foundation

struct MealList: Decodable {
    let meals: [MealPreview]
}

struct MealPreview: Decodable, Identifiable, Comparable {
    let idMeal: String
    let strMeal: String
    let strMealThumb: String
    
    var id: String {
        return idMeal
    }
    
    static func < (lhs: MealPreview, rhs: MealPreview) -> Bool {
        return lhs.strMeal < rhs.strMeal
    }
}

struct MealDetail: Decodable {
    let meals: [Meal]
}

struct Meal: Decodable {
    var properties: [String: String]

    init(properties: [String: Any]) {
        self.properties = properties.compactMapValues { $0 as? String }
    }
}
