//
//  ResetPasswordViewModel.swift
//  BabSafar
//
//  Created by FCI on 07/02/23.
//

import Foundation

protocol ForgetPasswordViewModelDelegate : BaseViewModelProtocol {
    func forgetPasswordSucessDetails(response : ForgetPasswordModel)
}

class ForgetPasswordViewModel {
    
    
    var view: ForgetPasswordViewModelDelegate!
    init(_ view: ForgetPasswordViewModelDelegate) {
        self.view = view
    }
    
    
    func CallForgetPasswordAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "auth/\(ApiEndpoints.mobileforgotpassword)" , parameters: parms as NSDictionary, resultType: ForgetPasswordModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.forgetPasswordSucessDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}
