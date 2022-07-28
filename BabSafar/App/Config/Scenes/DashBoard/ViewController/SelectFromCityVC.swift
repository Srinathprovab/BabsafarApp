//
//  SelectFromCityVC.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class SelectFromCityVC: BaseTableVC {
    
    
    @IBOutlet weak var searchTextfieldHolderView: UIView!
    @IBOutlet weak var backBtnView: UIView!
    @IBOutlet weak var leftArrowImg: UIImageView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var searchImg: UIImageView!
    @IBOutlet weak var searchTF: UITextField!
    
    
    
    var tablerow = [TableRow]()
    var titleStr = String()
    static var newInstance: SelectFromCityVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? SelectFromCityVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
        setupTV()
    }
    
    func setupUI() {
        setupViews(v: searchTextfieldHolderView, radius: 25, color: .WhiteColor.withAlphaComponent(0.5))
        
        leftArrowImg.image = UIImage(named: "leftarrow")
        searchImg.image = UIImage(named: "search")?.withRenderingMode(.alwaysOriginal).withTintColor(.WhiteColor)

        setupViews(v: backBtnView, radius: 20, color: .WhiteColor.withAlphaComponent(0.2))
        setupLabels(lbl:titlelbl,text: titleStr , textcolor: .WhiteColor, font: .LatoMedium(size: 20))
        
        searchTF.backgroundColor = .clear
        searchTF.placeholder = "search airport /city"
        searchTF.setLeftPaddingPoints(20)
        searchTF.font = UIFont.LatoRegular(size: 16)
    }
    
    
    func setupTV() {
        
        
        commonTableView.registerTVCells(["FromCityTVCell"])
        tablerow.removeAll()
        
        for _ in 1 ... 20 {
            tablerow.append(TableRow(title:"dubai, united arab emirates",subTitle: "dubai international airport",text: "DXB",cellType:.FromCityTVCell))
        }
       
        
        
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
    
    
    @IBAction func didTapOnBackButton(_ sender: Any) {
        self.dismiss(animated: true)
    }
    
}
