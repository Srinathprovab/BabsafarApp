//
//  MBModel.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation

struct MBModel : Codable {
    let price_changed : Bool?
    let flight_terms_cancellation_policy : String?
    let total_price : Double?
    //  let insuranceCountry : [InsuranceCountry]?
    let active_payment_options : [String]?
    let insuranceFile : String?
    //  let app_supported_currency : App_supported_currency?
    let travel_date_diff : String?
    let pre_booking_params : MBPre_booking_params?
    let session_expiry_details : Session_expiry_details?
    //   let insurancePeriod : [InsurancePeriod]?
    //   let search_data : MBSearch_data?
    let converted_currency_rate : Int?
    //   let app_supported_currency_usd : App_supported_currency_usd?
    let tmp_flight_pre_booking_id : String?
    let booking_source : String?
    //   let form_params : Form_params?
    let frequent_flyers : [Frequent_flyers]?
    let total_price_with_rewards : Int?
    //   let airprice_response : Airprice_response?
    let flight_data : [MBFlightData]?
    let access_key_tp : String?
    //  let safe_search_data : Safe_search_data?
    let reducing_amount : Int?
    let pax_details : [String]?
    let reward_earned : Int?
    let reward_usable : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case price_changed = "price_changed"
        case flight_terms_cancellation_policy = "flight_terms_cancellation_policy"
        case total_price = "total_price"
        //  case insuranceCountry = "insuranceCountry"
        case active_payment_options = "active_payment_options"
        case insuranceFile = "insuranceFile"
        //    case app_supported_currency = "app_supported_currency"
        case travel_date_diff = "travel_date_diff"
        case pre_booking_params = "pre_booking_params"
        case session_expiry_details = "session_expiry_details"
        //    case insurancePeriod = "insurancePeriod"
        //    case search_data = "search_data"
        case converted_currency_rate = "converted_currency_rate"
        //    case app_supported_currency_usd = "app_supported_currency_usd"
        case tmp_flight_pre_booking_id = "tmp_flight_pre_booking_id"
        case booking_source = "booking_source"
        //    case form_params = "form_params"
        case frequent_flyers = "frequent_flyers"
        case total_price_with_rewards = "total_price_with_rewards"
        //    case airprice_response = "airprice_response"
        case flight_data = "flight_data"
        case access_key_tp = "access_key_tp"
        //   case safe_search_data = "safe_search_data"
        case reducing_amount = "reducing_amount"
        case pax_details = "pax_details"
        case reward_earned = "reward_earned"
        case reward_usable = "reward_usable"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        price_changed = try values.decodeIfPresent(Bool.self, forKey: .price_changed)
        flight_terms_cancellation_policy = try values.decodeIfPresent(String.self, forKey: .flight_terms_cancellation_policy)
        total_price = try values.decodeIfPresent(Double.self, forKey: .total_price)
        //       insuranceCountry = try values.decodeIfPresent([InsuranceCountry].self, forKey: .insuranceCountry)
        active_payment_options = try values.decodeIfPresent([String].self, forKey: .active_payment_options)
        insuranceFile = try values.decodeIfPresent(String.self, forKey: .insuranceFile)
        //      app_supported_currency = try values.decodeIfPresent(App_supported_currency.self, forKey: .app_supported_currency)
        travel_date_diff = try values.decodeIfPresent(String.self, forKey: .travel_date_diff)
        pre_booking_params = try values.decodeIfPresent(MBPre_booking_params.self, forKey: .pre_booking_params)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        //    insurancePeriod = try values.decodeIfPresent([InsurancePeriod].self, forKey: .insurancePeriod)
        //     search_data = try values.decodeIfPresent(Search_data.self, forKey: .search_data)
        converted_currency_rate = try values.decodeIfPresent(Int.self, forKey: .converted_currency_rate)
        //      app_supported_currency_usd = try values.decodeIfPresent(App_supported_currency_usd.self, forKey: .app_supported_currency_usd)
        tmp_flight_pre_booking_id = try values.decodeIfPresent(String.self, forKey: .tmp_flight_pre_booking_id)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        //     form_params = try values.decodeIfPresent(Form_params.self, forKey: .form_params)
        frequent_flyers = try values.decodeIfPresent([Frequent_flyers].self, forKey: .frequent_flyers)
        total_price_with_rewards = try values.decodeIfPresent(Int.self, forKey: .total_price_with_rewards)
        //      airprice_response = try values.decodeIfPresent(Airprice_response.self, forKey: .airprice_response)
        flight_data = try values.decodeIfPresent([MBFlightData].self, forKey: .flight_data)
        access_key_tp = try values.decodeIfPresent(String.self, forKey: .access_key_tp)
        //   safe_search_data = try values.decodeIfPresent(Safe_search_data.self, forKey: .safe_search_data)
        reducing_amount = try values.decodeIfPresent(Int.self, forKey: .reducing_amount)
        pax_details = try values.decodeIfPresent([String].self, forKey: .pax_details)
        reward_earned = try values.decodeIfPresent(Int.self, forKey: .reward_earned)
        reward_usable = try values.decodeIfPresent(Int.self, forKey: .reward_usable)
    }
    
}
