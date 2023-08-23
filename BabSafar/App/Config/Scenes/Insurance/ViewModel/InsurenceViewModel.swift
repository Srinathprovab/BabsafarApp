//
//  InsurenceViewModel.swift
//  BabSafar
//
//  Created by FCI on 22/08/23.
//

import Foundation



protocol InsurenceViewModelDelegate : BaseViewModelProtocol {
    func insurenceList(response : InsurenceModel)
    
}

class InsurenceViewModel {

    var view: InsurenceViewModelDelegate!
    init(_ view: InsurenceViewModelDelegate) {
        self.view = view
    }


    func CALL_MOBILE_INSURENCE_SEARCH_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobile_pre_insurance_search , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: InsurenceModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.insurenceList(response: response)
                } else {
                   
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    
    


}
