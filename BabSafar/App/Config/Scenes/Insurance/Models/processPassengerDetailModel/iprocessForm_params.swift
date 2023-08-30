//
//  iprocessForm_params.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct iprocessForm_params : Codable {
    let app_reference : String?
    let search_id : String?

    enum CodingKeys: String, CodingKey {

        case app_reference = "app_reference"
        case search_id = "search_id"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
    }

}
