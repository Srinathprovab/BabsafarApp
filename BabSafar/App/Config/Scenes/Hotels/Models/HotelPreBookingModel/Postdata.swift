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
    let pg_record : Pg_record?

    enum CodingKeys: String, CodingKey {

        case appreference = "appreference"
        case searchid = "searchid"
        case apicurrency = "apicurrency"
        case pg_record = "pg_record"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        appreference = try values.decodeIfPresent(String.self, forKey: .appreference)
        searchid = try values.decodeIfPresent(String.self, forKey: .searchid)
        apicurrency = try values.decodeIfPresent(String.self, forKey: .apicurrency)
        pg_record = try values.decodeIfPresent(Pg_record.self, forKey: .pg_record)
    }

}
