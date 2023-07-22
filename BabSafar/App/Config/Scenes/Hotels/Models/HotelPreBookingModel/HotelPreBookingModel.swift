//
//  HotelPreBookingModel.swift
//  BabSafar
//
//  Created by FCI on 14/04/23.
//

import Foundation



struct HotelPreBookingModel : Codable {
    let status : Int?
    let msg : String?
    let data : PreBookingData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(PreBookingData.self, forKey: .data)
    }

}


