struct DessertList: Decodable {
    let meals: [Dessert]
}

struct Dessert: Decodable, Identifiable, Comparable {
    let idMeal: String
    let strMeal: String
    
    var id: String {
        return idMeal
    }
    
    // sorts dessert objects in meals list in DessertList by alphabetical order
    static func < (lhs: Dessert, rhs: Dessert) -> Bool {
        return lhs.strMeal < rhs.strMeal
    }
}

struct Meal: Decodable {
    var properties: [String: String]

    init(properties: [String: Any]) {
        self.properties = properties.compactMapValues { $0 as? String }
    }
}
