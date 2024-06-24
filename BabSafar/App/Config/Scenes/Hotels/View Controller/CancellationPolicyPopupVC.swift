//
//  CancellationPolicyPopupVC.swift
//  BabSafar
//
//  Created by FCI on 31/08/23.
//

import UIKit

class CancellationPolicyPopupVC: UIViewController {
    
   
    @IBOutlet weak var cancellationPolicyTV: UITableView!
    @IBOutlet weak var tvheight: NSLayoutConstraint!
    
    
    static var newInstance: CancellationPolicyPopupVC? {
        let storyboard = UIStoryboard(name: Storyboard.Hotels.name,
                                      bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: self.className()) as? CancellationPolicyPopupVC
        return vc
    }
    
    var CancellationPolicyArray = [CancellationPolicies]()
    var amount = String()
    var datetime = String()
    var fartType = String()
    
    
    override func viewWillAppear(_ animated: Bool) {
        CancellationPolicyArray.forEach { i in
            print(i.from)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        self.view.backgroundColor = .black.withAlphaComponent(0.50)
        setupTV()
    }
    
    @IBAction func didTapOnCloseBtnAction(_ sender: Any) {
        dismiss(animated: true)
    }
    
    
}



extension CancellationPolicyPopupVC:UITableViewDelegate,UITableViewDataSource {
    
    
    
    func setupTV() {
        cancellationPolicyTV.register(UINib(nibName: "CancellationPolicyTVCell", bundle: nil), forCellReuseIdentifier: "cell")
        cancellationPolicyTV.delegate = self
        cancellationPolicyTV.dataSource = self
        cancellationPolicyTV.tableFooterView = UIView()
        cancellationPolicyTV.showsHorizontalScrollIndicator = false
        cancellationPolicyTV.separatorStyle = .singleLine
        cancellationPolicyTV.isScrollEnabled = false
        cancellationPolicyTV.separatorStyle = .none
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return CancellationPolicyArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var c = UITableViewCell()
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? CancellationPolicyTVCell {
            
            cell.selectionStyle = .none
            let data = CancellationPolicyArray[indexPath.row]
            cell.titlelblb.text = data.amount
            cell.subtitlelbl.text = data.from
            
            c = cell
            
        }
        return c
    }
    
    
    
    
}
