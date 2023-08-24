//
//  FasttrackModel.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import Foundation


struct FasttrackModel : Codable {
    let fasttrackdata : Fasttrackdata?
    let msg : String?
    let status : Int?
    let session_expiry_details : ISession_expiry_details?

    enum CodingKeys: String, CodingKey {

        case fasttrackdata = "fasttrackdata"
        case msg = "msg"
        case status = "status"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        fasttrackdata = try values.decodeIfPresent(Fasttrackdata.self, forKey: .fasttrackdata)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        session_expiry_details = try values.decodeIfPresent(ISession_expiry_details.self, forKey: .session_expiry_details)
    }

}
