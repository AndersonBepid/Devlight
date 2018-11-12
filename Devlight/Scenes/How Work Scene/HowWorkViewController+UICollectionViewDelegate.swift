//
//  HowWorkViewController+UICollectionViewDelegate.swift
//  Devlight
//
//  Created by Anderson Oliveira on 11/11/18.
//  Copyright © 2018 Anderson Oliveira. All rights reserved.
//

import Foundation
import UIKit

extension HowWorkViewController: UICollectionViewDelegate {

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.item)
    }
}
