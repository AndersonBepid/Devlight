//
//  HowWorkViewController+UICollectionViewDataSource.swift
//  Devlight
//
//  Created by Anderson Oliveira on 11/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension HowWorkViewController: UICollectionViewDataSource {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mockedWork.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HowWorkCollectionViewCell.cellIdentifier, for: indexPath)
        guard let howWorkCell = cell as? HowWorkCollectionViewCell else { return UICollectionViewCell() }
        let workItem = mockedWork[indexPath.item]

        howWorkCell.fill(workItem)

        return howWorkCell
    }
}
