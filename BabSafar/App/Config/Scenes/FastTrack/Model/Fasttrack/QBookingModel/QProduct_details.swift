//
//  QProduct_details.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation

struct QProduct_details : Codable {
    let status : Bool?
    let data : QData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(QData.self, forKey: .data)
    }

}
