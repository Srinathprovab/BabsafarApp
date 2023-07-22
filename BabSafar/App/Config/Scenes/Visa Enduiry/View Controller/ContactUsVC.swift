//
//  ContactUsVC.swift
//  BabSafar
//
//  Created by FCI on 18/02/23.
//

import UIKit
import MessageUI
import SafariServices
import CallKit

import MapKit

class ContactUsVC: BaseTableVC, SendMessageViewModelDelegate, AllCountryCodeListViewModelDelegate {
    
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    
    static var newInstance: ContactUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ContactUsVC
        return vc
    }
    var tablerow = [TableRow]()
    var payload = [String:Any]()
    var name = String()
    var email = String()
    var phone = String()
    var countrycode = String()
    var message = String()
    var viewmodel1:AllCountryCodeListViewModel?
    var contactusDetails:ContactUsData?
    var vm:SendMessageViewModel?
    
    override func viewWillAppear(_ animated: Bool) {
        
        let seconds = 1.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            self.callGetCointryListAPI()
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    //MARK: - Call Get Cointry List API
    func callGetCointryListAPI() {
        BASE_URL = BASE_URL1
        viewmodel1?.CALLGETCOUNTRYLIST_API(dictParam: [:])
    }
    
    //MARK:  GetCountryList Response
    func getCountryList(response: AllCountryCodeListModel) {
        countrylist = response.all_country_code_list ?? []
        
        DispatchQueue.main.async {[self] in
            setupTVCells()
        }
    }
    
    
    //MARK: -  GetCountryList Response
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        vm = SendMessageViewModel(self)
        viewmodel1 = AllCountryCodeListViewModel(self)
    }
    
    
    func setupUI() {
        setuplabels(lbl: nav.titlelbl, text: "Contact Us", textcolor: .WhiteColor, font: .LatoMedium(size: 18), align: .center)
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["MapViewTVCell",
                                         "ContactUsLabelTVCell",
                                         "EmptyTVCell",
                                         "SendUsMessageTVCell"])
        
    }
    
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.MapViewTVCell))
        tablerow.append(TableRow(title:"Need More Help? We Are At Your Service.",key: "bold",key1: "",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"nas travel & tourism kuwait international airport, departure zone 4",key: "bold1",key1: "loc",image: "loc",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"+965 90003228",key: "bold1",key1: "mob",image: "phone",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"+965 90003228",key: "bold1",key1: "whatsapp",image: "whatsapp",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"For Customer Support Please Send E-mail To",key: "bold",key1: "",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"babsafar.support@johnmenzies.aero",key: "bold1",key1: "emailopen",image: "mail",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(title:"Customer Support Portal",key: "bold1",key1: "customer",image: "chat",cellType:.ContactUsLabelTVCell))
        tablerow.append(TableRow(cellType:.SendUsMessageTVCell))
        tablerow.append(TableRow(height:100,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton){
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf: UITextField) {
        print(tf.text)
        switch tf.tag {
        case 1:
            self.name = tf.text ?? ""
            break
            
        case 2:
            self.email = tf.text ?? ""
            break
            
            
        case 3:
            self.phone = tf.text ?? ""
            break
            
            
            
        default:
            break
        }
    }
    
    
    override func didTapOnCountryCodeSelectBtn(cell:SendUsMessageTVCell){
        self.countrycode = cell.countrycode
    }
    
    override func textViewDidChange(textView:UITextView){
        self.message = textView.text
    }
    
    override func didTapOnSubmitBtn(cell: SendUsMessageTVCell) {
        
        if self.name == "" {
            showToast(message: "Enter Name")
        }else if self.email == "" {
            showToast(message: "Enter Email Address")
        }else if self.email.validateAsEmail() == false {
            showToast(message: "Enter Valid Email Address")
        }else if self.phone == "" {
            showToast(message: "Enter Phone Number")
        }else if self.phone.validateAsPhone() == false {
            showToast(message: "Enter Valid Phone Number")
        }else if self.countrycode == "" {
            showToast(message: "Enter Country Code")
        }else {
            
            
            payload["full_name"] = self.name
            payload["email"] = self.email
            payload["phone_number"] = self.phone
            payload["country_code"] = self.countrycode
            payload["message"] = self.message
            vm?.CALL_SEND_MESSAGE_API(dictParam: payload)
        }
    }
    
    
    func sendMessageSucessDetails(response: SendMsgModel) {
        showToast(message: response.msg ?? "")
        let seconds = 2.0
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
            // Put your code which should be executed with a delay here
            
        }
    }
    
    override func didTapOnOpenEmailButtonAction(cell: ContactUsLabelTVCell) {
        
        switch cell.key1 {
            
        case "emailopen":
            openEmail(mailstr:cell.titlelbl.text ?? "")
            break
            
            
        case "loc":
            didTapOnOpenLocationButtonAction1()
            break
            
        case "mob":
            didTapOnOpenMobileButtonAction1(str: cell.titlelbl.text ?? "", sender: cell.emailBtn)
            break
            
        case "whatsapp":
            didTapOnOpenWhatsappButtonAction1(str: cell.titlelbl.text ?? "")
            break
            
        case "customer":
            didTapOnOpenCustomerPortelButtonAction1()
            break
            
        default:
            break
        }
        
    }
    
    
    
    //MARK: - didTapOnOpenCustomerPortelButtonAction1
    
    func didTapOnOpenCustomerPortelButtonAction1() {
        let url = URL(string: "https://babsafar.freshdesk.com/support/home")!
        
        if UIApplication.shared.canOpenURL(url) {
            UIApplication.shared.open(url)
        } else {
            // Google Chrome is not installed, fallback to Safari
            let safariViewController = SFSafariViewController(url: url)
            present(safariViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: - didTapOnOpenWhatsappButtonAction1
    
    func didTapOnOpenWhatsappButtonAction1(str:String) {
        print(str)
        let phoneNumber = str // Replace with the desired phone number
        
        if let whatsappURL = URL(string: "whatsapp://send?phone=\(phoneNumber)") {
            if UIApplication.shared.canOpenURL(whatsappURL) {
                UIApplication.shared.open(whatsappURL, options: [:], completionHandler: nil)
            } else {
                showToast(message: "WhatsApp is not installed")
            }
        }
    }
    
    
    //MARK: - didTapOnOpenMobileButtonAction1
    
    func didTapOnOpenMobileButtonAction1(str: String, sender: UIButton?) {
        print(str)
        let phoneNumber = str // Replace with the desired phone number
        
        let cleanedPhoneNumber = phoneNumber.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
        
        guard let phoneURL = URL(string: "tel://\(cleanedPhoneNumber)") else {
            print("Invalid phone number")
            return
        }
        
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let callAction = UIAlertAction(title: "Call", style: .default) { _ in
            self.initiateCall(phoneNumber: cleanedPhoneNumber)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(callAction)
        alertController.addAction(cancelAction)
        
        if let popoverController = alertController.popoverPresentationController, let button = sender {
            popoverController.sourceView = button
            popoverController.sourceRect = button.bounds
        }
        
        present(alertController, animated: true, completion: nil)
    }
    
    
    func initiateCall(phoneNumber: String) {
        let url = URL(string: "tel://\(phoneNumber)")!
        
        let callController = CXCallController()
        
        let handle = CXHandle(type: .phoneNumber, value: phoneNumber)
        let startCallAction = CXStartCallAction(call: UUID(), handle: handle)
        let transaction = CXTransaction(action: startCallAction)
        
        callController.request(transaction, completion: { error in
            if let error = error {
                print("Error initiating call: \(error.localizedDescription)")
            } else {
                if UIApplication.shared.canOpenURL(url) {
                    UIApplication.shared.open(url)
                }
            }
        })
    }
    
    
    //MARK: - didTapOnOpenLocationButtonAction1
    
    func didTapOnOpenLocationButtonAction1() {
        showToast(message: "location")
    }
    
    
    
    //MARK: - didTapOnMapImgBtnAction
    
    override func didTapOnMapImgBtnAction(cell:MapViewTVCell){
        if let url = URL(string: "https://www.google.com/maps?ll=29.241207,47.970243&z=15&t=m&hl=en&gl=KW&mapclient=embed&cid=13136825940438091484") {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Google Maps app is not installed, open in Safari
                let coordinates = CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194) // Replace with your desired location coordinates
                let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinates, addressDictionary: nil))
                mapItem.name = "San Francisco" // Replace with your desired location name
                
                let options = [MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
                mapItem.openInMaps(launchOptions: options)
            }
        }
    }
    
    
    
}


extension ContactUsVC:MFMailComposeViewControllerDelegate {
    
    @objc func openEmail(mailstr:String) {
        if MFMailComposeViewController.canSendMail() {
            let composeVC = MFMailComposeViewController()
            composeVC.mailComposeDelegate = self
            composeVC.setToRecipients([mailstr]) // Set the recipient email address
            
            // Set the email subject
            //    composeVC.setSubject("Hello from Swift!")
            
            // Set the email body
            //   composeVC.setMessageBody("This is the body of the email.", isHTML: false)
            
            present(composeVC, animated: true, completion: nil)
        } else {
            // Handle the case when the device cannot send emails
            print("Device cannot send emails.")
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
