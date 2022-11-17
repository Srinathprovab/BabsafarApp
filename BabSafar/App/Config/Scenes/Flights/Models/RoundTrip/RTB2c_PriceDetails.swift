//
//  RTB2c_PriceDetails.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTB2c_PriceDetails : Codable {
    
    let baseFare : Int?
    let admin_markup_detail : Int?
    let totalTax : Int?
    let totalFare : Int?
    let currency : String?
    let currencySymbol : String?

    enum CodingKeys: String, CodingKey {

        case baseFare = "BaseFare"
        case admin_markup_detail = "admin_markup_detail"
        case totalTax = "TotalTax"
        case totalFare = "TotalFare"
        case currency = "Currency"
        case currencySymbol = "CurrencySymbol"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        baseFare = try values.decodeIfPresent(Int.self, forKey: .baseFare)
        admin_markup_detail = try values.decodeIfPresent(Int.self, forKey: .admin_markup_detail)
        totalTax = try values.decodeIfPresent(Int.self, forKey: .totalTax)
        totalFare = try values.decodeIfPresent(Int.self, forKey: .totalFare)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        currencySymbol = try values.decodeIfPresent(String.self, forKey: .currencySymbol)
    }

}
