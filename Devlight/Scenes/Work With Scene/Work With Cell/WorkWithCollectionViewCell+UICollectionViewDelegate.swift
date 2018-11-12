//
//  WorkWithCollectionViewCell+UICollectionViewDelegate.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension WorkWithCollectionViewCell: UICollectionViewDelegate {
}

extension WorkWithCollectionViewCell: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * collectionViewCellSizeCoefficient, height: collectionView.frame.width * collectionViewCellSizeCoefficient)
    }
}
