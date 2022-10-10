//
//  AmenitiesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 02/08/22.
//

import UIKit

class AmenitiesTVCell: UITableViewCell {
    
    
    
    @IBOutlet weak var holderView: UIView!
    @IBOutlet weak var amenitiesCV: UICollectionView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupCV()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state amenitiesCV
    }
    
    
    func setupCV() {
        
        holderView.backgroundColor = .WhiteColor
        let nib = UINib(nibName: "AmenitiesCVCell", bundle: nil)
        amenitiesCV.register(nib, forCellWithReuseIdentifier: "cell")
        amenitiesCV.delegate = self
        amenitiesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 200, height: 34)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        // layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        amenitiesCV.collectionViewLayout = layout
        amenitiesCV.backgroundColor = .clear
        amenitiesCV.layer.cornerRadius = 4
        amenitiesCV.clipsToBounds = true
        amenitiesCV.showsHorizontalScrollIndicator = false
        
        
    }
    
}


extension AmenitiesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? AmenitiesCVCell {
            cell.titlelbl.text = "MasterCard"
            commonCell = cell
        }
        return commonCell
    }
    
}

