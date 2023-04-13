//
//  CustomTwoSelector.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/12/23.
//

import Foundation
import UIKit

class CustomTwoSelector : UIView {
    
    var dynamicUserProfile : DynamicHeader?
    var leftConstraint : NSLayoutConstraint?

    lazy var leftLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        hfl.isUserInteractionEnabled = false
        hfl.numberOfLines = 3
        hfl.text = "Posts"
        hfl.isUserInteractionEnabled = true
        hfl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTaps(sender:))))
        return hfl
    }()
    
    lazy var rightLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        hfl.isUserInteractionEnabled = false
        hfl.numberOfLines = 3
        hfl.text = "Liked"
        hfl.isUserInteractionEnabled = true
        hfl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleTaps(sender:))))
        return hfl
    }()
    
    let selectorView : UIView = {
        
        let ld = UIView()
        ld.translatesAutoresizingMaskIntoConstraints = false
        ld.backgroundColor = UIColor .white
        ld.layer.borderWidth = 1
        ld.layer.borderColor = UIColor .black.withAlphaComponent(0.1).cgColor
        ld.layer.cornerRadius = 6
        ld.isUserInteractionEnabled = false
        
        return ld
    }()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.selectorBackgroundColor
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor .black.withAlphaComponent(0.1).cgColor
        self.addViews()
        
    }
    
    func addViews() {
        
        let myWidth = screenWidth - 60 //difference from when this is constrained, needs to be 30 points from left and right anchors
        
        self.addSubview(self.selectorView)
        self.addSubview(self.leftLabel)
        self.addSubview(self.rightLabel)

        self.leftLabel.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.leftLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.leftLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.leftLabel.widthAnchor.constraint(equalToConstant: myWidth / 2).isActive = true
        
        self.rightLabel.leftAnchor.constraint(equalTo: self.leftLabel.rightAnchor).isActive = true
        self.rightLabel.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.rightLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.rightLabel.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
       
        self.selectorView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.selectorView.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.selectorView.widthAnchor.constraint(equalToConstant: ((myWidth / 2) - 6)).isActive = true
        self.leftConstraint = self.selectorView.leftAnchor.constraint(equalTo: self.leftLabel.leftAnchor, constant: 3)
        self.leftConstraint?.isActive = true
        
    }
    
    @objc func handleTaps(sender: UITapGestureRecognizer) {
        if let label = sender.view as? UILabel {
            UIDevice.vibrateLight()
            
            let myWidth = (screenWidth - 60) / 2
           
            switch label.text {
                case "Posts":
                self.dynamicUserProfile?.dynamicUserProfile?.handlePostSelection()
                UIView.animate(withDuration: 0.15) {
                    self.leftConstraint?.constant = 3
                    self.layoutIfNeeded()
                }
                case "Liked":
                self.dynamicUserProfile?.dynamicUserProfile?.handleLikedSelection()

                UIView.animate(withDuration: 0.15) {
                    self.leftConstraint?.constant = myWidth + 3
                    self.layoutIfNeeded()
                }
                default: print("no show")
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
