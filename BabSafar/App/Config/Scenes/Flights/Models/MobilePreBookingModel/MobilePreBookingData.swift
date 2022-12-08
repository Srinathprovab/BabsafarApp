//
//  MobilePreBookingData.swift
//  BabSafar
//
//  Created by FCI on 08/12/22.
//

import Foundation

struct MobilePreBookingData : Codable {
    let form_url : String?
    let search_id : String?
    let app_reference : String?
    let promocode_val : String?

    enum CodingKeys: String, CodingKey {

        case form_url = "form_url"
        case search_id = "search_id"
        case app_reference = "app_reference"
        case promocode_val = "promocode_val"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        search_id = try values.decodeIfPresent(String.self, forKey: .search_id)
        app_reference = try values.decodeIfPresent(String.self, forKey: .app_reference)
        promocode_val = try values.decodeIfPresent(String.self, forKey: .promocode_val)
    }

}
