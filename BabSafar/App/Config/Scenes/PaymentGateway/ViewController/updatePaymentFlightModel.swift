//
//  updatePaymentFlightModel.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import Foundation



struct updatePaymentFlightModel : Codable {
    let status : Int?
    let msg : String?
    let data : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}
