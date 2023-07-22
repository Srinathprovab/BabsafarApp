//
//  AboutusViewModel.swift
//  BabSafar
//
//  Created by FCI on 16/02/23.
//

import Foundation



protocol AboutusViewModelDelegate : BaseViewModelProtocol {
    func aboutusDetails(response:AboutUsModel)
    func termsandcobditionDetails(response:AboutUsModel)
    func privacyPolicyDetails(response:AboutUsModel)
    func contactDetals(response:ContactUsModel)
}

class AboutusViewModel {
    
    var view: AboutusViewModelDelegate!
    init(_ view: AboutusViewModelDelegate) {
        self.view = view
    }
    
    
   
    
    
    
    //MARK:  CALL_GET_ABOUTUS_API
    func CALL_GET_ABOUTUS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: AboutUsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.aboutusDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_GET_TERMSANDCONDITION_API
    func CALL_GET_TERMSANDCONDITION_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: AboutUsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.termsandcobditionDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    //MARK:  CALL_GET_PRIVICYPOLICY_API
    func CALL_GET_PRIVICYPOLICY_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: url,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: AboutUsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.privacyPolicyDetails(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
  
    func CALL_CONTACTUS_API(dictParam: [String: Any],url:String){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: url,urlParams: parms as? Dictionary<String, String> , parameters: parms, resultType: ContactUsModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.contactDetals(response: response)
                } else {
                    // Show alert
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
