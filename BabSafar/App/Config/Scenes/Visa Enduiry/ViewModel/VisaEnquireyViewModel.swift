//
//  VisaEnquireyViewModel.swift
//  BabSafar
//
//  Created by FCI on 16/02/23.
//

import Foundation




protocol VisaEnquireyViewModelDelegate : BaseViewModelProtocol {
    func visaenquirySucessDetails(response : VisaEnquireyModel)
}

class VisaEnquireyViewModel {
    
    var view: VisaEnquireyViewModelDelegate!
    init(_ view: VisaEnquireyViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_VISA_ENQUIRY_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "visa/\(ApiEndpoints.visaenquiry)", parameters: parms as NSDictionary, resultType: VisaEnquireyModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.visaenquirySucessDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
