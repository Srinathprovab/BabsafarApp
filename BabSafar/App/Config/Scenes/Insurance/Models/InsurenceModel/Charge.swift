
import Foundation
struct Charge : Codable {
	let sequenceNo : String?
	let rateType : String?
	let percentageValue : Double?
	let amountValue : Double?

	enum CodingKeys: String, CodingKey {

		case sequenceNo = "SequenceNo"
		case rateType = "RateType"
		case percentageValue = "PercentageValue"
		case amountValue = "AmountValue"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		sequenceNo = try values.decodeIfPresent(String.self, forKey: .sequenceNo)
		rateType = try values.decodeIfPresent(String.self, forKey: .rateType)
		percentageValue = try values.decodeIfPresent(Double.self, forKey: .percentageValue)
		amountValue = try values.decodeIfPresent(Double.self, forKey: .amountValue)
	}

}
