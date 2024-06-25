//
//  AirlinelistModel.swift
//  BabSafar
//
//  Created by Admin on 25/06/24.
//

import Foundation
struct AirlinelistModel : Codable {
    let status : Bool?
    let data : [AirlinelistData]?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent([AirlinelistData].self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}



struct AirlinelistData : Codable {
    let code : String?
    let name : String?
    let name_ar : String?

    enum CodingKeys: String, CodingKey {

        case code = "code"
        case name = "name"
        case name_ar = "name_ar"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        code = try values.decodeIfPresent(String.self, forKey: .code)
        name = try values.decodeIfPresent(String.self, forKey: .name)
        name_ar = try values.decodeIfPresent(String.self, forKey: .name_ar)
    }

}
