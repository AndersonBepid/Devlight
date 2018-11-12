//
//  GravitySliderFlowLayout.swift
//  GravitySliderExample
//
//  Created by Artem Tevosyan on 9/27/17.
//  Copyright © 2017 Artem Tevosyan. All rights reserved.
//

import Foundation
import UIKit

open class GravitySliderFlowLayout: UICollectionViewFlowLayout {
    
    let lineSpacingArgument: CGFloat = -2
    private var lastCollectionViewSize: CGSize = CGSize.zero
    private var period: CGFloat {
        return (collectionView?.bounds.width ?? 0) * 0.9
    }
    
    public init(with itemSize: CGSize, scrollDirection: UICollectionView.ScrollDirection) {
        super.init()
        let sizeByDirection = scrollDirection == .horizontal ? itemSize.width : itemSize.height
        
        self.scrollDirection = scrollDirection
        self.itemSize = itemSize
        self.minimumLineSpacing = sizeByDirection / lineSpacingArgument
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setup(for scrollDirection: UICollectionView.ScrollDirection, with collectionViewSize: CGSize) {
        guard collectionViewSize != lastCollectionViewSize else { return }
        self.lastCollectionViewSize = collectionViewSize
        self.scrollDirection = scrollDirection
        switch scrollDirection {
        case .horizontal:
            sectionInset = UIEdgeInsets(top: 0.0, left: (collectionViewSize.width - itemSize.width) / 2, bottom: 0.0, right: (collectionViewSize.width - itemSize.width) / 2)
        case .vertical:
            sectionInset = UIEdgeInsets(top: (collectionViewSize.height - itemSize.height) / 2, left: 0.0, bottom: (collectionViewSize.height - itemSize.height) / 2, right: 0.0)
        }
    }
    
    override open func prepare() {
        super.prepare()
        guard let collectionView = self.collectionView else { return }
        self.setup(for: self.scrollDirection, with: collectionView.bounds.size)
    }
    
    override open func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        var targetRect = CGRect()
        switch scrollDirection {
        case .horizontal:
            targetRect.origin = CGPoint(x: (rect.origin.x - rect.width) / 2.0, y: rect.origin.y)
            targetRect.size = CGSize(width: rect.width * 2, height: rect.height)
            guard let collectionView = collectionView, let attributes = super.layoutAttributesForElements(in: targetRect) else { return nil }
            for attribute in attributes {
                let cellX = collectionView.convert(attribute.center, to: nil).x
                let difference = collectionView.center.x - cellX
                let zIndexValue = -pow(abs(difference) / collectionView.frame.size.width, 2.0)
                let scaleFactor = -pow((difference / 1.2) / collectionView.frame.size.width * 2.0, 2.0) + 1.0
                
                let numPeriods = floor(Double(cellX / period))
                let adjustment = CGFloat(numPeriods) * period
                let relativeDistanceFromCenter = collectionView.center.x - (cellX - adjustment)
                let centerProximityMagnitude = sinDistributor(value: cellX,
                                                              period: period,
                                                              yOffset: collectionView.center.x)
                
                let tx = relativeDistanceFromCenter - adjustment + centerProximityMagnitude * itemSize.width * 0.6
                var transform = CATransform3DIdentity
                transform = CATransform3DTranslate(transform,
                                                   tx,
                                                   0.0,
                                                   0.0)
                transform = CATransform3DScale(transform,
                                               scaleFactor,
                                               scaleFactor,
                                               1.0)

                let distanceFromCenter = abs(collectionView.center.x - cellX)
                attribute.alpha = sqrtDistributor(value: distanceFromCenter,
                                                  threshold: period * 0.5,
                                                  origin: period * 0.6)
                attribute.zIndex = Int(zIndexValue * 1000)
                attribute.transform3D = transform
            }
            return attributes
        case .vertical:
            targetRect.origin = CGPoint(x: rect.origin.x, y: (rect.origin.y - rect.height) / 2.0)
            targetRect.size = CGSize(width: rect.width, height: rect.height * 2)
            guard let collectionView = collectionView, let attributes = super.layoutAttributesForElements(in: targetRect) else { return nil }
            for attribute in attributes {
                let cellY = collectionView.convert(attribute.center, to: nil).y
                let difference = collectionView.center.y - cellY
                let zIndexValue = -pow(abs(difference)/collectionView.frame.size.height, 2.0) + 1.0
                let scaleFactor = -pow((difference / 1.8)/collectionView.frame.size.height * 2.0, 2.0) + 1.0
                
                let numPeriods = floor(Double(cellY / period))
                let adjustment = CGFloat(numPeriods) * period
                let relativeDistanceFromCenter = collectionView.center.y - (cellY - adjustment)
                let centerProximityMagnitude = sinDistributor(value: cellY,
                                                              period: period,
                                                              yOffset: collectionView.center.y)
                
                let ty = relativeDistanceFromCenter - adjustment + centerProximityMagnitude * itemSize.height * 0.6
                var transform = CATransform3DIdentity
                transform = CATransform3DTranslate(transform,
                                                   0.0,
                                                   ty,
                                                   0.0)
                transform = CATransform3DScale(transform,
                                               scaleFactor,
                                               scaleFactor,
                                               1.0)

                let distanceFromCenter = abs(collectionView.center.y - cellY)
                attribute.alpha = sqrtDistributor(value: distanceFromCenter,
                                                  threshold: period * 0.5,
                                                  origin: period * 0.6)
                attribute.zIndex = Int(zIndexValue * 1000)
                attribute.transform3D = transform
            }
            return attributes
        }
    }
    
    override open func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override open func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint,
                                           withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return CGPoint.zero}

        let latestOffset = super.targetContentOffset(forProposedContentOffset: proposedContentOffset,
                                                     withScrollingVelocity: velocity)

        switch scrollDirection {
        case .horizontal:
            let difference = collectionView.frame.size.width / 2 - sectionInset.left - itemSize.width / 2
            let inset = collectionView.contentInset.left
            let row: CGFloat = ((latestOffset.x - inset + difference) / (itemSize.width + minimumLineSpacing)).rounded()
            let calculatedOffset = row * itemSize.width + row * minimumLineSpacing + inset
            let isStartedScrollX = (row == 0 && proposedContentOffset.x < (calculatedOffset - difference))
            let isEndScrollX = ((Int(row) == collectionView.numberOfItems(inSection: 0) - 1) && proposedContentOffset.x > (calculatedOffset - difference))
            let targetOffset = CGPoint(x: (isStartedScrollX || isEndScrollX) ? proposedContentOffset.x : calculatedOffset - difference,
                                       y: latestOffset.y)
            return targetOffset
        case .vertical:
            let difference = collectionView.frame.size.height / 2 - sectionInset.top - itemSize.height/2
            let inset = collectionView.contentInset.top
            let row: CGFloat = ((latestOffset.y - inset + difference) / (itemSize.height + minimumLineSpacing)).rounded()
            let calculatedOffset = row * itemSize.height + row * minimumLineSpacing + inset
            let isStartedScrollY = (row == 0 && proposedContentOffset.y < (calculatedOffset - difference))
            let isEndScrollY = ((Int(row) == collectionView.numberOfItems(inSection: 0) - 1) && proposedContentOffset.y > (calculatedOffset - difference))
            let targetOffset = CGPoint(x: latestOffset.x,
                                       y: (isStartedScrollY || isEndScrollY) ? proposedContentOffset.y : calculatedOffset - difference)
            return targetOffset
        }
    }
    
    /**
     Distribution function that start as a square root function and levels off when reaches y = 1.
     - parameter value: X or Y parameter of the function. Current layout implementation uses center.(x or y) coordinate of collectionView cells.
     - parameter threshold: The, x or y, coordinate where function gets value 1.
     - parameter origin: x or y, coordinate of the function origin.
     */
    private func sqrtDistributor(value: CGFloat, threshold: CGFloat, origin: CGFloat) -> CGFloat {
        var arg = (value - origin) / (threshold - origin)
        arg = arg <= 0 ? 0 : arg
        let y = sqrt(arg)
        return y > 1 ? 1 : y
    }
    
    /**
     - parameter value: X or Y parameter of the function. Current layout implementation uses center.(x or y) coordinate of collectionView cells.
     - parameter period: The period of the function.
     - parameter offset: x or y, coordinate where the function crosses 0 coordinate.
     */
    private func sinDistributor(value: CGFloat, period: CGFloat, yOffset: CGFloat) -> CGFloat {
        let halfPeriod = period / 2.0
        return sin(value / (halfPeriod / CGFloat.pi) - yOffset / (halfPeriod / CGFloat.pi))
    }
}

