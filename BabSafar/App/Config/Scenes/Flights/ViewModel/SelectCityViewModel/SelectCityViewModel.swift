import Foundation
import Alamofire


protocol SelectCityViewModelProtocal : BaseViewModelProtocol {
    func ShowCityList(response : [SelectCityModel])
    func ShowCityListMulticity(response : [SelectCityModel])
}

class SelectCityViewModel {
    
    var view: SelectCityViewModelProtocal!
    init(_ view: SelectCityViewModelProtocal) {
        self.view = view
    }
    
    
    func CallShowCityListAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "ajax/\(ApiEndpoints.getairportcodelist)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [SelectCityModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.ShowCityList(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
    
    
    func CallShowCityList_multicity_API(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
      //  self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: "ajax/\(ApiEndpoints.getairportcodelistmulticity)" , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: [SelectCityModel].self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
            //    self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.ShowCityListMulticity(response: response)
                } else {
                    // Show alert
                    //  print("error === \(errorMessage ?? "")")
                    self.view.showToast(message: errorMessage ?? "")
                }
            }
        }
    }
    
    
}
