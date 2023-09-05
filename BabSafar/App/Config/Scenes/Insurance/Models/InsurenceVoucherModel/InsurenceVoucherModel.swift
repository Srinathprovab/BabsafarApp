//
//  InsurenceVoucherModel.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation


struct InsurenceVoucherModel : Codable {
    
    let data : InsurenceVoucherData?
    let item : String?
    let email : Bool?
    let api_message : Bool?
    let insurance_data : Insurance_data?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case item = "item"
        case api_message = "api_message"
        case insurance_data = "insurance_data"
        case email = "email"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(InsurenceVoucherData.self, forKey: .data)
        item = try values.decodeIfPresent(String.self, forKey: .item)
        api_message = try values.decodeIfPresent(Bool.self, forKey: .api_message)
        insurance_data = try values.decodeIfPresent(Insurance_data.self, forKey: .insurance_data)
        email = try values.decodeIfPresent(Bool.self, forKey: .email)
    }

}

