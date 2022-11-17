//
//  RTApi_PriceDetails.swift
//  BabSafar
//
//  Created by FCI on 16/11/22.
//

import Foundation

struct RTApi_PriceDetails : Codable {
    let currency : String?
    let baseFare : Int?
    let tax : Int?
    let publishedFare : Int?
    let agentCommission : Int?
    let agentTdsOnCommision : Int?
    let offeredFare : Int?

    enum CodingKeys: String, CodingKey {

        case currency = "Currency"
        case baseFare = "BaseFare"
        case tax = "Tax"
        case publishedFare = "PublishedFare"
        case agentCommission = "AgentCommission"
        case agentTdsOnCommision = "AgentTdsOnCommision"
        case offeredFare = "OfferedFare"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        baseFare = try values.decodeIfPresent(Int.self, forKey: .baseFare)
        tax = try values.decodeIfPresent(Int.self, forKey: .tax)
        publishedFare = try values.decodeIfPresent(Int.self, forKey: .publishedFare)
        agentCommission = try values.decodeIfPresent(Int.self, forKey: .agentCommission)
        agentTdsOnCommision = try values.decodeIfPresent(Int.self, forKey: .agentTdsOnCommision)
        offeredFare = try values.decodeIfPresent(Int.self, forKey: .offeredFare)
    }

}
