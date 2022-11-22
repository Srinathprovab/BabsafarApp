//
//  ProfileDetailsViewModel.swift
//  BabSafar
//
//  Created by FCI on 22/11/22.
//

import Foundation


protocol ProfileDetailsViewModelDelegate : BaseViewModelProtocol {
    func getProfileDetails(response : ProfileDetailsModel)
    func updateProfileDetails(response : ProfileDetailsModel)
}

class ProfileDetailsViewModel {
    
    
    var view: ProfileDetailsViewModelDelegate!
    init(_ view: ProfileDetailsViewModelDelegate) {
        self.view = view
    }
    
    
    func CallGetProileDetails_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.getApiCall(endPoint: ApiEndpoints.mobileprofile,urlParams: parms as? Dictionary<String, String> , parameters: parms as NSDictionary, resultType: ProfileDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getProfileDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    func UpdateProfileDetails(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobileprofile , parameters: parms as NSDictionary, resultType: ProfileDetailsModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.updateProfileDetails(response: response)
                } else {
                    // Show alert
                    print("error = \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
}
