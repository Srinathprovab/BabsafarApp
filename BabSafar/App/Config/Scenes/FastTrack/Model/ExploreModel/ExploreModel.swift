//
//  ExploreModel.swift
//  BabSafar
//
//  Created by FCI on 04/09/23.
//

import Foundation

struct ExploreModel : Codable {
    let fasttrackdata : FasttrackExporedata?
    let msg : String?
    let status : Int?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case fasttrackdata = "fasttrackdata"
        case msg = "msg"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fasttrackdata = try values.decodeIfPresent(FasttrackExporedata.self, forKey: .fasttrackdata)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}
