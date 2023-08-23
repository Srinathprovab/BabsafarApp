//
//  InsurancePreprocessBookingModel.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import Foundation


struct InsurancePreprocessBookingModel : Codable {
    let active_payment_options : [String]?
    let booking_source : String?
    let search_data : Search_data?
    let app_reference : String?
    let fare_breakdown : Fare_breakdown?
    let currencyCode : String?
    let converted_rate : Int?
    let total_fare : Double?
    let base_fare : Double?
    let tax : Double?
    let search_params : PreBookingSearch_params?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
        case search_data = "search_data"
        case app_reference = "app_reference"
        case fare_breakdown = "fare_breakdown"
        case currencyCode = "CurrencyCode"
        case converted_rate = "Converted_rate"
        case total_fare = "total_fare"
        case base_fare = "base_fare"
        case tax = "tax"
        case search_params = "search_params"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        fare_breakdown = try values.decodeIfPresent(Fare_breakdown.self, forKey: .fare_breakdown)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        converted_rate = try values.decodeIfPresent(Int.self, forKey: .converted_rate)
        total_fare = try values.decodeIfPresent(Double.self, forKey: .total_fare)
        base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
        tax = try values.decodeIfPresent(Double.self, forKey: .tax)
        search_params = try values.decodeIfPresent(PreBookingSearch_params.self, forKey: .search_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
