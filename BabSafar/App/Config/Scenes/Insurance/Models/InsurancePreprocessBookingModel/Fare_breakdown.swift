

import Foundation
struct Fare_breakdown : Codable {
    let minAge : String?
    let maxAge : String?
    let gender : String?
    let currencyCode : String?
    let premiumAmount : String?
    let premiumBreakdown : PremiumBreakdown?

    enum CodingKeys: String, CodingKey {

        case minAge = "MinAge"
        case maxAge = "MaxAge"
        case gender = "Gender"
        case currencyCode = "CurrencyCode"
        case premiumAmount = "PremiumAmount"
        case premiumBreakdown = "PremiumBreakdown"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        minAge = try values.decodeIfPresent(String.self, forKey: .minAge)
        maxAge = try values.decodeIfPresent(String.self, forKey: .maxAge)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        premiumAmount = try values.decodeIfPresent(String.self, forKey: .premiumAmount)
        premiumBreakdown = try values.decodeIfPresent(PremiumBreakdown.self, forKey: .premiumBreakdown)
    }

}
