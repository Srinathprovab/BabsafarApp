//
//  SpecialDealsTVCell.swift
//  BabSafar
//
//  Created by MA673 on 19/07/22.
//

import UIKit

class SpecialDealsTVCell: TableViewCell {
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var titleLblView: UIView!
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var dealsHolderView: UIView!
    @IBOutlet weak var bookingHolderView: UIView!
    @IBOutlet weak var specialDealsCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        specialDealsCV.reloadData()
    }
    
    
    func setupUI() {
        
        contentView.backgroundColor = .AppHolderViewColor
        holderView.backgroundColor = .AppHolderViewColor
        titleLblView.backgroundColor = .AppHolderViewColor
        dealsHolderView.backgroundColor = .AppHolderViewColor
        bookingHolderView.backgroundColor = .AppHolderViewColor
        setuplabels(lbl: titlelbl, text: "Special Deals For You", textcolor: .AppLabelColor, font: .LatoSemibold(size: 20), align: .left)
        
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "SpecialDealsCVCell", bundle: nil)
        specialDealsCV.register(nib, forCellWithReuseIdentifier: "cell")
        specialDealsCV.delegate = self
        specialDealsCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 200)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        specialDealsCV.collectionViewLayout = layout
        specialDealsCV.backgroundColor = .AppHolderViewColor
        specialDealsCV.showsHorizontalScrollIndicator = false
        specialDealsCV.bounces = false
    }
    
}



extension SpecialDealsTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return deailcodelist.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SpecialDealsCVCell {
            
            
            let data = deailcodelist[indexPath.row]
            if data.image_path != "" {
                cell.offerImage.sd_setImage(with: URL(string: data.topDealImg ?? ""), placeholderImage:UIImage(contentsOfFile:"placeholder.png"))
            }
            
            cell.promoValuelbl.text = data.promo_code
            commonCell = cell
        }
        return commonCell
    }
    
}
