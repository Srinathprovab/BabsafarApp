//
//  VisaEnduirySucessVC.swift
//  BabSafar
//
//  Created by MA673 on 29/07/22.
//

import UIKit

class VisaEnduirySucessVC: BaseTableVC {
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var nav: NavBar!
    
    
    var tablerow = [TableRow]()
    static var newInstance: VisaEnduirySucessVC? {
        let storyboard = UIStoryboard(name: Storyboard.Visa.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? VisaEnduirySucessVC
        return vc
    }
    
    override func viewWillAppear(_ animated: Bool) {
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
        nav.titlelbl.text = "Visa Enduiry"
        nav.backBtn.addTarget(self, action: #selector(didTapOnBackBtn(_:)), for: .touchUpInside)
        commonTableView.registerTVCells(["EmptyTVCell","BookingConfirmedTVCell","LabelTVCell","ContactTVCell"])
        commonTableView.layer.cornerRadius = 10
        commonTableView.clipsToBounds = true
        setuptv()
    }
    
    
    func setuptv() {
        tablerow.removeAll()
        
        tablerow.append(TableRow(height:20,cellType:.EmptyTVCell))
        tablerow.append(TableRow(title:"Successfully Submitted",key:"visa",cellType:.BookingConfirmedTVCell))
        tablerow.append(TableRow(title:"Dear customer,",key:"visa",cellType:.LabelTVCell))
        tablerow.append(TableRow(title:"we have recevied your enquiry, our team is working on it, they will gat back to you soon.",key:"privacy",cellType:.LabelTVCell))
        
        tablerow.append(TableRow(height:500,cellType:.EmptyTVCell))
        commonTVData = tablerow
        commonTableView.reloadData()
    }
    
    @objc func didTapOnBackBtn(_ sender:UIButton) {
        dismiss(animated: true)
    }
}

extension VisaEnduirySucessVC {
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let myFooter =  Bundle.main.loadNibNamed("ContactTVCell", owner: self, options: nil)?.first as! ContactTVCell
        return myFooter
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 75
    }
}
