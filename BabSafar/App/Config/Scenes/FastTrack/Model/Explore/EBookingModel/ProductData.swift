//
//  ProductData.swift
//  BabSafar
//
//  Created by FCI on 05/09/23.
//

import Foundation


struct ProductData : Codable {
    
    let from : EFrom?

    enum CodingKeys: String, CodingKey {

        case from = "from"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        from = try values.decodeIfPresent(EFrom.self, forKey: .from)
    }

}
