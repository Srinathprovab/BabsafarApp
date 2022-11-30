//
//  AllCountryCodeListModel.swift
//  BabSafar
//
//  Created by FCI on 30/11/22.
//


import Foundation
struct AllCountryCodeListModel : Codable {
    let all_country_code_list : [All_country_code_list]?

    enum CodingKeys: String, CodingKey {

        case all_country_code_list = "all_country_code_list"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        all_country_code_list = try values.decodeIfPresent([All_country_code_list].self, forKey: .all_country_code_list)
    }

}
