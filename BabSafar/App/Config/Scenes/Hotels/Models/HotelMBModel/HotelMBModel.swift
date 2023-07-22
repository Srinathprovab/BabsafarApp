//
//  HotelMBModel.swift
//  BabSafar
//
//  Created by FCI on 27/03/23.
//

import Foundation

import Foundation
struct HotelMBModel : Codable {
    let status : Int?
    let msg : String?
    let data : HMBData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(HMBData.self, forKey: .data)
    }

}
