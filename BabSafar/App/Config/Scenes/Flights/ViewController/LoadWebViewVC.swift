//
//  LoadWebViewVC.swift
//  AlghanimTravelApp
//
//  Created by FCI on 29/09/22.
//

import UIKit
import WebKit
import SwiftyJSON

class LoadWebViewVC: UIViewController, MobilsPaymentGatwayViewModelDelegate, MobileSecureBookingViewModelDelegate {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: LoadWebViewVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoadWebViewVC
        return vc
    }
    
    
    var urlString = String()
    var titleString = String()
    var apicallbool = true
    var isVcFrom = String()
    var viewmodel:MobilsPaymentGatwayViewModel?
    var viewmodel1:MobileSecureBookingViewModel?
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        callapibool = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loderBool = false
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        
        print("<<<<<<<=== urlString ==>>>>>>\n \(urlString)")
        if let url1 = URL(string: urlString) {
            webview.load(URLRequest(url: url1))
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: NSNotification.Name("nointernet"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadscreen), name: NSNotification.Name("reloadscreen"), object: nil)
        
    }
    
    
    
    
    //MARK: - nointernet
    
    @objc func nointernet(){
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        present(vc, animated: true)
    }
    
    @objc func reloadscreen(){
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = MobilsPaymentGatwayViewModel(self)
        viewmodel1 = MobileSecureBookingViewModel(self)
    }
    
    
    func setupUI() {
        
        holderView.backgroundColor = .WhiteColor
        nav.backgroundColor = .AppBtnColor
        nav.titlelbl.text = "Payment"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        webview.navigationDelegate = self
        webview.isUserInteractionEnabled = true
        
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        //dismiss(animated: true)
        //        guard let vc = SearchFlightsVC.newInstance.self else {return}
        //        vc.modalPresentationStyle = .fullScreen
        //        vc.isfromVc = "dashboard"
        //        present(vc, animated: true)
        gotoDashBoardTabbarVC()
    }
    
    
    
    func gotoBookingConfirmedVC(url:String) {
        guard let vc = BookingConfirmedVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.urlString = url
        present(vc, animated: true)
    }
    
    
    
    func gotoDashBoardTabbarVC() {
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
    
    
    func paymentGatewaySucess(response: MobilePrePaymentModel) {
        print("===== paymentGatewaySucess ====== ")
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
            BASE_URL = ""
            viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: response.url ?? "")
        }
        
        
    }
    
    
    
    func mobilesecurebookingDetails(response: MobilePrePaymentModel) {
        
        print(" ====== mobilesecurebookingDetails ======= \n \(response)")
        
        if response.status == true {
            gotoBookingConfirmedVC(url: response.url  ?? "")
        }else {
            showAlertOnWindow(title: "",message: "Booking Failed",titles: ["OK"]) { title in
                self.gotoDashBoardTabbarVC()
            }
        }
    }
    
}



extension LoadWebViewVC: WKNavigationDelegate {
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        if let response = navigationResponse.response as? HTTPURLResponse {
            print(" ======== response =====")
            print(response)
            
            if response.statusCode == 200 {
                
            }
            
        }
        decisionHandler(.allow)
    }
    
    
    
    func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        debugPrint("didCommit")
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        
        let str = webView.url?.absoluteString ?? ""
        //   let existstr = "https://provabdevelopment.com/babsafar/index.php/payment_gateway/success"
        //   https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/voucher/flight/BAS-F-TP-0211-4454/1EV
        
        let existstr = "https://provabdevelopment.com/babsafar/mobile_webservices/mobile/index.php/voucher"
        
        
        if apicallbool == false {
            
            if str.containsIgnoringCase(find: "paymentcancel") || str.containsIgnoringCase(find: "CANCELED") || str.containsIgnoringCase(find: "bookingFailuer"){
                
                showAlertOnWindow(title: "",message: "Somthing Went Wrong",titles: ["OK"]) { title in
                    self.gotoDashBoardTabbarVC()
                }
            }else {
                
                
                
                if str.lowercased().range(of:existstr) != nil {
                    debugPrint("********  didFinish ******** \n \(webView.url?.absoluteString)>")
                    
                    gotoBookingConfirmedVC(url: webView.url?.absoluteString ?? "")
                    //                    BASE_URL = ""
                    //                    viewmodel?.CALL_MOBILE_PAYMENT_GATE_WAY_API(dictParam: [:], url: webView.url?.absoluteString ?? "")
                    
                    //  viewmodel1?.Call_mobile_secure_booking_API(dictParam: [:], url: webView.url?.absoluteString ?? "")
                }
            }
        }
        apicallbool = false
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        debugPrint("didFail")
    }
    
    
}

extension String {
    func contains(find: String) -> Bool{
        return self.range(of: find) != nil
    }
    func containsIgnoringCase(find: String) -> Bool{
        return self.range(of: find, options: .caseInsensitive) != nil
    }
}
