//
//  AllCountryCodeListViewModel.swift
//  BabSafar
//
//  Created by FCI on 30/11/22.
//

import Foundation



protocol AllCountryCodeListViewModelDelegate : BaseViewModelProtocol {
    func getCountryList(response : AllCountryCodeListModel)
}

class AllCountryCodeListViewModel {

    var view: AllCountryCodeListViewModelDelegate!
    init(_ view: AllCountryCodeListViewModelDelegate) {
        self.view = view
    }


    func CALLGETCOUNTRYLIST_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")

        self.view?.showLoader()

        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.getCountryList , parameters: parms, resultType: AllCountryCodeListModel.self, p:dictParam) { sucess, result, errorMessage in

            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.getCountryList(response: response)
                } else {
                    // Show alert
                    NotificationCenter.default.post(name: NSNotification.Name("nointernet"), object: errorMessage)
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    

}
