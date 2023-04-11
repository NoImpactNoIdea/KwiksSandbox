//
//  ChatMediaViewer.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/11/23.
//

import Foundation
import UIKit

class ChatMediaViewer : UIViewController {
    
    var chatViewerImages = [String]()
    
    lazy var backButton : UIButton = {
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().backIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.fontBrown
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        return cbf
    }()
    
    var backLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Media"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 20)
        
        return hfl
    }()
    
    lazy var chatMediaCollection : ChatMediaCollection = {
        
        let layout = PinterestLayoutBackground()
        let pmcv = ChatMediaCollection(frame: .zero, collectionViewLayout: layout)
        pmcv.chatMediaViewer = self
        
       return pmcv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor .white
        self.addViews()
        
        //dummy data source for testing
        self.chatViewerImages = globalPhotoArray
        
    }
    
    func addViews() {
        
        self.view.addSubview(self.backButton)
        self.view.addSubview(self.chatMediaCollection)
        self.view.addSubview(self.backLabel)

        self.backButton.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 15).isActive = true
        self.backButton.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 40).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.backLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: 4).isActive = true
        self.backLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: 0).isActive = true
        self.backLabel.sizeToFit()
        
        self.chatMediaCollection.topAnchor.constraint(equalTo: self.backButton.bottomAnchor, constant: 20).isActive = true
        self.chatMediaCollection.leftAnchor.constraint(equalTo: self.view.leftAnchor, constant: 30).isActive = true
        self.chatMediaCollection.rightAnchor.constraint(equalTo: self.view.rightAnchor, constant: -30).isActive = true
        self.chatMediaCollection.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
    }
    
    @objc func handleBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
}

