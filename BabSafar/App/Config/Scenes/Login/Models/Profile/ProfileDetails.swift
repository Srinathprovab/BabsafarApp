//
//  ProfileDetails.swift
//  BabSafar
//
//  Created by FCI on 22/11/22.
//

import Foundation

struct ProfileDetails : Codable {
    
    let gender : String?
    let first_name : String?
    let last_name : String?
    let phone : String?
    let email : String?
    let address : String?
    let address2 : String?
    let country_name : String?
    let state_name : String?
    let city_name : String?
    let pin_code : String?
    let date_of_birth : String?
    let image : String?

    enum CodingKeys: String, CodingKey {

        case gender = "gender"
        case first_name = "first_name"
        case last_name = "last_name"
        case phone = "phone"
        case email = "email"
        case address = "address"
        case address2 = "address2"
        case country_name = "country_name"
        case state_name = "state_name"
        case city_name = "city_name"
        case pin_code = "pin_code"
        case date_of_birth = "date_of_birth"
        case image = "image"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        phone = try values.decodeIfPresent(String.self, forKey: .phone)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        address = try values.decodeIfPresent(String.self, forKey: .address)
        address2 = try values.decodeIfPresent(String.self, forKey: .address2)
        country_name = try values.decodeIfPresent(String.self, forKey: .country_name)
        state_name = try values.decodeIfPresent(String.self, forKey: .state_name)
        city_name = try values.decodeIfPresent(String.self, forKey: .city_name)
        pin_code = try values.decodeIfPresent(String.self, forKey: .pin_code)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        image = try values.decodeIfPresent(String.self, forKey: .image)
    }

}
