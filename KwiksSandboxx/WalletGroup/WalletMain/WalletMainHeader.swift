//
//  WalletMainHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/21/23.
//

import Foundation
import UIKit

class WalletMainHeader : BaseView {
    
    var walletMain : WalletMain?
    
    let profileButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        
        return sii
        
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = ""
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 25)
        
        return hfl
    }()
    
    lazy var settingsIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.contentMode = .scaleAspectFit
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.clipsToBounds = false
        sii.layer.masksToBounds = false
        sii.layer.shadowColor = UIColor .black.withAlphaComponent(0.05).cgColor
        sii.layer.shadowOpacity = 1.0
        sii.layer.shadowOffset = CGSize(width: 0, height: 7)
        sii.layer.shadowRadius = 10
        sii.layer.shouldRasterize = false
        let image = UIImage(named: "settings_icon_personal_no_shadow")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: .normal)
        sii.addTarget(self, action: #selector(self.handleSettingsButton), for: UIControl.Event.touchUpInside)

        return sii
        
    }()
    
    lazy var questionMarkIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.contentMode = .scaleAspectFit
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        sii.clipsToBounds = false
        sii.layer.masksToBounds = false
        sii.layer.shadowColor = UIColor .black.withAlphaComponent(0.1).cgColor
        sii.layer.shadowOpacity = 1.0
        sii.layer.shadowOffset = CGSize(width: 0, height: 4)
        sii.layer.shadowRadius = 4
        sii.layer.shouldRasterize = false
        let image = UIImage(named: "wallet_question_mark")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: .normal)
        sii.addTarget(self, action: #selector(self.handleQuestionMarkButton), for: UIControl.Event.touchUpInside)

        return sii
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = UIColor.backgroundWhiteishGrey
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.questionMarkIcon)
        self.addSubview(self.settingsIcon)
        self.addSubview(self.nameLabel)
        self.addSubview(self.profileButton)
        
        self.profileButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -4).isActive = true
        self.profileButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 30).isActive = true
        self.profileButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        self.profileButton.layer.cornerRadius = 25

        self.questionMarkIcon.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.questionMarkIcon.centerYAnchor.constraint(equalTo: self.profileButton.centerYAnchor, constant: 0).isActive = true
        self.questionMarkIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.questionMarkIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.settingsIcon.rightAnchor.constraint(equalTo: self.questionMarkIcon.leftAnchor, constant: -10).isActive = true
        self.settingsIcon.centerYAnchor.constraint(equalTo: self.questionMarkIcon.centerYAnchor).isActive = true
        self.settingsIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.settingsIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.nameLabel.leftAnchor.constraint(equalTo: self.profileButton.rightAnchor, constant: 15).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.settingsIcon.leftAnchor, constant: -20).isActive = true
        self.nameLabel.centerYAnchor.constraint(equalTo: self.profileButton.centerYAnchor).isActive = true
        self.nameLabel.sizeToFit()
        
    }
    
    @objc func handleSettingsButton() {
        print(#function)
    }
    
    @objc func handleQuestionMarkButton() {
        print(#function)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
