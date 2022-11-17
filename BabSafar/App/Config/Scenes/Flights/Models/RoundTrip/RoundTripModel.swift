//
//  RoundTripModel.swift
//  BabSafar
//
//  Created by FCI on 07/10/22.
//

import Foundation


struct RoundTripModel : Codable {
    
//    let raw_flight_list : RTRaw_flight_list?
//    let search_id : Int?
//    let session_id : String?
//    let cabin_class : String?
//    let booking_url : String?
//    let booking_source : String?
//    let trip_type : String?
//    let attr : RTAttr?
//    let route_count : Int?
//    let isDomestic : Bool?
//    let search_type : String?
//    let domestic_round_way_flight : Bool?
//    let sr : String?
    let status : Int?

    enum CodingKeys: String, CodingKey {

//        case raw_flight_list = "raw_flight_list"
//        case search_id = "search_id"
//        case session_id = "session_id"
//        case cabin_class = "cabin_class"
//        case booking_url = "booking_url"
//        case booking_source = "booking_source"
//        case trip_type = "trip_type"
//        case attr = "attr"
//        case route_count = "route_count"
//        case isDomestic = "IsDomestic"
//        case search_type = "search_type"
//        case domestic_round_way_flight = "domestic_round_way_flight"
//        case sr = "sr"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
//        raw_flight_list = try values.decodeIfPresent(RTRaw_flight_list.self, forKey: .raw_flight_list)
//        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
//        session_id = try values.decodeIfPresent(String.self, forKey: .session_id)
//        cabin_class = try values.decodeIfPresent(String.self, forKey: .cabin_class)
//        booking_url = try values.decodeIfPresent(String.self, forKey: .booking_url)
//        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
//        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
//        attr = try values.decodeIfPresent(RTAttr.self, forKey: .attr)
//        route_count = try values.decodeIfPresent(Int.self, forKey: .route_count)
//        isDomestic = try values.decodeIfPresent(Bool.self, forKey: .isDomestic)
//        search_type = try values.decodeIfPresent(String.self, forKey: .search_type)
//        domestic_round_way_flight = try values.decodeIfPresent(Bool.self, forKey: .domestic_round_way_flight)
//        sr = try values.decodeIfPresent(String.self, forKey: .sr)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
    }

}
