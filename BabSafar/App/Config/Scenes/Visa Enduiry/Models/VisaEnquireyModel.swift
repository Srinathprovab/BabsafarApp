//
//  VisaEnquireyModel.swift
//  BabSafar
//
//  Created by FCI on 16/02/23.
//

import Foundation
struct VisaEnquireyModel : Codable {
    let msg : String?
    let status : Int?
    let insert_id : Int?
    
    enum CodingKeys: String, CodingKey {
        
        case msg = "msg"
        case status = "status"
        case insert_id = "insert_id"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        insert_id = try values.decodeIfPresent(Int.self, forKey: .insert_id)
    }
    
}


struct SendMsgModel : Codable {
    let status : Int?
    let msg : String?
    let data : [String]?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent([String].self, forKey: .data)
    }
    
}
