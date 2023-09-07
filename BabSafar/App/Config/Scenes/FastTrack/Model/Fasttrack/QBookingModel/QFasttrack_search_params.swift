//
//  QFasttrack_search_params.swift
//  BabSafar
//
//  Created by FCI on 07/09/23.
//

import Foundation


struct QFasttrack_search_params : Codable {
    let from_loc_airport_name_ar : String?
    let child_config : String?
    let search_id : String?
    let arrival_time : String?
    let from_fast_track_id : String?
    let to_loc_airport_city_ar : String?
    let to_loc : String?
    let departure_time : String?
    let arrival : String?
    let from_loc_airport_city : String?
    let to_loc_airport_name : String?
    let departure_date : String?
    let to_loc_airport_name_ar : String?
    let total_pax : Int?
    let arrival_date : String?
    let to_fast_track_id : String?
    let to : String?
    let to_loc_country_ar : String?
    let to_loc_airport_city : String?
    let from_loc_airport_name : String?
    let from : String?
    let to_loc_id : String?
    let from_loc_country : String?
    let from_loc_id : String?
    let from_loc_country_ar : String?
    let module : String?
    let to_loc_country : String?
    let from_loc : String?
    let from_loc_airport_city_ar : String?
    let adult_config : String?

    enum CodingKeys: String, CodingKey {

        case from_loc_airport_name_ar = "from_loc_airport_name_ar"
        case child_config = "child_config"
        case search_id = "search_id"
        case arrival_time = "arrival_time"
        case from_fast_track_id = "from_fast_track_id"
        case to_loc_airport_city_ar = "to_loc_airport_city_ar"
        case to_loc = "to_loc"
        case departure_time = "departure_time"
        case arrival = "arrival"
        case from_loc_airport_city = "from_loc_airport_city"
        case to_loc_airport_name = "to_loc_airport_name"
        case departure_date = "departure_date"
        case to_loc_airport_name_ar = "to_loc_airport_name_ar"
        case total_pax = "total_pax"
        case arrival_date = "arrival_date"
        case to_fast_track_id = "to_fast_track_id"
        case to = "to"
        case to_loc_country_ar = "to_loc_country_ar"
        case to_loc_airport_city = "to_loc_airport_city"
        case from_loc_airport_name = "from_loc_airport_name"
        case from = "from"
        case to_loc_id = "to_loc_id"
        case from_loc_country = "from_loc_country"
        case from_loc_id = "from_loc_id"
        case from_loc_country_ar = "from_loc_country_ar"
        case module = "module"
        case to_loc_country = "to_loc_country"
        case from_loc = "from_loc"
        case from_loc_airport_city_ar = "from_loc_airport_city_ar"
        case adult_config = "adult_config"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        from_loc_airport_name_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_name_ar)
        child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
        from_fast_track_id = try values.decodeIfPresent(String.self, forKey: .from_fast_track_id)
        to_loc_airport_city_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_city_ar)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        departure_time = try values.decodeIfPresent(String.self, forKey: .departure_time)
        arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
        from_loc_airport_city = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_city)
        to_loc_airport_name = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_name)
        departure_date = try values.decodeIfPresent(String.self, forKey: .departure_date)
        to_loc_airport_name_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_name_ar)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        arrival_date = try values.decodeIfPresent(String.self, forKey: .arrival_date)
        to_fast_track_id = try values.decodeIfPresent(String.self, forKey: .to_fast_track_id)
        to = try values.decodeIfPresent(String.self, forKey: .to)
        to_loc_country_ar = try values.decodeIfPresent(String.self, forKey: .to_loc_country_ar)
        to_loc_airport_city = try values.decodeIfPresent(String.self, forKey: .to_loc_airport_city)
        from_loc_airport_name = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_name)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        from_loc_country_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_country_ar)
        module = try values.decodeIfPresent(String.self, forKey: .module)
        to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        from_loc_airport_city_ar = try values.decodeIfPresent(String.self, forKey: .from_loc_airport_city_ar)
        adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
    }

}
