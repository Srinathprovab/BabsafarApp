//
//  Postdata.swift
//  BabSafar
//
//  Created by FCI on 14/04/23.
//

import Foundation

struct Postdata : Codable {
    let appreference : String?
    let searchid : String?
    let apicurrency : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case appreference = "appreference"
        case searchid = "searchid"
        case apicurrency = "apicurrency"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appreference = try values.decodeIfPresent(String.self, forKey: .appreference)
        searchid = try values.decodeIfPresent(String.self, forKey: .searchid)
        apicurrency = try values.decodeIfPresent(String.self, forKey: .apicurrency)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
