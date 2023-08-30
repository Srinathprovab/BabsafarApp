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
 //   let form_params : Form_params?
    let search_data : Search_data?
    let app_reference : String?
//    let safe_search_data : Safe_search_data?
    let selected_package : Selected_package?
    let fare_breakdown : Fare_breakdown?
    let currencyCode : String?
    let converted_rate : Int?
    let total_fare : Double?
    let base_fare : Double?
    let tax : Int?
    let min_age : String?
    let max_age : String?
    let search_params : PreBookingSearch_params?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case active_payment_options = "active_payment_options"
        case booking_source = "booking_source"
   //     case form_params = "form_params"
        case search_data = "search_data"
        case app_reference = "app_reference"
//        case safe_search_data = "safe_search_data"
        case selected_package = "selected_package"
        case fare_breakdown = "fare_breakdown"
        case currencyCode = "CurrencyCode"
        case converted_rate = "Converted_rate"
        case total_fare = "total_fare"
        case base_fare = "base_fare"
        case tax = "tax"
        case min_age = "min_age"
        case max_age = "max_age"
        case search_params = "search_params"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
 //       form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
//        safe_search_data = try values.decodeIfPresent(Safe_search_data.self, forKey: .safe_search_data)
        selected_package = try values.decodeIfPresent(Selected_package.self, forKey: .selected_package)
        fare_breakdown = try values.decodeIfPresent(Fare_breakdown.self, forKey: .fare_breakdown)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        converted_rate = try values.decodeIfPresent(Int.self, forKey: .converted_rate)
        total_fare = try values.decodeIfPresent(Double.self, forKey: .total_fare)
        base_fare = try values.decodeIfPresent(Double.self, forKey: .base_fare)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        min_age = try values.decodeIfPresent(String.self, forKey: .min_age)
        max_age = try values.decodeIfPresent(String.self, forKey: .max_age)
        search_params = try values.decodeIfPresent(PreBookingSearch_params.self, forKey: .search_params)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
