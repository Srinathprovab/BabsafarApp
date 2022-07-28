//
//  EditProfileVC.swift
//  BabSafar
//
//  Created by MA673 on 21/07/22.
//

import UIKit

class EditProfileVC: BaseTableVC {
    
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var profileImgView: UIView!
    @IBOutlet weak var profileImg: UIImageView!
    @IBOutlet weak var changeProfileImgView: UIView!
    @IBOutlet weak var camImg: UIImageView!
    @IBOutlet weak var changeProfileBtn: UIButton!
    //    @IBOutlet weak var backBtnView: UIView!
    //    @IBOutlet weak var leftArrowImg: UIImageView!
    //    @IBOutlet weak var titlelbl: UILabel!
    
    static var newInstance: EditProfileVC? {
        let storyboard = UIStoryboard(name: Storyboard.Login.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? EditProfileVC
        return vc
    }
    var tablerow = [TableRow]()
    var gender = String()
    var fname = String()
    var lname = String()
    var mobile = String()
    var email = String()
    var pass = String()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    
    func setupUI() {
        
        changeProfileImgView.backgroundColor = .WhiteColor
        profileImgView.backgroundColor = .WhiteColor
        changeProfileImgView.backgroundColor = .WhiteColor
        changeProfileImgView.addBottomBorderWithColor(color: .AppLabelColor, width: 0.8)
        profileImgView.layer.borderWidth = 1
        profileImgView.layer.borderColor = UIColor.AppBorderColor.cgColor
        profileImgView.layer.cornerRadius = 50
        profileImgView.clipsToBounds = true
        
        profileImg.layer.cornerRadius = 45
        profileImg.clipsToBounds = true
        changeProfileImgView.layer.cornerRadius = 20
        changeProfileImgView.clipsToBounds = true
        changeProfileBtn.setTitle("", for: .normal)
        camImg.image = UIImage(named: "cam")
    }
    
    func setupTV() {
        nav.titlelbl.text = "My Account"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        nav.filterBtnView.isHidden = false
        nav.filterImg.image = UIImage(named: "edit")?.withRenderingMode(.alwaysOriginal)
        nav.filterBtn.addTarget(self, action: #selector(didTapOnEditAccountBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["TextfieldTVCell","ButtonTVCell","UnderLineTVCell","SignUpWithTVCell","EmptyTVCell","SelectGenderTVCell"])
        appendEditProfileTvcells()
    }
    
    
    func appendEditProfileTvcells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:10,cellType:.EmptyTVCell))
        tablerow.append(TableRow(key:"gender",cellType:.SelectGenderTVCell))
        tablerow.append(TableRow(title:"First Name",subTitle: "First Name",key: "signup", text: "1",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Last Name",subTitle: "Last Name",key: "signup",text: "2",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Mobile Number",subTitle: "+961",key: "signup",text: "3",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Email address",subTitle: "Address",key: "signup",text: "4",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Password",subTitle: "Password",key: "myacc",text: "5",cellType:.TextfieldTVCell))
        tablerow.append(TableRow(title:"Update",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:30,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        v.layer.borderWidth = 0.7
        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    
    override func editingTextField(tf: UITextField) {
        switch tf.tag {
        case 1:
            fname = tf.text ?? ""
            break
        case 2:
            lname = tf.text ?? ""
            break
        case 3:
            mobile = tf.text ?? ""
            break
        case 4:
            email = tf.text ?? ""
            break
        case 5:
            pass = tf.text ?? ""
            break
        default:
            break
        }
    }
    override func btnAction(cell: ButtonTVCell) {
        if fname == "" {
            showToast(message: "Enter First Name")
        }else if lname == "" {
            showToast(message: "Enter Last Name")
        }else if mobile == "" {
            showToast(message: "Enter Mobile Number")
        }else if email == "" {
            showToast(message: "Enter Email")
        }else if email.isValidEmail == false {
            showToast(message: "Enter Valid Email")
        }else if pass == "" {
            showToast(message: "Enter Password")
        }else {
            print("Call API>>>>")
        }
    }
    
    
    
    override func didSelectMaleRadioBtn(cell: SelectGenderTVCell) {
        gender = cell.gender
    }
    
    override func didSelectOnFemaleBtn(cell: SelectGenderTVCell) {
        gender = cell.gender
    }
    
    override func didTapOnForGetPassword(cell:TextfieldTVCell){
        guard let vc = CreateNewPasswordVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    @objc func didTapOnBackBtn(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @objc func didTapOnEditAccountBtn(_ sender: UIButton) {
        print("didTapOnEditAccountBtn")
    }
    
    @IBAction func didTapOnChangeProfilePhotoBtn(_ sender: Any) {
        openGallery()
    }
    
}


extension EditProfileVC:UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func openGallery() {
        if UIImagePickerController.isSourceTypeAvailable(UIImagePickerController.SourceType.photoLibrary){
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
            self.present(imagePicker, animated: true, completion: nil)
        } else {
            let alert  = UIAlertController(title: "Warning", message: "You don't have permission to access gallery.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[.originalImage] as? UIImage {
            profileImg.image = pickedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
}
