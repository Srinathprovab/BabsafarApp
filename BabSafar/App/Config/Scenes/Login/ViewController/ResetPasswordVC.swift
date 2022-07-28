//
//  ResetPasswordVC.swift
//  BabSafar
//
//  Created by MA673 on 28/07/22.
//

import UIKit

class ResetPasswordVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var holderView: UIView!
    
    
    var tablerow = [TableRow]()
    var email = String()
    static var newInstance: ResetPasswordVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ResetPasswordVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Reset Password"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell"])
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"enter the email associated with your account and we’ll send an email with instructions to reset your password.",key: "cpwd",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"Email Address",subTitle: "email",key: "email", text: "1",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Send ",cellType:.ButtonTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            email = tf.text ?? ""
            break
        
        default:
            break
        }
    }
    
    override func btnAction(cell: ButtonTVCell) {
        
        if self.email == "" {
            showToast(message: "Enter Email")
        }else if self.email.isValidEmail == false {
            showToast(message: "Enter Valid Email ID")
        }else {
            print("Call API...")
            guard let vc = CreateNewPasswordVC.newInstance.self else {return}
            vc.modalPresentationStyle = .fullScreen
            present(vc, animated: true)
        }
    }
    
    
}
