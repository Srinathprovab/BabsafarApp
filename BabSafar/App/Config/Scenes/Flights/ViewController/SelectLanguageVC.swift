//
//  SelectLanguageVC.swift
//  BabSafar
//
//  Created by MA673 on 22/07/22.
//

import UIKit

class SelectLanguageVC: BaseTableVC, CurrencyListViewModelDelegate {
    
    
    
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
    var onTap = String()
    var viewmodel:CurrencyListViewModel?
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        BASE_URL = BASE_URL1
        callAPI()
        
        NotificationCenter.default.addObserver(self, selector: #selector(nointernet), name: Notification.Name("nointernet"), object: nil)
    }
    
    //MARK: - nointernet
    @objc func nointernet() {
        guard let vc = NoInternetConnectionVC.newInstance.self else {return}
        vc.modalPresentationStyle = .overCurrentContext
        self.present(vc, animated: true)
    }
    
    func callAPI() {
        viewmodel?.CALL_GET_CURRENCY_LIST_API(dictParam: [:])
    }
    
    var curencyList = [CurrencyListData]()
    
    func getCurrencyList(response: CurrencyListModel) {
        curencyList = response.data ?? []
        DispatchQueue.main.async {[self] in
            setupCurrency()
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        setupUI()
        setupCurrency()
        viewmodel = CurrencyListViewModel(self)
    }
    
    func setupViews(v:UIView,radius:CGFloat,color:UIColor) {
        v.backgroundColor = color
        v.layer.cornerRadius = radius
        v.clipsToBounds = true
        
    }
    
    
    func setupUI() {
        setupViews(v: holderView, radius: 10, color: .WhiteColor)
        setupViews(v: langView, radius: 3, color: .WhiteColor)
        setupViews(v: currencyView, radius: 3, color: .WhiteColor)
        setupViews(v: langUL, radius: 0, color: .WhiteColor)
        setupViews(v: currencyUL, radius: 0, color: .AppBtnColor)
        
        setuplabels(lbl: titlelbl, text: "Select Language /Currency", textcolor: .AppLabelColor, font: .LatoRegular(size: 18), align: .left)
        setuplabels(lbl: langlbl, text: "Language", textcolor: .AppLabelColor, font: .LatoRegular(size: 16), align: .left)
        setuplabels(lbl: currencylbl, text: "Currency", textcolor: .SubTitleColor, font: .LatoRegular(size: 16), align: .left)
        
        
        langBtn.setTitle("", for: .normal)
        currencBtn.setTitle("", for: .normal)
        closeBtn.setTitle("", for: .normal)
       
        
        commonTableView.registerTVCells(["SelectLanguageTVCell"])
    }
    
    
    func setuplanguageTVCell() {
        tablerow.removeAll()
        tablerow.append(TableRow(title:"English",subTitle: "",key:"lang",image: "arabic",cellType: .SelectLanguageTVCell))
    //    tablerow.append(TableRow(title:"Arabic",subTitle: "",key:"lang",image: "english",cellType: .SelectLanguageTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    func setupCurencyTVCell() {
        tablerow.removeAll()
        
        curencyList.forEach { i in
            tablerow.append(TableRow(title:i.name,subTitle: i.symbol,key:"lang1",cellType: .SelectLanguageTVCell))
        }
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
    @IBAction func didTapOnLanguageBtn(_ sender: Any) {
        setupLanguage()
    }
    
    
    @IBAction func didTapOncurrencBtn(_ sender: Any) {
        setupCurrency()
    }
    
    
    func setupLanguage() {
        onTap = "language"
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = HexColor("#64276F")
        
        currencylbl.textColor = .AppLabelColor
        currencyUL.backgroundColor = .WhiteColor
        
        setuplanguageTVCell()
    }
    
    
    func setupCurrency() {
        onTap = "currency"
        langlbl.textColor = .AppLabelColor
        langUL.backgroundColor = .WhiteColor
        
        currencylbl.textColor = .AppLabelColor
        currencyUL.backgroundColor = HexColor("#64276F")
        setupCurencyTVCell()
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            if onTap == "currency" {
                defaults.set(cell.subTitlelbl.text ?? "", forKey: UserDefaultsKeys.selectedCurrency)
                NotificationCenter.default.post(name: NSNotification.Name("currency"), object: nil)
                switch cell.titlelbl.text {
                case "USD":
                    defaults.set("$", forKey: UserDefaultsKeys.APICurrencyType)
                    break
                    
                case "KWD":
                    defaults.set("KWD", forKey: UserDefaultsKeys.APICurrencyType)
                    break
                    
                default:
                    break
                }
            }else {
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
            cell.selected()
           // gotoHomeVC()
            
            dismiss(animated: true)
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if let cell = tableView.cellForRow(at: indexPath) as? SelectLanguageTVCell {
            cell.unselected()
        }
    }
    
    
    
    func gotoHomeVC() {
        guard let vc = DashBoaardTabbarVC.newInstance.self else {return}
        vc.modalPresentationStyle = .fullScreen
        vc.selectedIndex = 0
        self.present(vc, animated: false)
    }
    
    
}
