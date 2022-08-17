

import Foundation
struct MoreResultFare : Codable {
    let faremore_results : FareMore_results?

    enum CodingKeys: String, CodingKey {

        case faremore_results = "more_results"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        faremore_results = try values.decodeIfPresent(FareMore_results.self, forKey: .faremore_results)
    }

}
