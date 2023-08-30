//
//  IPrice_breakup.swift
//  BabSafar
//
//  Created by FCI on 28/08/23.
//

import Foundation

struct IPrice_breakup : Codable {
    let currency : String?
    let premiumAmount : Double?
    let base_fare : Double?
    let tax : Int?
    let markup : Markup?

    enum CodingKeys: String, CodingKey {

        case currency = "currency"
        case premiumAmount = "premiumAmount"
        case base_fare = "base_fare"
        case tax = "tax"
        case markup = "markup"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        premiumAmount = try values.decodeIfPresent(Double.self, forKey: .premiumAmount)
        base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        markup = try values.decodeIfPresent(Markup.self, forKey: .markup)
    }

}
