//
//  FlightDetailsModel.swift
//  BabSafar
//
//  Created by FCI on 10/10/22.
//

import Foundation

struct FlightDetailsModel : Codable {
    let status : Bool?
    let flightDetails : String?
    let priceDetails : PriceDetails?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case flightDetails = "flightDetails"
        case priceDetails = "priceDetails"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        flightDetails = try values.decodeIfPresent(String.self, forKey: .flightDetails)
        priceDetails = try values.decodeIfPresent(PriceDetails.self, forKey: .priceDetails)
    }
    
}
