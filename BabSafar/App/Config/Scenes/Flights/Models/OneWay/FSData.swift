//
//  FSData.swift
//  BabSafar
//
//  Created by FCI on 06/10/22.
//

import Foundation

struct FSData : Codable {
    let attr : Attr?
    let search_id : Int?
    let pxtrip_type : String?
    let is_domestic : Bool?
    let journey_id : Int?
    let traceId : String?
    let col_2x_result : Bool?
    let j_flight_list : [[J_flight_list]]?
    let search_params : Search_params?

    enum CodingKeys: String, CodingKey {

        case attr = "attr"
        case search_id = "search_id"
        case pxtrip_type = "pxtrip_type"
        case is_domestic = "is_domestic"
        case journey_id = "journey_id"
        case traceId = "traceId"
        case col_2x_result = "col_2x_result"
        case j_flight_list = "j_flight_list"
        case search_params = "search_params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        attr = try values.decodeIfPresent(Attr.self, forKey: .attr)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
        col_2x_result = try values.decodeIfPresent(Bool.self, forKey: .col_2x_result)
        j_flight_list = try values.decodeIfPresent([[J_flight_list]].self, forKey: .j_flight_list)
        search_params = try values.decodeIfPresent(Search_params.self, forKey: .search_params)
    }

}
