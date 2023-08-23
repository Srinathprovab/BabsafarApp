
import Foundation
struct AvailablePlans : Codable {
    let planCode : String?
    let sSRFeeCode : String?
    let currencyCode : String?
    let totalPremiumAmount : Double?
    let totalCoverageAmount : String?
    let planPremiumChargeType : String?
    let planTitle : String?
    let plan_image : String?
    let planDesc : String?
    let planMarketingPointers : PlanMarketingPointers?
    let planAdditionalInfoTitle : String?
    let planAdditionalInfoDesc : String?
    let planYesDesc : String?
    let planNoDesc : String?
    let planNoConsideration : String?
    let planTnC : String?
    let isDefaultPlan : String?
    let planContent : [PlanContent]?
    let planQualifiedPassengers : String?
    let planPricingBreakdown : PlanPricingBreakdown?
    let planType : String?
    let up_sell_plan : Bool?
    let currency : String?
    let plan_details_token : String?
    
    enum CodingKeys: String, CodingKey {
        
        case planCode = "PlanCode"
        case sSRFeeCode = "SSRFeeCode"
        case currencyCode = "CurrencyCode"
        case totalPremiumAmount = "TotalPremiumAmount"
        case totalCoverageAmount = "TotalCoverageAmount"
        case planPremiumChargeType = "PlanPremiumChargeType"
        case planTitle = "PlanTitle"
        case plan_image = "plan_image"
        case planDesc = "PlanDesc"
        case planMarketingPointers = "PlanMarketingPointers"
        case planAdditionalInfoTitle = "PlanAdditionalInfoTitle"
        case planAdditionalInfoDesc = "PlanAdditionalInfoDesc"
        case planYesDesc = "PlanYesDesc"
        case planNoDesc = "PlanNoDesc"
        case planNoConsideration = "PlanNoConsideration"
        case planTnC = "PlanTnC"
        case isDefaultPlan = "IsDefaultPlan"
        case planContent = "PlanContent"
        case planQualifiedPassengers = "PlanQualifiedPassengers"
        case planPricingBreakdown = "PlanPricingBreakdown"
        case planType = "PlanType"
        case up_sell_plan = "up_sell_plan"
        case currency = "Currency"
        case plan_details_token = "plan_details_token"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        planCode = try values.decodeIfPresent(String.self, forKey: .planCode)
        sSRFeeCode = try values.decodeIfPresent(String.self, forKey: .sSRFeeCode)
        currencyCode = try values.decodeIfPresent(String.self, forKey: .currencyCode)
        totalPremiumAmount = try values.decodeIfPresent(Double.self, forKey: .totalPremiumAmount)
        totalCoverageAmount = try values.decodeIfPresent(String.self, forKey: .totalCoverageAmount)
        planPremiumChargeType = try values.decodeIfPresent(String.self, forKey: .planPremiumChargeType)
        planTitle = try values.decodeIfPresent(String.self, forKey: .planTitle)
        plan_image = try values.decodeIfPresent(String.self, forKey: .plan_image)
        planDesc = try values.decodeIfPresent(String.self, forKey: .planDesc)
        planMarketingPointers = try values.decodeIfPresent(PlanMarketingPointers.self, forKey: .planMarketingPointers)
        planAdditionalInfoTitle = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoTitle)
        planAdditionalInfoDesc = try values.decodeIfPresent(String.self, forKey: .planAdditionalInfoDesc)
        planYesDesc = try values.decodeIfPresent(String.self, forKey: .planYesDesc)
        planNoDesc = try values.decodeIfPresent(String.self, forKey: .planNoDesc)
        planNoConsideration = try values.decodeIfPresent(String.self, forKey: .planNoConsideration)
        planTnC = try values.decodeIfPresent(String.self, forKey: .planTnC)
        isDefaultPlan = try values.decodeIfPresent(String.self, forKey: .isDefaultPlan)
        planContent = try values.decodeIfPresent([PlanContent].self, forKey: .planContent)
        planQualifiedPassengers = try values.decodeIfPresent(String.self, forKey: .planQualifiedPassengers)
        planPricingBreakdown = try values.decodeIfPresent(PlanPricingBreakdown.self, forKey: .planPricingBreakdown)
        planType = try values.decodeIfPresent(String.self, forKey: .planType)
        up_sell_plan = try values.decodeIfPresent(Bool.self, forKey: .up_sell_plan)
        currency = try values.decodeIfPresent(String.self, forKey: .currency)
        plan_details_token = try values.decodeIfPresent(String.self, forKey: .plan_details_token)
    }
    
}
