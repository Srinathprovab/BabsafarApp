//
//  FareRulesModelViewModel.swift
//  BabSafar
//
//  Created by FCI on 15/02/23.
//

import Foundation



protocol FareRulesModelViewModelDelegate : BaseViewModelProtocol {
    func fareRulesDetails(response:FareRulesModel)
}

class FareRulesModelViewModel {
    
    var view: FareRulesModelViewModelDelegate!
    init(_ view: FareRulesModelViewModelDelegate) {
        self.view = view
    }
    
    
    //MARK:  CALL_GET_FARE_RULES_API
    func CALL_GET_FARE_RULES_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "ajax/\(ApiEndpoints.getfarerules)" , parameters: parms, resultType: FareRulesModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                //    self.view.fareRulesDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    
}
