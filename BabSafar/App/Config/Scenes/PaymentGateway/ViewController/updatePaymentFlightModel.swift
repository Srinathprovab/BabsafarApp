//
//  updatePaymentFlightModel.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import Foundation



struct updatePaymentFlightModel : Codable {
    let status : Int?
    let msg : String?
    let data : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case data = "data"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        data = try values.decodeIfPresent(String.self, forKey: .data)
    }
    
}


struct secureBooingModel : Codable {
    let status : Int?
    let message : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case message = "message"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
        message = try values.decodeIfPresent(String.self, forKey: .message)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}





struct updateInsurenceModel : Codable {
    let status : Bool?
    let msg : String?
    let url : String?
    
    enum CodingKeys: String, CodingKey {
        
        case status = "status"
        case msg = "msg"
        case url = "url"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }
    
}
