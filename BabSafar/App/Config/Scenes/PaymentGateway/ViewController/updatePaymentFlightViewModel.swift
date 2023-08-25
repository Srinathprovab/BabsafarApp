//
//  updatePaymentFlightViewModel.swift
//  BabSafar
//
//  Created by FCI on 25/08/23.
//

import Foundation


protocol updatePaymentFlightViewModelDelegate : BaseViewModelProtocol {
    func updatePaymentSucess(response : updatePaymentFlightModel)
}

class updatePaymentFlightViewModel {

    var view: updatePaymentFlightViewModelDelegate!
    init(_ view: updatePaymentFlightViewModelDelegate) {
        self.view = view
    }


    func CALL_UPDATE_PAYMENT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.flightupdatePayment ,parameters: parms, resultType: updatePaymentFlightModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.updatePaymentSucess(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}
