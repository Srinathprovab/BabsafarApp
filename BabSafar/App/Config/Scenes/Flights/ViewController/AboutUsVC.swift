//
//  AboutUsVC.swift
//  BabSafar
//
//  Created by MA673 on 09/08/22.
//

import UIKit
import WebKit

class AboutUsVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var webview: WKWebView!
    @IBOutlet weak var navHeight: NSLayoutConstraint!
    
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    var urlString = String()
    var titleString = String()
    var desc: String?
    var key1:String?
    var tablerow = [TableRow]()
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        if screenHeight < 835 {
            navHeight.constant = 90
        }
        if key1 == "webviewhide" {
            commonTableView.isHidden = false
            self.webview.isHidden = true
            setupTVCells()
        }else {
            
            commonTableView.isHidden = true
            self.webview.isHidden = false
            let url = URL(string: urlString)
            webview.load(URLRequest(url: url!))
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
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = titleString
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        
        commonTableView.registerTVCells(["TitleLblTVCell","EmptyTVCell"])
        
    }
    
    func setupTVCells() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:desc,key: "aboutus",cellType:.TitleLblTVCell))
        tablerow.append(TableRow(height:50,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        callapibool = false
        dismiss(animated: true)
    }
}
