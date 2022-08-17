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
    
    static var newInstance: LoginVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? LoginVC
        return vc
    }
    var tablerow = [TableRow]()
    var loginKey = "login"
    var fname = String()
    var lname = String()
    var email = String()
    var mobile = String()
    var pass = String()
    var cpass = String()
    var showPwdBool = true
    var payload = [String:Any]()
    var regViewModel: RegisterViewModel?
    var uname = String()
    var password = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupTV()
    }
    
    
    func setupTV() {
        
        regViewModel = RegisterViewModel(self)
        holderView.layer.cornerRadius = 10
        holderView.clipsToBounds = true
        commonTableView.registerTVCells(["LabelTVCell","LoignOrSignupBtnsTVCell","TextfieldTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","EmptyTVCell"])
        
        appendLoginTvcells()
    }
    
    
    func appendLoginTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"showbtn",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.LoignOrSignupBtnsTVCell))
        tablerow.append(TableRow(title:"Email address",key: "email", text: "1", tempText: "Email ID",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",key: "pwd", text: "2", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Log In",cellType:.ButtonTVCell))
        tablerow.append(TableRow(cellType:.UnderLineTVCell))
        tablerow.append(TableRow(cellType:.SignUpWithTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
    }
    
    
    func appendSignupTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"showbtn",cellType:.LabelTVCell))
        tablerow.append(TableRow(cellType:.LoignOrSignupBtnsTVCell))
        tablerow.append(TableRow(title:"First Name",key: "signup", text: "1", tempText: "First Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",key: "signup", text: "2", tempText: "Last Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number",key: "signup", text: "3", tempText: "+961",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email address",key: "signup", text: "4", tempText: "Address",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",key: "signuppwd", text: "5", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Conform Password",key: "signuppwd", text: "6", tempText: "Password",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Sign Up",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
        
        
    }
    
    
    
    override func didTapOnCloseBtn(cell: LabelTVCell) {
        dismiss(animated: true)
    }
    override func didTapOnGoogleBtn(cell: SignUpWithTVCell) {
        print("didTapOnGoogleBtn")
    }
    
    override func btnAction(cell: ButtonTVCell) {
        if loginKey == "reg" {
            if fname == "" {
                showToast(message: "Enter First name")
            }else if lname == "" {
                showToast(message: "Enter Last name")
            }else if mobile == "" {
                showToast(message: "Enter Mobile No")
            }else if email == "" {
                showToast(message: "Enter Email")
            }
            //            else if email.isValidEmail == false {
            //                showToast(message: "Enter Valid Email ID")
            //            }
            else if pass == "" {
                showToast(message: "Enter Password")
            }else if cpass == "" {
                showToast(message: "Enter Conform Password")
            }else if pass != cpass {
                showToast(message: "Password not same")
            }else {
                print("call register api")
                
                payload["first_name"] = fname
                payload["last_name"] = lname
                payload["email"] = email
                payload["phone"] = mobile
                payload["password"] = pass
                payload["about_us"] = "Checking"
                payload["tc"] = "on"
                payload["register_subscription"] = "on"
                regViewModel?.CallRegisterAPI(dictParam: payload)
                
            }
        }else {
            
            if uname == "" {
                showToast(message: "Enter Email")
            }else if uname.isValidEmail == false {
                showToast(message: "Enter Valid Email")
            }else if password == "" {
                showToast(message: "Enter Password")
            }else {
                payload["username"] = uname
                payload["password"] = password
                regViewModel?.CallLoginAPI(dictParam: payload)
                
            }
        }
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
                
            case 4:
                email = tf.text ?? ""
                break
                
            case 3:
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
            case 1:
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
    
    
    override func didTapOnLoginBtn(cell: LoignOrSignupBtnsTVCell) {
        loginKey = "login"
        cell.loginView.backgroundColor = .AppTabSelectColor
        cell.loginlbl.textColor = .WhiteColor
        
        cell.signUpView.backgroundColor = .WhiteColor
        cell.signuplbl.textColor = .AppLabelColor
        
        appendLoginTvcells()
    }
    
    override func didTapOnSignUpBtn(cell: LoignOrSignupBtnsTVCell) {
        loginKey = "reg"
        cell.loginView.backgroundColor = .WhiteColor
        cell.loginlbl.textColor = .AppLabelColor
        
        cell.signUpView.backgroundColor = .AppTabSelectColor
        cell.signuplbl.textColor = .WhiteColor
        
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
    
    
    
    func loginDetails(response: LoginModel) {
        if response.status == false {
            showToast(message: response.data ?? "")
        }else {
            
            defaults.set(true, forKey: UserDefaultsKeys.userLoggedIn)
            defaults.set("2260", forKey: UserDefaultsKeys.userid)
            print(response.user_id)
        }
    }
    
    func RegisterDetails(response: RegisterModel) {
        print(response)
        showToast(message: "Register Sucess")
    }
    
    
}
