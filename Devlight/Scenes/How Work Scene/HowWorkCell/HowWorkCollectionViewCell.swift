//
//  HowWorkCollectionViewCell.swift
//  Devlight
//
//  Created by Anderson Oliveira on 11/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

class HowWorkCollectionViewCell: UICollectionViewCell {

    // MARK: IBOutlets
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var menuImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    // MARK: Properties
    
    static let cellIdentifier = "\(HowWorkCollectionViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        setupStyle()
    }
}

// MARK: Setup Style

extension HowWorkCollectionViewCell {

    private func setupStyle() {
        menuImageView.layer.cornerRadius = menuImageView.frame.height / 2.0
        menuImageView.layer.borderWidth = 2.0
        menuImageView.layer.borderColor = UIColor.azure.withAlphaComponent(0.5).cgColor
        
        containerView.layer.cornerRadius = 10.0
        dropShadow(radius: 8.0)
    }
}

extension HowWorkCollectionViewCell {

    func fill(_ workItem: Work) {
        menuImageView.image = UIImage(named: workItem.image)
        titleLabel.text = workItem.title
    }
}
