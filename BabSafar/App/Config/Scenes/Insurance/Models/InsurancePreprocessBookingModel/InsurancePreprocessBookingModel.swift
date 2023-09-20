//
//  InsurancePreprocessBookingModel.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import Foundation


struct InsurancePreprocessBookingModel : Codable {
    let max_age : String?
    let search_id : String?
    let tax : Double?
    let booking_source : String?
    let selected_package : Selected_package?
    let app_reference : String?
    let active_payment_options : [String]?
    let currencyCode : String?
    let converted_rate : Int?
    let min_age : String?
    let base_fare : Double?
    let total_fare : Double?
    let search_data : Search_data?

    enum CodingKeys: String, CodingKey {

        case max_age = "max_age"
        case search_id = "search_id"
        case tax = "tax"
        case booking_source = "booking_source"
        case selected_package = "selected_package"
        case app_reference = "app_reference"
        case active_payment_options = "active_payment_options"
        case currencyCode = "CurrencyCode"
        case converted_rate = "Converted_rate"
        case min_age = "min_age"
        case base_fare = "base_fare"
        case total_fare = "total_fare"
        case search_data = "search_data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        max_age = try values.decodeIfPresent(String.self, forKey: .max_age)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        tax = try values.decodeIfPresent(Double.self, forKey: .tax)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        selected_package = try values.decodeIfPresent(Selected_package.self, forKey: .selected_package)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        converted_rate = try values.decodeIfPresent(Int.self, forKey: .converted_rate)
        min_age = try values.decodeIfPresent(String.self, forKey: .min_age)
        base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
        total_fare = try values.decodeIfPresent(Double.self, forKey: .total_fare)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
    }

}




