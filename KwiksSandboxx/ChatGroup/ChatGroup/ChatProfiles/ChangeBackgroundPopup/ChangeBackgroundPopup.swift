//
//  IndividualChangeBackgroundPopup.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//

import Foundation
import UIKit

class ChangeBackgroundPopup : UIView {
    
    var individualProfileChatController : IndividualProfileChatController?
    var bottomContainerConstraint : NSLayoutConstraint?
    
    var changeBackgroundPhotoArray = [String]()
    
    lazy var changeBackgroundCollection : ChangeBackgroundCollection = {
        
        let layout = PinterestLayoutPastMatches()
        let pmcv = ChangeBackgroundCollection(frame: .zero, collectionViewLayout: layout)
        pmcv.changeBackgroundPopup = self
        
       return pmcv
    }()
    
    var container : UIView = {
        
        let cv = UIView()
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .white
        cv.layer.masksToBounds = true
        cv.layer.cornerRadius = 40
        
       return cv
    }()
    
    var chooseBackgroundLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Choose Background"
        hfl.textColor = UIColor.anotherMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 18)
        
        return hfl
    }()
    
    lazy var cancelIcon : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .regular)
        let image = UIImage(systemName: S().cancelIcon, withConfiguration: config)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor .black
        cbf.addTarget(self, action: #selector(self.dismiss), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var addPhotoButton : UIButton = {

        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "add_photo_icon")?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: .normal)
        cbf.backgroundColor = UIColor.kwiksGreen
        cbf.tintColor = UIColor .black
        cbf.isUserInteractionEnabled = true
        cbf.layer.zPosition = 100

        return cbf
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor .black.withAlphaComponent(0.15)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.alpha = 0.0
        self.layer.zPosition = 100
        self.addViews()
        
        self.runDummyValues()
        
    }
   
    override func layoutSubviews() {
        super.layoutSubviews()
        self.container.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]//just round the top corners, not the bottoms
    }
    
    func addViews() {
        
        self.addSubview(self.container)
        self.container.addSubview(self.chooseBackgroundLabel)
        self.container.addSubview(self.cancelIcon)
        self.container.addSubview(self.addPhotoButton)
        self.container.addSubview(self.changeBackgroundCollection)

        self.bottomContainerConstraint = self.container.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 400)
        self.bottomContainerConstraint?.isActive = true
        self.container.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.container.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.container.heightAnchor.constraint(equalToConstant: 400).isActive = true
        
        self.chooseBackgroundLabel.topAnchor.constraint(equalTo: self.container.topAnchor, constant: 38).isActive = true
        self.chooseBackgroundLabel.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20).isActive = true
        self.chooseBackgroundLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.chooseBackgroundLabel.sizeToFit()
        
        self.cancelIcon.centerYAnchor.constraint(equalTo: self.chooseBackgroundLabel.centerYAnchor).isActive = true
        self.cancelIcon.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20).isActive = true
        self.cancelIcon.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.cancelIcon.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.addPhotoButton.bottomAnchor.constraint(equalTo: self.container.bottomAnchor, constant: -40).isActive = true
        self.addPhotoButton.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 37).isActive = true
        self.addPhotoButton.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -37).isActive = true
        self.addPhotoButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.addPhotoButton.layer.cornerRadius = 25
        
        self.changeBackgroundCollection.topAnchor.constraint(equalTo: self.chooseBackgroundLabel.bottomAnchor, constant: 20).isActive = true
        self.changeBackgroundCollection.bottomAnchor.constraint(equalTo: self.addPhotoButton.topAnchor, constant: -20).isActive = true
        self.changeBackgroundCollection.leftAnchor.constraint(equalTo: self.container.leftAnchor, constant: 20).isActive = true
        self.changeBackgroundCollection.rightAnchor.constraint(equalTo: self.container.rightAnchor, constant: -20).isActive = true

    }
    
    func runDummyValues() {
        
        self.changeBackgroundPhotoArray = globalBackgroundArray
      
        DispatchQueue.main.async {
            self.changeBackgroundCollection.reloadData()
        }
    }
    
    func engagePopup() {
        
        UIDevice.vibrateLight()
        self.alpha = 1.0
        
        UIView.animate(withDuration: 0.15) {
           
            self.backgroundColor = UIColor .black.withAlphaComponent(0.55)
            self.layoutIfNeeded()
            self.layoutSubviews()
        } completion: { complete in
            UIView.animate(withDuration: 0.15) {
               
                self.bottomContainerConstraint?.constant = 0
                self.layoutIfNeeded()
                self.layoutSubviews()
            } completion: { complete in
                print("popup moved up quickly")
            }
        }
    }
    
    @objc func dismiss() {
        
        UIView.animate(withDuration: 0.15) {
            
             self.bottomContainerConstraint?.constant = 400
             self.layoutIfNeeded()
             self.layoutSubviews()
        } completion: { complete in
            UIView.animate(withDuration: 0.15) {
                self.backgroundColor = UIColor .black.withAlphaComponent(0.0)
                self.layoutIfNeeded()
                self.layoutSubviews()
            } completion: { complete in
                self.alpha = 0.0
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
