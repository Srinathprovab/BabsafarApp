//
//  HotelSearchModel.swift
//  BabSafar
//
//  Created by FCI on 16/12/22.
//

import Foundation


struct HotelSearchModel : Codable {
    let data : HData?
    let offset : Int?
    let msg : String?
    let filter_result_count : Int?
    let search_id : String?
    let session_expiry_details : Session_expiry_details?
    let status : Int?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case offset = "offset"
        case msg = "msg"
        case filter_result_count = "filter_result_count"
        case search_id = "search_id"
        case session_expiry_details = "session_expiry_details"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(HData.self, forKey: .data)
        offset = try values.decodeIfPresent(Int.self, forKey: .offset)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        filter_result_count = try values.decodeIfPresent(Int.self, forKey: .filter_result_count)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        session_expiry_details = try values.decodeIfPresent(Session_expiry_details.self, forKey: .session_expiry_details)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
