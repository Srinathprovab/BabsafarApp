//
//  ShowTravellerByOriginModel.swift
//  BabSafar
//
//  Created by FCI on 26/02/23.
//

import Foundation
struct ShowTravellerByOriginModel : Codable {
    let status : Bool?
    let data : TravellerDataByOrigin?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(TravellerDataByOrigin.self, forKey: .data)
    }
    
}



struct TravellerDataByOrigin : Codable {
    let origin : String?
    let user_id : String?
    let passanger_type : String?
    let title : String?
    let first_name : String?
    let last_name : String?
    let date_of_birth : String?
    let gender : String?
    let email : String?
    let passport_user_name : String?
    let passport_nationality : String?
    let passport_expiry_date : String?
    let passport_number : String?
    let passport_issuing_country : String?
    let visibility_status : String?
    let created_by_id : String?
    let created_datetime : String?
    let updated_by_id : String?
    let updated_datetime : String?
    let passport_nationality_detail : String?
    let passport_issuing_country_name : String?
    
    enum CodingKeys: String, CodingKey {
        
        case origin = "origin"
        case user_id = "user_id"
        case passanger_type = "passanger_type"
        case title = "title"
        case first_name = "first_name"
        case last_name = "last_name"
        case date_of_birth = "date_of_birth"
        case gender = "gender"
        case email = "email"
        case passport_user_name = "passport_user_name"
        case passport_nationality = "passport_nationality"
        case passport_expiry_date = "passport_expiry_date"
        case passport_number = "passport_number"
        case passport_issuing_country = "passport_issuing_country"
        case visibility_status = "visibility_status"
        case created_by_id = "created_by_id"
        case created_datetime = "created_datetime"
        case updated_by_id = "updated_by_id"
        case updated_datetime = "updated_datetime"
        case passport_nationality_detail = "passport_nationality_detail"
        case passport_issuing_country_name = "passport_issuing_country_name"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        origin = try values.decodeIfPresent(String.self, forKey: .origin)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        passanger_type = try values.decodeIfPresent(String.self, forKey: .passanger_type)
        title = try values.decodeIfPresent(String.self, forKey: .title)
        first_name = try values.decodeIfPresent(String.self, forKey: .first_name)
        last_name = try values.decodeIfPresent(String.self, forKey: .last_name)
        date_of_birth = try values.decodeIfPresent(String.self, forKey: .date_of_birth)
        gender = try values.decodeIfPresent(String.self, forKey: .gender)
        email = try values.decodeIfPresent(String.self, forKey: .email)
        passport_user_name = try values.decodeIfPresent(String.self, forKey: .passport_user_name)
        passport_nationality = try values.decodeIfPresent(String.self, forKey: .passport_nationality)
        passport_expiry_date = try values.decodeIfPresent(String.self, forKey: .passport_expiry_date)
        passport_number = try values.decodeIfPresent(String.self, forKey: .passport_number)
        passport_issuing_country = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country)
        visibility_status = try values.decodeIfPresent(String.self, forKey: .visibility_status)
        created_by_id = try values.decodeIfPresent(String.self, forKey: .created_by_id)
        created_datetime = try values.decodeIfPresent(String.self, forKey: .created_datetime)
        updated_by_id = try values.decodeIfPresent(String.self, forKey: .updated_by_id)
        updated_datetime = try values.decodeIfPresent(String.self, forKey: .updated_datetime)
        passport_nationality_detail = try values.decodeIfPresent(String.self, forKey: .passport_nationality_detail)
        passport_issuing_country_name = try values.decodeIfPresent(String.self, forKey: .passport_issuing_country_name)
    }
    
}
