//
//  FCol_x.swift
//  BabSafar
//
//  Created by FCI on 24/08/23.
//

import Foundation


struct FCol_x : Codable {
    let search_params : FSearch_params?
    let attr : Attr?
    let list : FList?
    let search_id : String?
    let booking_source_key : String?
    let booking_source : String?

    enum CodingKeys: String, CodingKey {

        case search_params = "search_params"
        case attr = "attr"
        case list = "list"
        case search_id = "search_id"
        case booking_source_key = "booking_source_key"
        case booking_source = "booking_source"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        search_params = try values.decodeIfPresent(FSearch_params.self, forKey: .search_params)
        attr = try values.decodeIfPresent(Attr.self, forKey: .attr)
        list = try values.decodeIfPresent(FList.self, forKey: .list)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
    }

}
