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
    let fareRulehtml : String?
    
    enum CodingKeys: String, CodingKey {

        case status = "status"
        case flightDetails = "flightDetails"
        case priceDetails = "priceDetails"
        case fareRulehtml = "fareRulehtml"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        flightDetails = try values.decodeIfPresent([[FDFlightDetails]].self, forKey: .flightDetails)
        priceDetails = try values.decodeIfPresent(FDPriceDetails.self, forKey: .priceDetails)
        fareRulehtml = try values.decodeIfPresent(String.self, forKey: .fareRulehtml)

    }

}
