//
//  RTFareDetails.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation


import Foundation
struct RTFareDetails : Codable {
    let b2c_PriceDetails : RTB2c_PriceDetails?
    let api_PriceDetails : RTApi_PriceDetails?

    enum CodingKeys: String, CodingKey {

        case b2c_PriceDetails = "b2c_PriceDetails"
        case api_PriceDetails = "api_PriceDetails"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        b2c_PriceDetails = try values.decodeIfPresent(RTB2c_PriceDetails.self, forKey: .b2c_PriceDetails)
        api_PriceDetails = try values.decodeIfPresent(RTApi_PriceDetails.self, forKey: .api_PriceDetails)
    }

}
