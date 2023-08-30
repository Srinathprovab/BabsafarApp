//
//  HCustomer_details.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct HCustomer_details : Codable {
    let origin : String?
    let app_reference : String?
    let title : String?
    let first_name : String?
    let middle_name : String?
    let last_name : String?
    let phone : String?
    let email : String?
    let pax_type : String?
    let age : String?
    let date_of_birth : String?
    let passenger_nationality : String?
    let passport_number : String?
    let passport_issuing_country : String?
    let passport_expiry_date : String?
    let room_id : String?
    let status : String?
    let attributes : String?
    let nationality : String?

    enum CodingKeys: String, CodingKey {

        case origin = "origin"
        case app_reference = "app_reference"
        case title = "title"
        case first_name = "first_name"
        case middle_name = "middle_name"
        case last_name = "last_name"
        case phone = "phone"
        case email = "email"
        case pax_type = "pax_type"
        case age = "age"
        case date_of_birth = "date_of_birth"
        case passenger_nationality = "passenger_nationality"
        case passport_number = "passport_number"
        case passport_issuing_country = "passport_issuing_country"
        case passport_expiry_date = "passport_expiry_date"
        case room_id = "room_id"
        case status = "status"
        case attributes = "attributes"
        case nationality = "nationality"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        middle_name = try values.decodeIfPresent(String.self, forKey: .middle_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        pax_type = try values.decodeIfPresent(String.self, forKey: .pax_type)
        age = try values.decodeIfPresent(String.self, forKey: .age)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        passenger_nationality = try values.decodeIfPresent(String.self, forKey: .passenger_nationality)
        passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
        passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
        passport_expiry_date = try values.decodeIfPresent(String.self, forKey: .passport_expiry_date)
        room_id = try values.decodeIfPresent(String.self, forKey: .room_id)
        status = try values.decodeIfPresent(String.self, forKey: .status)
        attributes = try values.decodeIfPresent(String.self, forKey: .attributes)
        nationality = try values.decodeIfPresent(String.self, forKey: .nationality)
    }

}
