

import Foundation
struct EFrom : Codable {
	let id : Int?
	let type : String?
	let sku : String?
	let name : String?
	let api_price : String?
	let currency : String?
	let price : String?
	let status : Int?
	let form_fields : [Form_fields]?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case type = "type"
		case sku = "sku"
		case name = "name"
		case api_price = "api_price"
		case currency = "currency"
		case price = "price"
		case status = "status"
		case form_fields = "form_fields"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		type = try values.decodeIfPresent(String.self, forKey: .type)
		sku = try values.decodeIfPresent(String.self, forKey: .sku)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		api_price = try values.decodeIfPresent(String.self, forKey: .api_price)
		currency = try values.decodeIfPresent(String.self, forKey: .currency)
		price = try values.decodeIfPresent(String.self, forKey: .price)
		status = try values.decodeIfPresent(Int.self, forKey: .status)
		form_fields = try values.decodeIfPresent([Form_fields].self, forKey: .form_fields)
	}

}
