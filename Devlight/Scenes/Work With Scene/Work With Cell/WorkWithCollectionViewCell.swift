//
//  WorkWithCollectionViewCell.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import UIKit

class WorkWithCollectionViewCell: UICollectionViewCell {
    
    // MARK: IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    // MARK: Properties

    static let cellIdentifier = "\(WorkWithCollectionViewCell.self)"
    let collectionViewCellSizeCoefficient: CGFloat = 0.9
    var works: [Work] = []

    override func awakeFromNib() {
        super.awakeFromNib()
        setupCollectionView()
        registerCells()
    }
}

extension WorkWithCollectionViewCell {

    private func setupCollectionView() {
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
    }

    private func registerCells() {
        let cellNib = UINib(nibName: WorkWithItemCollectionViewCell.cellIdentifier, bundle: nil)
        collectionView.register(cellNib, forCellWithReuseIdentifier: WorkWithItemCollectionViewCell.cellIdentifier)
    }
    
    func fill(_ workServices: WorkServices) {
        self.works = workServices.works
    }
}
