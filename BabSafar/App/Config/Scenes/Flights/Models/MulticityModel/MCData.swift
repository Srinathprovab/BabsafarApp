//
//  MCData.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCData : Codable {
    let booking_source_key : String?
    let booking_source : String?
    let col_2x_result : Bool?
    let journey_id : Int?
    let j_flight_list : [[MCJ_flight_list]]?
    let is_domestic : Bool?
    let search_id : Int?
    let traceId : String?
    let search_params : MCSearch_params?
    let pxtrip_type : String?
   

    enum CodingKeys: String, CodingKey {

        case booking_source_key = "booking_source_key"
        case booking_source = "booking_source"
        case col_2x_result = "col_2x_result"
        case journey_id = "journey_id"
        case j_flight_list = "j_flight_list"
        case is_domestic = "is_domestic"
        case search_id = "search_id"
        case traceId = "traceId"
        case search_params = "search_params"
        case pxtrip_type = "pxtrip_type"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        col_2x_result = try values.decodeIfPresent(Bool.self, forKey: .col_2x_result)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        j_flight_list = try values.decodeIfPresent([[MCJ_flight_list]].self, forKey: .j_flight_list)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        traceId = try values.decodeIfPresent(String.self, forKey: .traceId)
        search_params = try values.decodeIfPresent(MCSearch_params.self, forKey: .search_params)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)

    }

}
