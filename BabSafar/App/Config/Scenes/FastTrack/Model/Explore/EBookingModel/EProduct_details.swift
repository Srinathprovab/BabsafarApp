//
//  EProduct_details.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation


struct EProduct_details : Codable {
    let status : Bool?
    let data : ProductData?

    enum CodingKeys: String, CodingKey {

        case status = "status"
        case data = "data"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        status = try values.decodeIfPresent(Bool.self, forKey: .status)
        data = try values.decodeIfPresent(ProductData.self, forKey: .data)
    }

}
