//
//  HotelSearchModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation


struct HotelSearchModel : Codable {
    let filter_result_count : Int?
    let search_id : Int?
    let data : HData?
    let status : Int?
    let msg : String?
    let session_expiry_details : Session_expiry_details?

    enum CodingKeys: String, CodingKey {

        case filter_result_count = "filter_result_count"
        case search_id = "search_id"
        case data = "data"
        case status = "status"
        case msg = "msg"
        case session_expiry_details = "session_expiry_details"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        data = try values.decodeIfPresent(HData.self, forKey: .data)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
    }

}
