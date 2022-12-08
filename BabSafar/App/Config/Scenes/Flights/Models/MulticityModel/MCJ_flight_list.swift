//
//  MCJ_flight_list.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCJ_flight_list : Codable {
    let airPricingSolution_Key : String?
    let completeItinerary : String?
    let connections : String?
    let totalPrice : String?
    let basePrice : String?
    let taxes : String?
    let totalPrice_API : String?
    let aPICurrencyType : String?
    let sITECurrencyType : String?
    let myMarkup : Int?
    let myMarkup_cal : Int?
    let aMarkup : Int?
    let aMarkup_cal : Int?
    let basePrice_Breakdown : String?
    let taxPrice_Breakdown : String?
    let refundable : String?
    let platingCarrier : String?
    let fareType : String?
    let all_Passenger : String?
    let adults : Int?
    let trip_type : String?
    let travelTime : String?
    let carrier : String?
    let flight_details : MCFlight_details?
    let selectedResult : String?
    let adults_Base_Price : String?
    let childs_Base_Price : String?
    let infants_Base_Price : String?
    let adults_Tax_Price : String?
    let childs_Tax_Price : String?
    let infants_Tax_Price : String?

    enum CodingKeys: String, CodingKey {

        case airPricingSolution_Key = "AirPricingSolution_Key"
        case completeItinerary = "CompleteItinerary"
        case connections = "Connections"
        case totalPrice = "TotalPrice"
        case basePrice = "BasePrice"
        case taxes = "Taxes"
        case totalPrice_API = "TotalPrice_API"
        case aPICurrencyType = "APICurrencyType"
        case sITECurrencyType = "SITECurrencyType"
        case myMarkup = "MyMarkup"
        case myMarkup_cal = "MyMarkup_cal"
        case aMarkup = "aMarkup"
        case aMarkup_cal = "aMarkup_cal"
        case basePrice_Breakdown = "BasePrice_Breakdown"
        case taxPrice_Breakdown = "TaxPrice_Breakdown"
        case refundable = "Refundable"
        case platingCarrier = "PlatingCarrier"
        case fareType = "FareType"
        case all_Passenger = "All_Passenger"
        case adults = "Adults"
        case trip_type = "trip_type"
        case travelTime = "TravelTime"
        case carrier = "Carrier"
        case flight_details = "flight_details"
        case selectedResult = "selectedResult"
        case adults_Base_Price = "Adults_Base_Price"
        case childs_Base_Price = "Childs_Base_Price"
        case infants_Base_Price = "Infants_Base_Price"
        case adults_Tax_Price = "Adults_Tax_Price"
        case childs_Tax_Price = "Childs_Tax_Price"
        case infants_Tax_Price = "Infants_Tax_Price"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        airPricingSolution_Key = try values.decodeIfPresent(String.self, forKey: .airPricingSolution_Key)
        completeItinerary = try values.decodeIfPresent(String.self, forKey: .completeItinerary)
        connections = try values.decodeIfPresent(String.self, forKey: .connections)
        totalPrice = try values.decodeIfPresent(String.self, forKey: .totalPrice)
        basePrice = try values.decodeIfPresent(String.self, forKey: .basePrice)
        taxes = try values.decodeIfPresent(String.self, forKey: .taxes)
        totalPrice_API = try values.decodeIfPresent(String.self, forKey: .totalPrice_API)
        aPICurrencyType = try values.decodeIfPresent(String.self, forKey: .aPICurrencyType)
        sITECurrencyType = try values.decodeIfPresent(String.self, forKey: .sITECurrencyType)
        myMarkup = try values.decodeIfPresent(Int.self, forKey: .myMarkup)
        myMarkup_cal = try values.decodeIfPresent(Int.self, forKey: .myMarkup_cal)
        aMarkup = try values.decodeIfPresent(Int.self, forKey: .aMarkup)
        aMarkup_cal = try values.decodeIfPresent(Int.self, forKey: .aMarkup_cal)
        basePrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .basePrice_Breakdown)
        taxPrice_Breakdown = try values.decodeIfPresent(String.self, forKey: .taxPrice_Breakdown)
        refundable = try values.decodeIfPresent(String.self, forKey: .refundable)
        platingCarrier = try values.decodeIfPresent(String.self, forKey: .platingCarrier)
        fareType = try values.decodeIfPresent(String.self, forKey: .fareType)
        all_Passenger = try values.decodeIfPresent(String.self, forKey: .all_Passenger)
        adults = try values.decodeIfPresent(Int.self, forKey: .adults)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        travelTime = try values.decodeIfPresent(String.self, forKey: .travelTime)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        flight_details = try values.decodeIfPresent(MCFlight_details.self, forKey: .flight_details)
        selectedResult = try values.decodeIfPresent(String.self, forKey: .selectedResult)
        adults_Base_Price = try values.decodeIfPresent(String.self, forKey: .adults_Base_Price)
        childs_Base_Price = try values.decodeIfPresent(String.self, forKey: .childs_Base_Price)
        infants_Base_Price = try values.decodeIfPresent(String.self, forKey: .infants_Base_Price)
        adults_Tax_Price = try values.decodeIfPresent(String.self, forKey: .adults_Tax_Price)
        childs_Tax_Price = try values.decodeIfPresent(String.self, forKey: .childs_Tax_Price)
        infants_Tax_Price = try values.decodeIfPresent(String.self, forKey: .infants_Tax_Price)
    }

}
