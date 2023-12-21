//
//  TopAirlinesTVCell.swift
//  BabSafar
//
//  Created by MA673 on 20/07/22.
//

import UIKit

class TopAirlinesTVCell: TableViewCell {
    
    @IBOutlet weak var titlelbl: UILabel!
    @IBOutlet weak var topAirlinesCV: UICollectionView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setupUI()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    override func updateUI() {
        titlelbl.text = cellInfo?.title
    }
    
    func setupUI() {
        titlelbl.textColor = .AppLabelColor
        titlelbl.font = UIFont.LatoSemibold(size: 18)
        
        setupCV()
    }
    
    
    func setupCV() {
        let nib = UINib(nibName: "TopAirlinesCVCell", bundle: nil)
        topAirlinesCV.register(nib, forCellWithReuseIdentifier: "cell")
        topAirlinesCV.delegate = self
        topAirlinesCV.dataSource = self
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 70, height: 52)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 6
        layout.minimumLineSpacing = 6
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        topAirlinesCV.collectionViewLayout = layout
        topAirlinesCV.backgroundColor = .clear
        topAirlinesCV.layer.cornerRadius = 4
        topAirlinesCV.clipsToBounds = true
        topAirlinesCV.showsHorizontalScrollIndicator = false
        topAirlinesCV.bounces = false
    }
    
}


extension TopAirlinesTVCell:UICollectionViewDelegate,UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var commonCell = UICollectionViewCell()
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? TopAirlinesCVCell {
            cell.airlinesLogoimg.image = UIImage(named: "airlogo")
            commonCell = cell
        }
        return commonCell
    }
    
}
