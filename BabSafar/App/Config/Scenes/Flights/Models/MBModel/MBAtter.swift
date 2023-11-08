//
//  MBAtter.swift
//  BabSafar
//
//  Created by FCI on 16/10/23.
//

import Foundation

struct MBAtter : Codable {
    let isRefundable : Bool?
    let airlineRemark : String?
   

    enum CodingKeys: String, CodingKey {

        case isRefundable = "IsRefundable"
        case airlineRemark = "AirlineRemark"
       
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        isRefundable = try values.decodeIfPresent(Bool.self, forKey: .isRefundable)
        airlineRemark = try values.decodeIfPresent(String.self, forKey: .airlineRemark)
       
    }

}

