//
//  LogoutViewModel.swift
//  BabSafar
//
//  Created by FCI on 23/02/23.
//

import Foundation



protocol LogoutViewModelDelegate : BaseViewModelProtocol {
    func logoutSucessDetails(response : LogoutModel)
}

class LogoutViewModel {
    
    
    var view: LogoutViewModelDelegate!
    init(_ view: LogoutViewModelDelegate) {
        self.view = view
    }
    
    
    func CALL_MOBILE_USER_LOGOUT_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobilelogout)" , parameters: parms as NSDictionary, resultType: LogoutModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.logoutSucessDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
