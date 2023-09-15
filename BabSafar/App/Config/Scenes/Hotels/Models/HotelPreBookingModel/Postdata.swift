//
//  Postdata.swift
//  BabSafar
//
//  Created by FCI on 14/04/23.
//

import Foundation

struct Postdata : Codable {
    let pg_record : Pg_record?
    let apicurrency : String?
    let searchid : String?
    let appreference : String?
    let url : String?

    enum CodingKeys: String, CodingKey {

        case pg_record = "pg_record"
        case apicurrency = "apicurrency"
        case searchid = "searchid"
        case appreference = "appreference"
        case url = "url"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        pg_record = try values.decodeIfPresent(Pg_record.self, forKey: .pg_record)
        apicurrency = try values.decodeIfPresent(String.self, forKey: .apicurrency)
        searchid = try values.decodeIfPresent(String.self, forKey: .searchid)
        appreference = try values.decodeIfPresent(String.self, forKey: .appreference)
        url = try values.decodeIfPresent(String.self, forKey: .url)
    }

}
