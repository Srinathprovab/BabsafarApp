//
//  TotalPrimuemViewModel.swift
//  BabSafar
//
//  Created by FCI on 19/09/23.
//

import Foundation

struct TotalPremiumModel : Codable {
    let base_fare : Double?
    let booking_source : String?
    let app_reference : String?
    let max_age : String?
    let converted_rate : Int?
    let min_age : String?
    let currencyCode : String?
    let search_data : Search_data?
    let tax : Double?
    let total_fare : Double?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case base_fare = "base_fare"
        case booking_source = "booking_source"
        case app_reference = "app_reference"
        case max_age = "max_age"
        case converted_rate = "Converted_rate"
        case min_age = "min_age"
        case currencyCode = "CurrencyCode"
        case search_data = "search_data"
        case tax = "tax"
        case total_fare = "total_fare"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        max_age = try values.decodeIfPresent(String.self, forKey: .max_age)
        converted_rate = try values.decodeIfPresent(Int.self, forKey: .converted_rate)
        min_age = try values.decodeIfPresent(String.self, forKey: .min_age)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        tax = try values.decodeIfPresent(Double.self, forKey: .tax)
        total_fare = try values.decodeIfPresent(Double.self, forKey: .total_fare)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
