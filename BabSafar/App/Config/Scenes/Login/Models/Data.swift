
import Foundation
struct UserRegisterDetails : Codable {
	let user_id : String?
    let status : Int?
	
    
	enum CodingKeys: String, CodingKey {

		case user_id = "user_id"
        case status = "status"
		
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		user_id = try values.decodeIfPresent(String.self, forKey: .user_id)
        status = try values.decodeIfPresent(Int.self, forKey: .status)
		
	}

}
