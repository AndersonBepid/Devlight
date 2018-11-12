//
//  WorkWithViewController+UICollectionViewDelegate.swift
//  Devlight
//
//  Created by Anderson Oliveira on 12/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension WorkWithViewController: UICollectionViewDelegate {

}

extension WorkWithViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width * collectionViewCellWidthCoefficient, height: collectionView.frame.height * collectionViewCellHeightCoefficient)
    }
}
