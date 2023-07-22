//
//  MoreDetailsVC.swift
//  BabSafar
//
//  Created by MA673 on 08/08/22.
//

import UIKit

class MoreDetailsVC: BaseTableVC, AboutusViewModelDelegate {
   
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    
    static var newInstance: MoreDetailsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? MoreDetailsVC
        return vc
    }
    var tablerow = [TableRow]()
    var viewmodel:AboutusViewModel?
    var viewmodel1:AllCountryCodeListViewModel?
    var contactusDetails:ContactUsData?
    var payload = [String:Any]()
    
    override func viewWillDisappear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        callapibool = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if callapibool == true {
            DispatchQueue.main.async {[self] in
                setuptv()
            }
        }
       
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        viewmodel = AboutusViewModel(self)
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = "More Details"
        nav.backBtnView.isHidden = true
        commonTableView.backgroundColor = .AppBorderColor
        commonTableView.clipsToBounds = true
        commonTableView.isScrollEnabled = false
        commonTableView.registerTVCells(["AboutusTVCell","EmptyTVCell"])
        
        setuptv()
        
    }
    
    func setuptv() {
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(title:"About Us",cellType:.AboutusTVCell))
        tablerow.append(TableRow(title:"Terms & Conditions",cellType:.AboutusTVCell))
        tablerow.append(TableRow(title:"Cookies Policy",cellType:.AboutusTVCell))
        tablerow.append(TableRow(title:"Contact Us",cellType:.AboutusTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? AboutusTVCell {
            switch cell.titlelbl.text {
            case "About Us":
                payload.removeAll()
                BASE_URL = ""
                payload["id"] = "1"
                viewmodel?.CALL_GET_ABOUTUS_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/general/cms")
                break
                
            case "Terms & Conditions":
                payload.removeAll()
                BASE_URL = ""
                payload["id"] = "3"
                viewmodel?.CALL_GET_ABOUTUS_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/general/cms")
                break
                
            case "Cookies Policy":
                payload.removeAll()
                BASE_URL = ""
                payload["id"] = "4"
                viewmodel?.CALL_GET_ABOUTUS_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/general/cms")
                
               
                break
                
                
            case "Contact Us":
                payload.removeAll()
                BASE_URL = ""
                payload["id"] = "1"
                viewmodel?.CALL_CONTACTUS_API(dictParam: payload, url: "https://provabdevelopment.com/pro_new/mobile/index.php/flight/get_contact_details")
                break
                
            default:
                break
            }
        }
    }
    
    
    
    func aboutusDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func termsandcobditionDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    func privacyPolicyDetails(response: AboutUsModel) {
        gotoAboutUsVC(title: response.data?.page_title ?? "", desc: response.data?.page_description ?? "")
    }
    
    
    func contactDetals(response: ContactUsModel) {
        contactusDetails = response.data
        
        
        DispatchQueue.main.async {[self] in
            gotoContactUsVC()
        }
        
    }
    
    func gotoAboutUsVC(title:String,desc:String) {
        guard let vc = AboutUsVC.newInstance.self else {return}
        vc.titleString = title
        vc.key1 = "webviewhide"
        vc.desc = desc
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
        
    }
    
    func gotoContactUsVC() {
        guard let vc = ContactUsVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.contactusDetails = self.contactusDetails
        self.present(vc, animated: true)
    }
    
    
}
