//
//  WorkWithViewController+UICollectionViewDataSource.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension WorkWithViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return workServices.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WorkWithCollectionViewCell.cellIdentifier, for: indexPath)
        guard let workWithCell = cell as? WorkWithCollectionViewCell else { return UICollectionViewCell() }
        let workService = workServices[indexPath.item]
        
        workWithCell.fill(workService)
        
        return workWithCell
    }
}
