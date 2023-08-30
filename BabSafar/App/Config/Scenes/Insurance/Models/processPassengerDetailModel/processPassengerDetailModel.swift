//
//  processPassengerDetailModel.swift
//  BabSafar
//
//  Created by FCI on 29/08/23.
//

import Foundation

struct processPassengerDetailModel : Codable {
    let form_url : String?
    let form_method : String?
    let form_params : iprocessForm_params?

    enum CodingKeys: String, CodingKey {

        case form_url = "form_url"
        case form_method = "form_method"
        case form_params = "form_params"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        form_url = try values.decodeIfPresent(String.self, forKey: .form_url)
        form_method = try values.decodeIfPresent(String.self, forKey: .form_method)
        form_params = try values.decodeIfPresent(iprocessForm_params.self, forKey: .form_params)
    }

}
