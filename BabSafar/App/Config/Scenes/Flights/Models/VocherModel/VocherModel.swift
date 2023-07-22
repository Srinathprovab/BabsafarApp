//
//  VocherModel.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation


struct VocherModel : Codable {
    let data : VocherModelDetails?
    let cancelltion_policy : String?
    let city_data_list : [City_data_list]?
    let item : String?

    enum CodingKeys: String, CodingKey {

        case data = "data"
        case cancelltion_policy = "cancelltion_policy"
        case city_data_list = "city_data_list"
        case item = "item"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        data = try values.decodeIfPresent(VocherModelDetails.self, forKey: .data)
        cancelltion_policy = try values.decodeIfPresent(String.self, forKey: .cancelltion_policy)
        city_data_list = try values.decodeIfPresent([City_data_list].self, forKey: .city_data_list)
        item = try values.decodeIfPresent(String.self, forKey: .item)
    }

}
