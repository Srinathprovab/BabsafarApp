//
//  ProfileDetailsModel.swift
//  BabSafar
//
//  Created by FCI on 22/11/22.
//

import Foundation

struct ProfileDetailsModel : Codable {
    let status : Bool?
    let data : ProfileDetails?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(ProfileDetails.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
