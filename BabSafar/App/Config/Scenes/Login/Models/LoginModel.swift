//
//  LoginModel.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import Foundation
struct LoginModel : Codable {
    let status : Bool?
    let data : String?
    let user_id : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
    }

}
