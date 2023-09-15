
import Foundation
struct Filter_sumry : Codable {
    let facility : [HFiltersFacility]?
    let near_by : [Near_by]?
    let currency : HCurrency?
    let loc : [Loc]?

    enum CodingKeys: String, CodingKey {

       
        case facility = "facility"
        case near_by = "near_by"
        case currency = "currency"
        case loc = "loc"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)

        facility = try values.decodeIfPresent([HFiltersFacility].self, forKey: .facility)
        near_by = try values.decodeIfPresent([Near_by].self, forKey: .near_by)
        currency = try values.decodeIfPresent(HCurrency.self, forKey: .currency)
        loc = try values.decodeIfPresent([Loc].self, forKey: .loc)
    }

}
