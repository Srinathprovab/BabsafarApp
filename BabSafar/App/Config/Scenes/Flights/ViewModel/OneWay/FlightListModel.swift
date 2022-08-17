import Foundation
import Alamofire


protocol FlightListModelProtocal : BaseViewModelProtocol {
    func flightList(response : FlightSearchResultModel)
}

class FlightListModel {
    
    var view: FlightListModelProtocal!
    init(_ view: FlightListModelProtocal) {
        self.view = view
    }
    
    
    func CallSearchFlightAPI(dictParam: [String: Any]){
        let parms = NSDictionary(dictionary:dictParam)
        print("Parameters = \(parms)")
        
        self.view?.showLoader()
        
        ServiceManager.postOrPutApiCall(endPoint: ApiEndpoints.mobilePreFlightSearch , urlParams: parms as? Dictionary<String, String>, parameters: parms, resultType: FlightSearchResultModel.self, p:dictParam) { sucess, result, errorMessage in
            
            DispatchQueue.main.async {
                self.view?.hideLoader()
                if sucess {
                    guard let response = result else {return}
                    self.view.flightList(response: response)
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
