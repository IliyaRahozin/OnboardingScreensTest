//
//  OnboardingCollectionLayout.swift
//  OnboardingScreensTest
//
//  Created by Illia Rahozin on 17.11.2023.
//

import UIKit

class OnboardingCollectionLayout: UICollectionViewFlowLayout {
    
    override init() {
        super.init()
        scrollDirection = .horizontal
        sectionInsetReference = .fromLayoutMargins
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {

        guard let collectionView = collectionView else { return proposedContentOffset }

        let collectionViewSize = collectionView.bounds.size
        let proposedRect = CGRect(x: proposedContentOffset.x, y: 0, width: collectionViewSize.width, height: collectionViewSize.height)

        guard let layoutAttributes = super.layoutAttributesForElements(in: proposedRect) else { return proposedContentOffset }

        let centerOffsetX = proposedContentOffset.x + collectionViewSize.width / 2
        let closestAttributes = layoutAttributes.min(by: { abs($0.center.x - centerOffsetX) < abs($1.center.x - centerOffsetX) })

        guard let closest = closestAttributes else { return proposedContentOffset }

        let newOffsetX = closest.center.x - collectionViewSize.width / 2
        return CGPoint(x: newOffsetX, y: proposedContentOffset.y)
    }
    
}
