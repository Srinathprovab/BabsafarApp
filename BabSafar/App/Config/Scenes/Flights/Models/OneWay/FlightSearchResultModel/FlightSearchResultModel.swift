//
//  FlightSearchResultModel.swift
//  BabSafar
//
//  Created by MA673 on 09/08/22.
//

import Foundation

struct FlightSearchResultModel : Codable {
    
    let col_2x_result : Bool?
    let search_params : Search_params?
    let attr : Attr?
    let search_id : Int?
    let booking_url : String?
    let booking_source_key : String?
    let booking_source : String?
    let j_flight_list : J_flight_list?
    let journey_id : Int?
    let airlinersapi : Airlinersapi?
    let pxtrip_type : String?
    let boarditnow_fare_rule : Boarditnow_fare_rule?
    
    enum CodingKeys: String, CodingKey {
        
        case col_2x_result = "col_2x_result"
        case search_params = "search_params"
        case attr = "attr"
        case search_id = "search_id"
        case booking_url = "booking_url"
        case booking_source_key = "booking_source_key"
        case booking_source = "booking_source"
        case j_flight_list = "j_flight_list"
        case journey_id = "journey_id"
        case airlinersapi = "airlinersapi"
        case pxtrip_type = "pxtrip_type"
        case boarditnow_fare_rule = "boarditnow_fare_rule"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        col_2x_result = try values.decodeIfPresent(Bool.self, forKey: .col_2x_result)
        search_params = try values.decodeIfPresent(Search_params.self, forKey: .search_params)
        attr = try values.decodeIfPresent(Attr.self, forKey: .attr)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        booking_url = try values.decodeIfPresent(String.self, forKey: .booking_url)
        booking_source_key = try values.decodeIfPresent(String.self, forKey: .booking_source_key)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        j_flight_list = try values.decodeIfPresent(J_flight_list.self, forKey: .j_flight_list)
        journey_id = try values.decodeIfPresent(Int.self, forKey: .journey_id)
        airlinersapi = try values.decodeIfPresent(Airlinersapi.self, forKey: .airlinersapi)
        pxtrip_type = try values.decodeIfPresent(String.self, forKey: .pxtrip_type)
        boarditnow_fare_rule = try values.decodeIfPresent(Boarditnow_fare_rule.self, forKey: .boarditnow_fare_rule)
    }
    
}
