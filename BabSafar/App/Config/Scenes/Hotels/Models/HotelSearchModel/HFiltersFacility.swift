//
//  HFiltersFacility.swift
//  BabSafar
//
//  Created by FCI on 04/09/23.
//

import Foundation

struct HFiltersFacility : Codable {
    let c : Int?
    let v : String?
    let icon : String?
    let cstr : String?
    let cstr_inf : String?

    enum CodingKeys: String, CodingKey {

        case c = "c"
        case v = "v"
        case icon = "icon"
        case cstr = "cstr"
        case cstr_inf = "cstr_inf"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        c = try values.decodeIfPresent(Int.self, forKey: .c)
        v = try values.decodeIfPresent(String.self, forKey: .v)
        icon = try values.decodeIfPresent(String.self, forKey: .icon)
        cstr = try values.decodeIfPresent(String.self, forKey: .cstr)
        cstr_inf = try values.decodeIfPresent(String.self, forKey: .cstr_inf)
    }

}
