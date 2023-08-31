//
//  LoginVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit
import Alamofire

class LoginVC: BaseTableVC, RegisterViewModelProtocal {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var topConstraint: NSLayoutConstraint!
    
    
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    
    
    var tablerow = [TableRow]()
    var loginKey = "login"
    var fname = ""
    var lname = ""
    var email = ""
    var mobile = ""
    var pass = ""
    var cpass = ""
    var showPwdBool = true
    var payload = [String:Any]()
    var regViewModel: RegisterViewModel?
    var uname = String()
    var password = String()
    var isVcFrom = String()
    
    override func viewWillAppear(_ animated: Bool) {
        addObserver()
    }
    
    
    //MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupTV()
        regViewModel = RegisterViewModel(self)
        
        
    }
    
    
    func setupTV() {
        
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        commonTableView.registerTVCells(["LabelTVCell",
                                         "LoignOrSignupBtnsTVCell",
                                         "TextfieldTVCell",
                                         "ButtonTVCell",
                                         "UnderLineTVCell",
                                         "EmptyTVCell"])
        
        appendLoginTvcells()
    }
    
    
    
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        dismiss(animated: true)
    }
    
    
    
    
    override func didTapOnForGetPassword(cell: TextfieldTVCell) {
        guard let vc = ResetPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
    
    override func editingTextField(tf: UITextField) {
        
        if loginKey == "reg" {
            switch tf.tag {
            case 1:
                fname = tf.text ?? ""
                break
                
            case 2:
                lname = tf.text ?? ""
                break
                
            case 11:
                email = tf.text ?? ""
                break
                
            case 12:
                mobile = tf.text ?? ""
                break
                
            case 5:
                pass = tf.text ?? ""
                break
                
            case 6:
                cpass = tf.text ?? ""
                break
            default:
                break
            }
        }else {
            switch tf.tag {
            case 11:
                uname = tf.text ?? ""
                break
                
            case 2:
                password = tf.text ?? ""
                break
                
            default:
                break
            }
        }
        
    }
    
    
    override func didTapOnLoginBtn(cell: UnderLineTVCell) {
        loginKey = "login"
        appendLoginTvcells()
    }
    
    override func didTapOnSignUpBtn(cell: UnderLineTVCell) {
        loginKey = "reg"
        appendSignupTvcells()
        
    }
    
    
    override func didTapOnShowPasswordBtn(cell:TextfieldTVCell){
        
        if showPwdBool == true {
            cell.showImage.image = UIImage(named: "showpass")
            cell.txtField.isSecureTextEntry = false
            showPwdBool = false
        }else {
            cell.txtField.isSecureTextEntry = true
            cell.showImage.image = UIImage(named: "eyeslash")
            showPwdBool = true
        }
        
    }
    
    
    
    //MARK: - Login or  Register Button Action
    override func btnAction(cell: ButtonTVCell) {
        
        if loginKey == "reg" {
            callRegisterAPI()
        }else {
            callLoginAPI()
        }
    }
    
    
}



//MARK: - Login Realted Stuff
extension LoginVC {
    
    
    func appendLoginTvcells() {
        topConstraint.constant = 530
        commonTableView.isScrollEnabled = false
        
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"loginshowbtn",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Email address",key: "email", text: "11", tempText: "Email ID",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",key: "pwd", text: "2", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Log In",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Sign Up",subTitle: "If You Dont Have An Account?",cellType:.UnderLineTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    func callLoginAPI() {
        if uname == "" {
            showToast(message: "Enter Email")
        }else if uname.isValidEmail() == false {
            showToast(message: "Enter Valid Email")
        }else if password == "" {
            showToast(message: "Enter Password")
        }else {
            payload.removeAll()
            payload["username"] = uname
            payload["password"] = password
            regViewModel?.CallLoginAPI(dictParam: payload)
            
        }
    }
    
    func loginDetails(response: LoginModel) {
        print(response)
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            
            defaults.set(true, forKey: UserDefaultsKeys.loggedInStatus)
            defaults.set(response.user_id, forKey: UserDefaultsKeys.userid)
            
            
            showToast(message: response.data ?? "")
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                
                if isVcFrom == "BookingDetailsVC" || isVcFrom == "SideMenuVC"{
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    gotoHomeScreen()
                }
            }
        }
    }
}

//MARK: - Register Realted Stuff
extension LoginVC {
    
    
    
    
    func appendSignupTvcells() {
        
        if screenHeight < 835 {
            topConstraint.constant = 580
        }else {
            topConstraint.constant = 698
        }
        commonTableView.isScrollEnabled = true
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"loginshowbtn",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"First Name",subTitle: self.fname,key: "signup", text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: self.lname,key: "signup", text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number",subTitle: self.mobile,key: "signup", text: "12", tempText: "+961",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email address",subTitle: self.email,key: "signup", text: "11", tempText: "Address",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",subTitle: self.pass,key: "signuppwd", text: "5", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Conform Password",subTitle: self.cpass,key: "signuppwd", text: "6", tempText: "Password",cellType:.TextfieldTVCell))
        
        tablerow.append(TableRow(title:"Sign Up",key: "btn",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Login",subTitle: "If You Have An Account?",cellType:.UnderLineTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    
    func callRegisterAPI() {
        if fname == "" {
            showToast(message: "Enter First name")
        }else if lname == "" {
            showToast(message: "Enter Last name")
        }else if mobile == "" {
            showToast(message: "Enter Mobile No")
        }else if mobile.isValidMobileNumber() == false {
            showToast(message: "Enter Valid Mobile No")
        }else if email == "" {
            showToast(message: "Enter Email")
        }else if email.isValidEmail() == false {
            showToast(message: "Enter Valid Email ID")
        }else if pass == "" {
            showToast(message: "Enter Password")
        }else if cpass == "" {
            showToast(message: "Enter Conform Password")
        }else if pass != cpass {
            showToast(message: "Password not same")
        }else {
            payload["first_name"] = fname
            payload["last_name"] = lname
            payload["email"] = email
            payload["password"] = pass
            payload["phone"] = mobile
            
            regViewModel?.CallRegisterAPI(dictParam: payload)
            
        }
    }
    
    
    func RegisterDetails(response: RegisterModel) {
        print(response)
        if response.status == false {
            showToast(message: response.msg ?? "")
        }else {
            showToast(message: "Register Sucess")
            defaults.set(response.data?.user_id, forKey: UserDefaultsKeys.userid)
            let seconds = 2.0
            DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {[self] in
                if isVcFrom == "BookingDetailsVC" {
                    NotificationCenter.default.post(name: NSNotification.Name("reloadAfterLogin"), object: nil)
                    self.dismiss(animated: true)
                }else {
                    gotoHomeScreen()
                }
            }
        }
    }
    
    
    
    func gotoHomeScreen() {
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        present(vc, animated: true)
    }
    
}



extension LoginVC {
    
    func addObserver() {
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("offline"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(resultnil), name: NSNotification.Name("resultnil"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(reloadTV), name: Notification.Name("reloadTV"), object: nil)
        
    }
    
    
    @objc func reloadTV() {
        DispatchQueue.main.async {[self] in
            commonTableView.reloadData()
        }
    }
    
    //MARK: - resultnil
    @objc func resultnil() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "noresult"
        self.present(vc, animated: true)
    }
    
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        vc.key = "nointernet"
        self.present(vc, animated: true)
    }
    
    
}
