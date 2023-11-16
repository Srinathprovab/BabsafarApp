//
//  HotelSearchNewModel.swift
//  BabSafar
//
//  Created by FCI on 09/11/23.
//

import Foundation

struct HotelSearchNewModel : Codable {
    
    let status : Bool?
    let msg : String?
    let search_id : Int?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case msg = "msg"
        case search_id = "search_id"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
