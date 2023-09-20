//
//  TotalPremiumViewModel.swift
//  BabSafar
//
//  Created by FCI on 19/09/23.
//

import Foundation

protocol TotalPremiumViewModelDelegate : BaseViewModelProtocol {
    func totalPremimumDetails(response : TotalPremiumModel)
}

class TotalPremiumViewModel {

    var view: TotalPremiumViewModelDelegate!
    init(_ view: TotalPremiumViewModelDelegate) {
        self.view = view
    }

    
    func CALL_TOTALPREMIMUM_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.insurance_pre_process_booking, parameters: parms, resultType: TotalPremiumModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.totalPremimumDetails(response: response)
                } else {

                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }

}
