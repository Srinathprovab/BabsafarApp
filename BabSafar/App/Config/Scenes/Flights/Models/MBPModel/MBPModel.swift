//
//  MBPModel.swift
//  BabSafar
//
//  Created by FCI on 06/12/22.
//

import Foundation


struct MBPModel : Codable {
    let status : Bool?
    let message : String?
    let data : MBPData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case message = "message"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        data = try values.decodeIfPresent(MBPData.self, forKey: .data)
    }

}
