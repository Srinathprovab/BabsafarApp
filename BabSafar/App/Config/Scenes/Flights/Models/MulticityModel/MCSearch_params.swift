//
//  MCSearch_params.swift
//  BabSafar
//
//  Created by FCI on 14/10/22.
//

import Foundation

struct MCSearch_params : Codable {
    let child_config : String?
    let is_domestic : Bool?
    let v_class : String?
    let infant_config : String?
    let ret_jrn : String?
    let to_loc : [String]?
    let total_pax : Int?
    let trip_type : String?
    let depature : [String]?
    let to : [String]?
    let carrier : String?
    let deal_type : String?
    let from : [String]?
    let to_loc_id : [String]?
    let out_jrn : String?
    let from_loc_id : [String]?
    let access_key : String?
    let adult_config : String?
    let trip_type_label : String?
    let from_loc : [String]?

    enum CodingKeys: String, CodingKey {

        case child_config = "child_config"
        case is_domestic = "is_domestic"
        case v_class = "v_class"
        case infant_config = "infant_config"
        case ret_jrn = "ret_jrn"
        case to_loc = "to_loc"
        case total_pax = "total_pax"
        case trip_type = "trip_type"
        case depature = "depature"
        case to = "to"
        case carrier = "carrier"
        case deal_type = "deal_type"
        case from = "from"
        case to_loc_id = "to_loc_id"
        case out_jrn = "out_jrn"
        case from_loc_id = "from_loc_id"
        case access_key = "access_key"
        case adult_config = "adult_config"
        case trip_type_label = "trip_type_label"
        case from_loc = "from_loc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
        is_domestic = try values.decodeIfPresent(Bool.self, forKey: .is_domestic)
        v_class = try values.decodeIfPresent(String.self, forKey: .v_class)
        infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
        ret_jrn = try values.decodeIfPresent(String.self, forKey: .ret_jrn)
        to_loc = try values.decodeIfPresent([String].self, forKey: .to_loc)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        depature = try values.decodeIfPresent([String].self, forKey: .depature)
        to = try values.decodeIfPresent([String].self, forKey: .to)
        carrier = try values.decodeIfPresent(String.self, forKey: .carrier)
        deal_type = try values.decodeIfPresent(String.self, forKey: .deal_type)
        from = try values.decodeIfPresent([String].self, forKey: .from)
        to_loc_id = try values.decodeIfPresent([String].self, forKey: .to_loc_id)
        out_jrn = try values.decodeIfPresent(String.self, forKey: .out_jrn)
        from_loc_id = try values.decodeIfPresent([String].self, forKey: .from_loc_id)
        access_key = try values.decodeIfPresent(String.self, forKey: .access_key)
        adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
        trip_type_label = try values.decodeIfPresent(String.self, forKey: .trip_type_label)
        from_loc = try values.decodeIfPresent([String].self, forKey: .from_loc)
    }

}
