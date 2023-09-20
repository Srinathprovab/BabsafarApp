
import Foundation
struct Search_data : Codable {
    let to_loc : String?
    let child_config : String?
    let from_loc_id : String?
    let adult_config : String?
    let trip_type : String?
    let to_loc_id : String?
    let from_loc : String?
    let from_loc_country : String?
    let from : String?
    let infant_config : String?
    let search_id : Int?
    let to_loc_country : String?
    let total_pax : Int?
    let depature : String?
    let arrival : String?
    let to : String?

    enum CodingKeys: String, CodingKey {

        case to_loc = "to_loc"
        case child_config = "child_config"
        case from_loc_id = "from_loc_id"
        case adult_config = "adult_config"
        case trip_type = "trip_type"
        case to_loc_id = "to_loc_id"
        case from_loc = "from_loc"
        case from_loc_country = "from_loc_country"
        case from = "from"
        case infant_config = "infant_config"
        case search_id = "search_id"
        case to_loc_country = "to_loc_country"
        case total_pax = "total_pax"
        case depature = "depature"
        case arrival = "arrival"
        case to = "to"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        to_loc = try values.decodeIfPresent(String.self, forKey: .to_loc)
        child_config = try values.decodeIfPresent(String.self, forKey: .child_config)
        from_loc_id = try values.decodeIfPresent(String.self, forKey: .from_loc_id)
        adult_config = try values.decodeIfPresent(String.self, forKey: .adult_config)
        trip_type = try values.decodeIfPresent(String.self, forKey: .trip_type)
        to_loc_id = try values.decodeIfPresent(String.self, forKey: .to_loc_id)
        from_loc = try values.decodeIfPresent(String.self, forKey: .from_loc)
        from_loc_country = try values.decodeIfPresent(String.self, forKey: .from_loc_country)
        from = try values.decodeIfPresent(String.self, forKey: .from)
        infant_config = try values.decodeIfPresent(String.self, forKey: .infant_config)
        search_id = try values.decodeIfPresent(Int.self, forKey: .search_id)
        to_loc_country = try values.decodeIfPresent(String.self, forKey: .to_loc_country)
        total_pax = try values.decodeIfPresent(Int.self, forKey: .total_pax)
        depature = try values.decodeIfPresent(String.self, forKey: .depature)
        arrival = try values.decodeIfPresent(String.self, forKey: .arrival)
        to = try values.decodeIfPresent(String.self, forKey: .to)
    }

}


