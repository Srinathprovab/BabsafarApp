
import Foundation
struct Reward_total_report : Codable {
	let used_reward : String?
	let pending_rewardpoint : String?

	enum CodingKeys: String, CodingKey {

		case used_reward = "used_reward"
		case pending_rewardpoint = "pending_rewardpoint"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		used_reward = try values.decodeIfPresent(String.self, forKey: .used_reward)
		pending_rewardpoint = try values.decodeIfPresent(String.self, forKey: .pending_rewardpoint)
	}

}
