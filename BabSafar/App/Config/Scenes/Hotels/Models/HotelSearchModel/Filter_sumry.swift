
import Foundation
struct Filter_sumry : Codable {
	
	let loc : [Loc]?
	let star : [Star]?
	let refund : [String]?
	let facility : [HFiltersFacility]?
	let near_by : [Near_by]?

	enum CodingKeys: String, CodingKey {

		
		case loc = "loc"
		case star = "star"
		case refund = "refund"
		case facility = "facility"
		case near_by = "near_by"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		
		loc = try values.decodeIfPresent([Loc].self, forKey: .loc)
		star = try values.decodeIfPresent([Star].self, forKey: .star)
		refund = try values.decodeIfPresent([String].self, forKey: .refund)
		facility = try values.decodeIfPresent([HFiltersFacility].self, forKey: .facility)
		near_by = try values.decodeIfPresent([Near_by].self, forKey: .near_by)
	}

}
