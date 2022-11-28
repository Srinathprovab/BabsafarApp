//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var closeBtn: UIButton!
    @IBOutlet weak var langView: UIView!
    @IBOutlet weak var langlbl: UILabel!
    @IBOutlet weak var langUL: UIView!
    @IBOutlet weak var langBtn: UIButton!
    @IBOutlet weak var currencyView: UIView!
    @IBOutlet weak var currencylbl: UILabel!
    @IBOutlet weak var currencyUL: UIView!
    @IBOutlet weak var currencBtn: UIButton!
    
    
    static var newInstance: SelectLanguageVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectLanguageVC
        return vc
    }
    var tablerow = [TableRow]()
    var onTap = "lang"
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
        setuplanguageTVCell()
    }
    
    
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        //        v.layer.borderWidth = 0
        //        v.layer.borderColor = UIColor.AppBorderColor.cgColor
    }
    
    func setupLabels(lbl:UILabel,text:String,textcolor:UIColor,font:UIFont) {
        lbl.text = text
        lbl.textColor = textcolor
        lbl.font = font
    }
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: langView, radius: 3, color: .WhiteColor)
        setupViews(v: currencyView, radius: 3, color: .WhiteColor)
        setupViews(v: langUL, radius: 0, color: .AppTabSelectColor)
        setupViews(v: currencyUL, radius: 0, color: .WhiteColor)
        
        setupLabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 18))
        setupLabels(lbl: langlbl, text: "Language", textcolor: .AppLabelColor, font: .LatoRegular(size: 16))
        setupLabels(lbl: currencylbl, text: "Currency", textcolor: .SubTitleColor, font: .LatoRegular(size: 16))
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
        
        
        commonTableView.registerTVCells(["SelectLanguageTVCell"])
        
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "$",key:"currency",cellType: .SelectLanguageTVCell))
        tablerow.append(TableRow(title:"Arabic",subTitle: "KWD",key:"currency",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        onTap = "lang"
        langlbl.textColor = .AppTabSelectColor
        langUL.backgroundColor = .AppTabSelectColor
        
        currencylbl.textColor = .AppLabelColor
        currencyUL.backgroundColor = .WhiteColor
        
        
        DispatchQueue.main.async {
            self.setuplanguageTVCell()
        }
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        onTap = "currency"
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppTabSelectColor
        currencyUL.backgroundColor = .AppTabSelectColor
       
        DispatchQueue.main.async {
            self.setupCurencyTVCell()
        }
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.holderView.layer.borderColor = UIColor.AppBtnColor.cgColor
            
            if onTap == "currency" {
                defaults.set(cell.subTitlelbl.text, forKey: UserDefaultsKeys.selectedCurrency)
                
                switch cell.titlelbl.text {
                case "English":
                    defaults.set("$", forKey: UserDefaultsKeys.APICurrencyType)
                    break
                    
            
                case "Arabic":
                    defaults.set("KWD", forKey: UserDefaultsKeys.APICurrencyType)
                    break
                    
                    
                default:
                    break
                }
            }else {
                
                defaults.set(cell.titlelbl.text, forKey: UserDefaultsKeys.selectedLang)
                
                switch cell.titlelbl.text {
                case "English":
                    defaults.set("EN", forKey: UserDefaultsKeys.APILanguageType)
                    break
                    
            
                case "Arabic":
                    defaults.set("AR", forKey: UserDefaultsKeys.APILanguageType)
                    break
                    
                    
                default:
                    break
                }
            }
            
            gotoHome()
        }
    }
    
    
    
     func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.holderView.layer.borderColor = UIColor.AppBorderColor.cgColor
        }
    }
    
    
    func gotoHome(){
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: false)
    }
    
}