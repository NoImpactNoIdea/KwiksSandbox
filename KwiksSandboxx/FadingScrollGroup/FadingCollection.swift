//
//  FadingCollection.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 3/19/23.
//

//
//  PastMatchedCollectionView.swift
//  Makeup Matcher
//
//  Created by Charlie Arcodia on 10/28/22.
//

import Foundation
import UIKit

class KwiksFadingCollection : UICollectionView, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource, UIScrollViewDelegate, UIGestureRecognizerDelegate {
    
    private let fadingID = "fadingID"
    
    var fadingController : FadingController?
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        
        self.backgroundColor = .red
        self.translatesAutoresizingMaskIntoConstraints = false
        self.dataSource = self
        self.delegate = self
        
        self.isPrefetchingEnabled = false
        self.keyboardDismissMode = UIScrollView.KeyboardDismissMode.interactive
        self.alwaysBounceVertical = true
        self.alwaysBounceHorizontal = false
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.allowsMultipleSelection = true
        self.canCancelContentTouches = false
        self.contentInsetAdjustmentBehavior = .never
        self.delaysContentTouches = true
        self.alpha = 0
        
        self.register(FadingFeeder.self, forCellWithReuseIdentifier: self.fadingID)
        self.delegate = self
        self.dataSource = self
        self.setCollectionViewLayout(layout, animated: false)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 100
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.frame.width, height: 60.0)///roughly height
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.dequeueReusableCell(withReuseIdentifier: self.fadingID, for: indexPath) as! FadingFeeder
        cell.kwiksFadingCollection = self
        return cell
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FadingFeeder : UICollectionViewCell {
    
    var kwiksFadingCollection : KwiksFadingCollection?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = .blue
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}




//     ///drop this baby in the collection subview and that's it - the 2.5, the higher the value the closer to the top it fades and vice versa
//     func scrollViewDidScroll(_ scrollView: UIScrollView) {
//
//            //track the offset vertically
//            let offset = self.contentOffset.y,
//                height = self.frame.size.height ///get the height of the entire collection subview
//
//            //loop through cells that are visible or about to be visisble
//            for cell in self.visibleCells {
//
//                let verticalOffset = cell.frame.origin.y //vertical position to compare - starting origin
//                if verticalOffset >= height / 2.5 { ///if the starting origin is higher then height / whatever value, grab the cells origin and get the alpha based on how far the offset it
//                    let top = cell.frame.origin.y
//                    let alpha = (top - offset) / height
//                    cell.alpha = alpha ///apply the fade
//                } else {
//                    cell.alpha = 1 ///hasnt reached the fade region yet, still solid and visible
//                }
//            }
//        }
//
