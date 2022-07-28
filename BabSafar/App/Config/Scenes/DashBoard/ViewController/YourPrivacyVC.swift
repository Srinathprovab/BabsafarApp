//
//  YourPrivacyVC.swift
//  BabSafar
//
//  Created by MA673 on 26/07/22.
//

import UIKit

class YourPrivacyVC: BaseTableVC {
    
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    var tablerow = [TableRow]()
    var key1 = "privacy"
    var str = "These are used for different purposes. By clicking on 'All cookies' you agree with our Privacy&cookies and we receive the non-functional cookies. Via these non-functional cookies BABsafar  can approach you on another site based on the pages you have visited."
    static var newInstance: YourPrivacyVC? {
        let storyboard = UIStoryboard(name: Storyboard.Main.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? YourPrivacyVC
        return vc
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.7)
        commonTableView.registerTVCells(["ButtonTVCell","LabelTVCell","EmptyTVCell","YourPrivacyTVCell"])
        setupTV()
    }
    
    
    
    func setupTV() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(cellType:.YourPrivacyTVCell))
        tablerow.append(TableRow(key:"privacy",cellType:.ButtonTVCell))
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    
    override func didTapOnShowMoreBtn(cell: YourPrivacyTVCell) {
        print("didTapOnShowMoreBtn")
        cell.textlbl.text = "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Tincidunt tristique adipiscing felis rhoncus libero. Donec a varius orci congue scelerisque. Lectus metus, morbi vitae, pulvinar in diam felis. Morbi iaculis platea placerat sapien. Mus molestie viverra magna etiam cursus. Fermentum sapien condimentum felis ut cursus ornare. Vel libero auctor blandit amet, ac euismod gravida. Enim imperdiet dolor, augue pellentesque nisl malesuada scelerisque. Vulputate pellentesque in ut facilisi augue sed aliquam faucibus. Aliquet nisi, morbi pulvinar vulputate arcu praesent. Congue amet, lorem tellus sollicitudin ut consequat suspendisse."
        cell.showMoreBtn.isHidden = true
        commonTableView.reloadData()
    }
    
    override func didTapOnDualBtn1(cell: ButtonTVCell) {
        dismiss(animated: true)
    }
    
    
}
