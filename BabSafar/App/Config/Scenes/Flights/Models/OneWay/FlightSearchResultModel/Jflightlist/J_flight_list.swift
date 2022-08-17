

import Foundation
struct J_flight_list : Codable {
	let j0 : [jl0]?
	let j1 : [jl1]?
	let j2 : [jl2]?
	let j3 : [jl3]?
	let j4 : [jl4]?
	let j5 : [jl5]?
	let j6 : [jl6]?
	let j7 : [jl7]?
	let j8 : [jl8]?
	let j9 : [jl9]?
	let j10 : [jl10]?
	let j11 : [jl11]?
	let j12 : [jl12]?
	let j13 : [jl13]?
	let j14 : [jl14]?
	let j15 : [jl15]?
	let j16 : [jl16]?
	let j17 : [jl17]?
	let j18 : [jl18]?
	let j19 : [[jl19]]?
	let j20 : [jl20]?
	let j21 : [jl21]?
	let j22 : [jl22]?
	let j23 : [jl23]?
	let j24 : [jl24]?
	let j25 : [jl25]?
	let j26 : [jl26]?
	let j27 : [jl27]?
	let j28 : [jl28]?
	let j29 : [jl29]?
	let j30 : [jl30]?
	let j31 : [jl31]?
	let j32 : [jl32]?
	let more_results : [More_results]?

	enum CodingKeys: String, CodingKey {

		case j0 = "0"
		case j1 = "1"
		case j2 = "2"
		case j3 = "3"
		case j4 = "4"
		case j5 = "5"
		case j6 = "6"
		case j7 = "7"
		case j8 = "8"
		case j9 = "9"
		case j10 = "10"
		case j11 = "11"
		case j12 = "12"
		case j13 = "13"
		case j14 = "14"
		case j15 = "15"
		case j16 = "16"
		case j17 = "17"
		case j18 = "18"
		case j19 = "19"
		case j20 = "20"
		case j21 = "21"
		case j22 = "22"
		case j23 = "23"
		case j24 = "24"
		case j25 = "25"
		case j26 = "26"
		case j27 = "27"
		case j28 = "28"
		case j29 = "29"
		case j30 = "30"
		case j31 = "31"
		case j32 = "32"
		case more_results = "more_results"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		j0 = try values.decodeIfPresent([jl0].self, forKey: .j0)
		j1 = try values.decodeIfPresent([jl1].self, forKey: .j1)
		j2 = try values.decodeIfPresent([jl2].self, forKey: .j2)
		j3 = try values.decodeIfPresent([jl3].self, forKey: .j3)
		j4 = try values.decodeIfPresent([jl4].self, forKey: .j4)
		j5 = try values.decodeIfPresent([jl5].self, forKey: .j5)
        j6 = try values.decodeIfPresent([jl6].self, forKey: .j6)
		j7 = try values.decodeIfPresent([jl7].self, forKey: .j7)
		j8 = try values.decodeIfPresent([jl8].self, forKey: .j8)
		j9 = try values.decodeIfPresent([jl9].self, forKey: .j9)
		j10 = try values.decodeIfPresent([jl10].self, forKey: .j10)
		j11 = try values.decodeIfPresent([jl11].self, forKey: .j11)
		j12 = try values.decodeIfPresent([jl12].self, forKey: .j12)
		j13 = try values.decodeIfPresent([jl13].self, forKey: .j13)
		j14 = try values.decodeIfPresent([jl14].self, forKey: .j14)
		j15 = try values.decodeIfPresent([jl15].self, forKey: .j15)
		j16 = try values.decodeIfPresent([jl16].self, forKey: .j16)
		j17 = try values.decodeIfPresent([jl17].self, forKey: .j17)
		j18 = try values.decodeIfPresent([jl18].self, forKey: .j18)
		j19 = try values.decodeIfPresent([[jl19]].self, forKey: .j19)
		j20 = try values.decodeIfPresent([jl20].self, forKey: .j20)
		j21 = try values.decodeIfPresent([jl21].self, forKey: .j21)
		j22 = try values.decodeIfPresent([jl22].self, forKey: .j22)
		j23 = try values.decodeIfPresent([jl23].self, forKey: .j23)
		j24 = try values.decodeIfPresent([jl24].self, forKey: .j24)
		j25 = try values.decodeIfPresent([jl25].self, forKey: .j25)
		j26 = try values.decodeIfPresent([jl26].self, forKey: .j26)
		j27 = try values.decodeIfPresent([jl27].self, forKey: .j27)
		j28 = try values.decodeIfPresent([jl28].self, forKey: .j28)
		j29 = try values.decodeIfPresent([jl29].self, forKey: .j29)
		j30 = try values.decodeIfPresent([jl30].self, forKey: .j30)
		j31 = try values.decodeIfPresent([jl31].self, forKey: .j31)
		j32 = try values.decodeIfPresent([jl32].self, forKey: .j32)
		more_results = try values.decodeIfPresent([More_results].self, forKey: .more_results)
	}

}
