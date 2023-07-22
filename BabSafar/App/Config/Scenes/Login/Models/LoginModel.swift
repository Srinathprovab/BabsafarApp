//
//  LoginModel.swift
//  BabSafar
//
//  Created by MA673 on 27/07/22.
//

import Foundation


struct LoginModel : Codable {
    let status : Bool?
    let data : String?
    let user_id : String?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        case user_id = "user_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
    }

}


struct LogoutModel : Codable {
    let status : Bool?
    let data : String?
    

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
        
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }

}



struct RegisterModel : Codable {
    let status : Bool?
    let data : UserRegisterDetails?
    let msg :String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case data = "data"
        case msg = "message"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(UserRegisterDetails.self, forKey: .data)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }
    
}




struct ForgetPasswordModel : Codable {
    let data : String?
    let status : Bool?
    
    enum CodingKeys: String, CodingKey {
        case data = "data"
        case status = "status"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(String.self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        
    }

}




