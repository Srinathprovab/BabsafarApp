//
//  HSearchData.swift
//  BabSafar
//
//  Created by FCI on 01/09/23.
//

import Foundation

struct HSearchData : Codable {
    let adult_config : [String]?
    let nationality : String?
    let country_name : String?
    let from_date : String?
    let total_pax_count : Int?
    let hotel_destination : String?
    let hotel_checkin_date : String?
    let hotel_checkout_date : String?
    let to_date : String?
    let is_domestic : Bool?
    let location : String?
    let room_count : Int?
    let hotel_code : String?
    let search_id : Int?
    let city_name : String?
    let no_of_nights : Int?
    let location_ar : String?
    let child_config : [String]?

    enum CodingKeys: String, CodingKey {

        case adult_config = "adult_config"
        case nationality = "nationality"
        case country_name = "country_name"
        case from_date = "from_date"
        case total_pax_count = "total_pax_count"
        case hotel_destination = "hotel_destination"
        case hotel_checkin_date = "hotel_checkin_date"
        case hotel_checkout_date = "hotel_checkout_date"
        case to_date = "to_date"
        case is_domestic = "is_domestic"
        case location = "location"
        case room_count = "room_count"
        case hotel_code = "hotel_code"
        case search_id = "search_id"
        case city_name = "city_name"
        case no_of_nights = "no_of_nights"
        case location_ar = "location_ar"
        case child_config = "child_config"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        adult_config = try values.decodeIfPresent([String].self, forKey: .adult_config)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        from_date = try values.decodeIfPresent(String.self, forKey: .from_date)
        total_pax_count = try values.decodeIfPresent(Int.self, forKey: .total_pax_count)
        hotel_destination = try values.decodeIfPresent(String.self, forKey: .hotel_destination)
        hotel_checkin_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkin_date)
        hotel_checkout_date = try values.decodeIfPresent(String.self, forKey: .hotel_checkout_date)
        to_date = try values.decodeIfPresent(String.self, forKey: .to_date)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        location = try values.decodeIfPresent(String.self, forKey: .location)
        room_count = try values.decodeIfPresent(Int.self, forKey: .room_count)
        hotel_code = try values.decodeIfPresent(String.self, forKey: .hotel_code)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        no_of_nights = try values.decodeIfPresent(Int.self, forKey: .no_of_nights)
        location_ar = try values.decodeIfPresent(String.self, forKey: .location_ar)
        child_config = try values.decodeIfPresent([String].self, forKey: .child_config)
    }

}
