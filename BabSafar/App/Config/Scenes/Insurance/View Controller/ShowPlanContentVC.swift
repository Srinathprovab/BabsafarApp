//
//  ShowPlanContentVC.swift
//  BabSafar
//
//  Created by FCI on 23/08/23.
//

import UIKit

class ShowPlanContentVC: UIViewController {
    
    
    @IBOutlet weak var planContentTV: UITableView!
    @IBOutlet weak var tvHeight: NSLayoutConstraint!
    
    
    
    static var newInstance: ShowPlanContentVC? {
        let storyboard = UIStoryboard(name: Storyboard.Insurance.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? ShowPlanContentVC
        return vc
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.tvHeight.constant = CGFloat(selectedPlanContent.count * 75)
        self.planContentTV.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        setupUI()
    }
    
    func setupUI(){
        self.view.backgroundColor = .black.withAlphaComponent(0.5)
        
        planContentTV.layer.cornerRadius = 10
        planContentTV.clipsToBounds = true
        setupTV()
    }
    
    
    func setupTV() {
        planContentTV.register(UINib(nibName: "PlanContentTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        planContentTV.delegate = self
        planContentTV.dataSource = self
        planContentTV.tableFooterView = UIView()
        planContentTV.showsHorizontalScrollIndicator = false
        planContentTV.separatorStyle = .none
        planContentTV.isScrollEnabled = false
        
    }
    
    
    @IBAction func closeBtnAction(_ sender: Any) {
        callapibool = false
        dismiss(animated: true)
    }
    
    
    
}



extension ShowPlanContentVC:UITableViewDataSource,UITableViewDelegate {
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPlanContent.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var ccell = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? PlanContentTVCell {
            cell.selectionStyle = .none
            
            
            let data = selectedPlanContent[indexPath.row]
            cell.titlelbl.text = data.title ?? ""
            cell.logoimg.sd_setImage(with: URL(string: data.image ?? "" ), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            
            
            ccell = cell
        }
        return ccell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
