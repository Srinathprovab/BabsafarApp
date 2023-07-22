//
//  FDModel.swift
//  BabSafar
//
//  Created by FCI on 18/11/22.
//


import Foundation
struct FDModel : Codable {
    let status : Bool?
    let flightDetails : [[FDFlightDetails]]?
    let priceDetails : FDPriceDetails?
    let fareRulehtml : [FareRulehtml]?
    let fare_rule_ref_key : String?
    let farerulesref_content : String?
    let journeySummary : [JourneySummary]?
    let baggage_details : [Baggage_details]?
    
    
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case flightDetails = "flightDetails"
        case priceDetails = "priceDetails"
        case fareRulehtml = "fareRulehtml"
        case fare_rule_ref_key = "fare_rule_ref_key"
        case farerulesref_content = "farerulesref_content"
        case journeySummary = "journeySummary"
        case baggage_details = "baggage_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        flightDetails = try values.decodeIfPresent([[FDFlightDetails]].self, forKey: .flightDetails)
        priceDetails = try values.decodeIfPresent(FDPriceDetails.self, forKey: .priceDetails)
        fareRulehtml = try values.decodeIfPresent([FareRulehtml].self, forKey: .fareRulehtml)
        fare_rule_ref_key = try values.decodeIfPresent(String.self, forKey: .fare_rule_ref_key)
        farerulesref_content = try values.decodeIfPresent(String.self, forKey: .farerulesref_content)
        journeySummary = try values.decodeIfPresent([JourneySummary].self, forKey: .journeySummary)
        baggage_details = try values.decodeIfPresent([Baggage_details].self, forKey: .baggage_details)

    }

}



