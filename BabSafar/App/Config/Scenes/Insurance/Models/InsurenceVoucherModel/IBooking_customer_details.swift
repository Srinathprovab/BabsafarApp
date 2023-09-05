//
//  IBooking_customer_details.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation

struct IBooking_customer_details : Codable {
    let origin : String?
    let app_reference : String?
    let booking_source : String?
    let pax_index : String?
    let title : String?
    let first_name : String?
    let last_name : String?
    let type : String?
    let gender : String?
    let dob : String?
    let passport_number : String?
    let passport_expiry : String?
    let passport_issuing_country : String?
    let passport_nationality : String?
    let booking_details : String?
    let status : String?
    let created_at : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case booking_source = "booking_source"
        case pax_index = "pax_index"
        case title = "title"
        case first_name = "first_name"
        case last_name = "last_name"
        case type = "type"
        case gender = "gender"
        case dob = "dob"
        case passport_number = "passport_number"
        case passport_expiry = "passport_expiry"
        case passport_issuing_country = "passport_issuing_country"
        case passport_nationality = "passport_nationality"
        case booking_details = "booking_details"
        case status = "status"
        case created_at = "created_at"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        booking_source = try values.decodeIfPresent(String.self, forKey: .booking_source)
        pax_index = try values.decodeIfPresent(String.self, forKey: .pax_index)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        type = try values.decodeIfPresent(String.self, forKey: .type)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        dob = try values.decodeIfPresent(String.self, forKey: .dob)
        passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
        passport_expiry = try values.decodeIfPresent(String.self, forKey: .passport_expiry)
        passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
        passport_nationality = try values.decodeIfPresent(String.self, forKey: .passport_nationality)
        booking_details = try values.decodeIfPresent(String.self, forKey: .booking_details)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        created_at = try values.decodeIfPresent(String.self, forKey: .created_at)
    }

}
