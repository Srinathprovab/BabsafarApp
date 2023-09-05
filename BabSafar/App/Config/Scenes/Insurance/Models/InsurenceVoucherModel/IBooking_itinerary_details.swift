//
//  IBooking_itinerary_details.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation

struct IBooking_itinerary_details : Codable {
    let origin : String?
    let app_reference : String?
    let booking_source : String?
    let from_loc : String?
    let to_loc : String?
    let dep_airline : String?
    let dep_airline_num : String?
    let dep_date : String?
    let dep_time : String?
    let arrival_airline : String?
    let arrival_airline_number : String?
    let arrival_date : String?
    let arrival_time : String?
    let booking_id : String?
    let total_traveller : String?
    let airline_pnr : String?
    let status : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case from_loc = "from_loc"
        case to_loc = "to_loc"
        case dep_airline = "dep_airline"
        case dep_airline_num = "dep_airline_num"
        case dep_date = "dep_date"
        case dep_time = "dep_time"
        case arrival_airline = "arrival_airline"
        case arrival_airline_number = "arrival_airline_number"
        case arrival_date = "arrival_date"
        case arrival_time = "arrival_time"
        case booking_id = "booking_id"
        case total_traveller = "total_traveller"
        case airline_pnr = "airline_pnr"
        case status = "status"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        dep_airline = try values.decodeIfPresent(String.self, forKey: .dep_airline)
        dep_airline_num = try values.decodeIfPresent(String.self, forKey: .dep_airline_num)
        dep_date = try values.decodeIfPresent(String.self, forKey: .dep_date)
        dep_time = try values.decodeIfPresent(String.self, forKey: .dep_time)
        arrival_airline = try values.decodeIfPresent(String.self, forKey: .arrival_airline)
        arrival_airline_number = try values.decodeIfPresent(String.self, forKey: .arrival_airline_number)
        arrival_date = try values.decodeIfPresent(String.self, forKey: .arrival_date)
        arrival_time = try values.decodeIfPresent(String.self, forKey: .arrival_time)
        booking_id = try values.decodeIfPresent(String.self, forKey: .booking_id)
        total_traveller = try values.decodeIfPresent(String.self, forKey: .total_traveller)
        airline_pnr = try values.decodeIfPresent(String.self, forKey: .airline_pnr)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
