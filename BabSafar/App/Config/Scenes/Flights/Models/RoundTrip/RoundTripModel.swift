//
//  RoundTripModel.swift
//  BabSafar
//
//  Created by FCI on 07/10/22.
//

import Foundation

struct RoundTripModel : Codable {
    
    let data : RTData?
    let msg : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case msg = "msg"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(RTData.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
