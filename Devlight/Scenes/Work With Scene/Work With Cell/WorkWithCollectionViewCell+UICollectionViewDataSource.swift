//
//  WorkWithCollectionViewCell+UICollectionViewDataSource.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension WorkWithCollectionViewCell: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return works.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkWithItemCollectionViewCell.cellIdentifier, for: indexPath)
        guard let workCell = cell as? WorkWithItemCollectionViewCell else { return UICollectionViewCell() }
        let work = works[indexPath.item]
        
        workCell.fill(work)
        
        return workCell
    }
}
