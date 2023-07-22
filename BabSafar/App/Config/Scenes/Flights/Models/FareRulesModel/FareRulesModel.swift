//
//  FareRulesModel.swift
//  BabSafar
//
//  Created by FCI on 15/02/23.
//

import Foundation


struct FareRulesModel : Codable {
    let data : [FareRulesData]?
    let status : Int?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([FareRulesData].self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
