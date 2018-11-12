//
//  WorkWithCollectionViewCell.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

class WorkWithItemCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBoutles
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var workImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!

    // MARK: Properties
    
    static let cellIdentifier = "\(WorkWithItemCollectionViewCell.self)"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupStyle()
    }
}

extension WorkWithItemCollectionViewCell {

    private func setupStyle()  {
        containerView.layer.cornerRadius = 10.0
        dropShadow(radius: 8.0)
    }
    
    func fill(_ work: Work) {
        workImageView.image = UIImage(named: work.image)
        titleLabel.text = work.title
    }
}
