//
//  CurrencyListModel.swift
//  BestFares365App
//
//  Created by FCI on 16/02/23.
//

import Foundation



struct CurrencyListModel : Codable {
    let data : [CurrencyListData]?
    let status : Bool?
    let msg : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case status = "status"
        case msg = "msg"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent([CurrencyListData].self, forKey: .data)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        msg = try values.decodeIfPresent(String.self, forKey: .msg)
    }

}
