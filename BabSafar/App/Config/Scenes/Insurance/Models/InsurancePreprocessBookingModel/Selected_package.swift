
import Foundation
struct Selected_package : Codable {
    let planTitle : String?
    let planQualifiedPassengers : String?
    let planCode : String?
    let totalCoverageAmount : String?
    let planPremiumChargeType : String?
    let planTnC : String?
    let totalPremiumAmount : String?
    let planDesc : String?
    let planNoConsideration : String?
    let planPricingBreakdown : PlanPricingBreakdown?
    let planYesDesc : String?
    let up_sell_plan : Bool?
    let planNoDesc : String?
    let sSRFeeCode : String?
    let planContent : String?
    let currencyCode : String?
    let planAdditionalInfoDesc : String?
    let currency : String?
    let isDefaultPlan : String?
    let price : Price?
    let planType : String?
    let planAdditionalInfoTitle : String?

    enum CodingKeys: String, CodingKey {

        case planTitle = "PlanTitle"
        case planQualifiedPassengers = "PlanQualifiedPassengers"
        case planCode = "PlanCode"
        case totalCoverageAmount = "TotalCoverageAmount"
        case planPremiumChargeType = "PlanPremiumChargeType"
        case planTnC = "PlanTnC"
        case totalPremiumAmount = "TotalPremiumAmount"
        case planDesc = "PlanDesc"
        case planNoConsideration = "PlanNoConsideration"
        case planPricingBreakdown = "PlanPricingBreakdown"
        case planYesDesc = "PlanYesDesc"
        case up_sell_plan = "up_sell_plan"
        case planNoDesc = "PlanNoDesc"
        case sSRFeeCode = "SSRFeeCode"
        case planContent = "PlanContent"
        case currencyCode = "CurrencyCode"
        case planAdditionalInfoDesc = "PlanAdditionalInfoDesc"
        case currency = "Currency"
        case isDefaultPlan = "IsDefaultPlan"
        case price = "price"
        case planType = "PlanType"
        case planAdditionalInfoTitle = "PlanAdditionalInfoTitle"
    }

    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        planTitle = try values.decodeIfPresent(String.self, forKey: .planTitle)
        planQualifiedPassengers = try values.decodeIfPresent(String.self, forKey: .planQualifiedPassengers)
        planCode = try values.decodeIfPresent(String.self, forKey: .planCode)
        totalCoverageAmount = try values.decodeIfPresent(String.self, forKey: .totalCoverageAmount)
        planPremiumChargeType = try values.decodeIfPresent(String.self, forKey: .planPremiumChargeType)
        planTnC = try values.decodeIfPresent(String.self, forKey: .planTnC)
        totalPremiumAmount = try values.decodeIfPresent(String.self, forKey: .totalPremiumAmount)
        planDesc = try values.decodeIfPresent(String.self, forKey: .planDesc)
        planNoConsideration = try values.decodeIfPresent(String.self, forKey: .planNoConsideration)
        planPricingBreakdown = try values.decodeIfPresent(PlanPricingBreakdown.self, forKey: .planPricingBreakdown)
        planYesDesc = try values.decodeIfPresent(String.self, forKey: .planYesDesc)
        up_sell_plan = try values.decodeIfPresent(Bool.self, forKey: .up_sell_plan)
        planNoDesc = try values.decodeIfPresent(String.self, forKey: .planNoDesc)
        sSRFeeCode = try values.decodeIfPresent(String.self, forKey: .sSRFeeCode)
        planContent = try values.decodeIfPresent(String.self, forKey: .planContent)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        planAdditionalInfoDesc = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoDesc)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        isDefaultPlan = try values.decodeIfPresent(String.self, forKey: .isDefaultPlan)
        price = try values.decodeIfPresent(Price.self, forKey: .price)
        planType = try values.decodeIfPresent(String.self, forKey: .planType)
        planAdditionalInfoTitle = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoTitle)
    }

}
