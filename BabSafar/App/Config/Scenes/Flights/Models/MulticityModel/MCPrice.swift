//
//  MCPrice.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCPrice : Codable {
    
    let publicFareBasisCodes : [MCPublicFareBasisCodes]?
    let api_currency : String?
    let api_total_display_fare : Double?
    let api_total_display_fare_withoutmarkup : String?
    let total_breakup : MCTotal_breakup?
    let api_total_display_fare_normal : Int?
    let pax_breakup : [String]?
    let price_breakup : MCPrice_breakup?
    let booking_fare_type : String?
    let screen_price_breakup : [String]?

    enum CodingKeys: String, CodingKey {

        case publicFareBasisCodes = "publicFareBasisCodes"
        case api_currency = "api_currency"
        case api_total_display_fare = "api_total_display_fare"
        case api_total_display_fare_withoutmarkup = "api_total_display_fare_withoutmarkup"
        case total_breakup = "total_breakup"
        case api_total_display_fare_normal = "api_total_display_fare_normal"
        case pax_breakup = "pax_breakup"
        case price_breakup = "price_breakup"
        case booking_fare_type = "booking_fare_type"
        case screen_price_breakup = "screen_price_breakup"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        publicFareBasisCodes = try values.decodeIfPresent([MCPublicFareBasisCodes].self, forKey: .publicFareBasisCodes)
        api_currency = try values.decodeIfPresent(String.self, forKey: .api_currency)
        api_total_display_fare = try values.decodeIfPresent(Double.self, forKey: .api_total_display_fare)
        api_total_display_fare_withoutmarkup = try values.decodeIfPresent(String.self, forKey: .api_total_display_fare_withoutmarkup)
        total_breakup = try values.decodeIfPresent(MCTotal_breakup.self, forKey: .total_breakup)
        api_total_display_fare_normal = try values.decodeIfPresent(Int.self, forKey: .api_total_display_fare_normal)
        pax_breakup = try values.decodeIfPresent([String].self, forKey: .pax_breakup)
        price_breakup = try values.decodeIfPresent(MCPrice_breakup.self, forKey: .price_breakup)
        booking_fare_type = try values.decodeIfPresent(String.self, forKey: .booking_fare_type)
        screen_price_breakup = try values.decodeIfPresent([String].self, forKey: .screen_price_breakup)
    }

}
