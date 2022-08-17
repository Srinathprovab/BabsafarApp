//
//  AboutUsVC.swift
//  BabSafar
//
//  Created by MA673 on 09/08/22.
//

import UIKit
import WebKit

class AboutUsVC: UIViewController {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    @IBOutlet weak var webview: WKWebView!
    
    
    
    static var newInstance: AboutUsVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? AboutUsVC
        return vc
    }
    
    
    var urlString = String()
    var titleString = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    
    func setupUI() {
        holderView.backgroundColor = .WhiteColor
        nav.titlelbl.text = titleString
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        
        let url = URL(string: urlString)
        webview.load(URLRequest(url: url!))
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
}
