//
//  VisaEnduiryVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class VisaEnduiryVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    var optionsArray = ["aaaaaa","bbbbb","ccccc"]
    var noOfPassengers = ["1","2","3","4","5"]
    
    var name = String()
    var email = String()
    var mobile = String()
    var designation = String()
    var country = String()
    var noofpassengers1 = String()
    var tablerow = [TableRow]()
    static var newInstance: VisaEnduiryVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? VisaEnduiryVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        nav.titlelbl.text = "Visa Enduiry"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["LabelTVCell","TextfieldTVCell","ButtonTVCell","DropDownTVCell","EmptyTVCell","TextViewTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Name",key: "visa", text: "1", tempText: "Name",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email Address",key: "email", text: "2",tempText: "Email",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Phone Number",key: "email", text: "3",tempText: "+965",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Desination",subTitle: "Desination",image: "downarrow", moreData: optionsArray,cellType: .DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Country",subTitle: "India",image: "downarrow", moreData: optionsArray,cellType: .DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Date Of Travel",subTitle: "26-07-2022",key:"date", image: "",moreData: optionsArray,cellType: .DropDownTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"No.Of. Passengers",subTitle: "1",image: "downarrow", moreData: noOfPassengers,cellType: .DropDownTVCell))
        tablerow.append(TableRow(height:40,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Descript/Remarks",key: "visa",cellType:.TextViewTVCell))
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Enquiry ",key: "visa",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:120,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
    
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            name = tf.text ?? ""
            break
            
        case 2:
            email = tf.text ?? ""
            break
            
        case 3:
            mobile = tf.text ?? ""
            break
            
        default:
            break
        }
    }
    
    
    override func didTapOnDropDownBtn(cell:DropDownTVCell){
       
        
        switch cell.titlelbl.text {
        case "Desination":
            designation = cell.dropdownlbl.text ?? ""
            break
            
        case "Country":
            country = cell.dropdownlbl.text ?? ""
            break
            
            
        case "No.Of. Passengers":
            noofpassengers1 = cell.dropdownlbl.text ?? ""
            break
            
            
        default:
            break
        }
    }
    
    
    override func btnAction(cell: ButtonTVCell) {
        goToNextScreen()
        if name == "" {
            showToast(message: "Enter Name")
        }else if email == "" {
            showToast(message: "Enter Email ID")
        }else if email.isValidEmail == false {
            showToast(message: "Enter Valid Email ID")
        }else if mobile == "" {
            showToast(message: "Enter Phone Number")
        }else if mobile.isValidPhone(phone: mobile) == false {
            showToast(message: "Enter Valid Phone Number")
        }else if designation == "" {
            showToast(message: "Enter Designation")
        }else if country == "" {
            showToast(message: "Enter Country")
        }else if noofpassengers1 == "" {
            showToast(message: "Select No Of Pass")
        }else {
            print("Call API>>>.....")
            goToNextScreen()
        }
    }
    
    func goToNextScreen() {
        guard let vc = VisaEnduirySucessVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
}
