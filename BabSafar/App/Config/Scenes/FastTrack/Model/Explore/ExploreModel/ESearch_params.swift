//
//  ESearch_params.swift
//  BabSafar
//
//  Created by FCI on 04/09/23.
//

import Foundation

struct ESearch_params : Codable {
    let module : String?
    let departure_date : String?
    let departure_time : String?
    let arrival_date : String?
    let arrival_time : String?
    let arrival : String?
    let from : String?
    let from_fast_track_id : String?
    let to : String?
    let to_loc_id : String?
    let to_fast_track_id : String?
    let to_loc : String?
    let from_loc : String?
    let from_loc_country : String?
    let from_loc_country_ar : String?
    let to_loc_country : String?
    let to_loc_country_ar : String?
    let from_loc_airport_city : String?
    let from_loc_airport_city_ar : String?
    let to_loc_airport_city : String?
    let to_loc_airport_city_ar : String?
    let from_loc_airport_name : String?
    let from_loc_airport_name_ar : String?
    let to_loc_airport_name : String?
    let to_loc_airport_name_ar : String?
    let total_pax : Int?
    let search_id : Int?
    let access_key : String?

    enum CodingKeys: String, CodingKey {

        case module = "module"
        case departure_date = "departure_date"
        case departure_time = "departure_time"
        case arrival_date = "arrival_date"
        case arrival_time = "arrival_time"
        case arrival = "arrival"
        case from = "from"
        case from_fast_track_id = "from_fast_track_id"
        case to = "to"
        case to_loc_id = "to_loc_id"
        case to_fast_track_id = "to_fast_track_id"
        case to_loc = "to_loc"
        case from_loc = "from_loc"
        case from_loc_country = "from_loc_country"
        case from_loc_country_ar = "from_loc_country_ar"
        case to_loc_country = "to_loc_country"
        case to_loc_country_ar = "to_loc_country_ar"
        case from_loc_airport_city = "from_loc_airport_city"
        case from_loc_airport_city_ar = "from_loc_airport_city_ar"
        case to_loc_airport_city = "to_loc_airport_city"
        case to_loc_airport_city_ar = "to_loc_airport_city_ar"
        case from_loc_airport_name = "from_loc_airport_name"
        case from_loc_airport_name_ar = "from_loc_airport_name_ar"
        case to_loc_airport_name = "to_loc_airport_name"
        case to_loc_airport_name_ar = "to_loc_airport_name_ar"
        case total_pax = "total_pax"
        case search_id = "search_id"
        case access_key = "access_key"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        module = try values.decodeIfPresent(String.self, forKey: .module)
        departure_date = try values.decodeIfPresent(String.self, forKey: .departure_date)
        departure_time = try values.decodeIfPresent(String.self, forKey: .departure_time)
        arrival_date = try values.decodeIfPresent(String.self, forKey: .arrival_date)
        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
        arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        from_fast_track_id = try values.decodeIfPresent(String.self, forKey: .from_fast_track_id)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        to_fast_track_id = try values.decodeIfPresent(String.self, forKey: .to_fast_track_id)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
        from_loc_country_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_country_ar)
        to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
        to_loc_country_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_country_ar)
        from_loc_airport_city = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_city)
        from_loc_airport_city_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_city_ar)
        to_loc_airport_city = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_city)
        to_loc_airport_city_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_city_ar)
        from_loc_airport_name = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_name)
        from_loc_airport_name_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_name_ar)
        to_loc_airport_name = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_name)
        to_loc_airport_name_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_name_ar)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
    }

}
