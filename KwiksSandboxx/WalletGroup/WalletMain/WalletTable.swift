//
//  WalletTable.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/24/23.
//

import Foundation
import UIKit

class WalletTable : UITableView, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let walletID = "walletID"
    
    var walletMain : WalletMain?
   
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        
        self.backgroundColor = UIColor.white
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
        self.clipsToBounds = true
        self.separatorStyle = .none
        self.allowsSelection = false
        self.layer.cornerRadius = 30
        self.contentInset = UIEdgeInsets(top: -20, left: 0, bottom: 0, right: 0)
        self.register(WalletFeeder.self, forCellReuseIdentifier: self.walletID)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.dequeueReusableCell(withIdentifier: self.walletID, for: indexPath) as! WalletFeeder
        cell.walletTable = self
        
        //speed & performance bump possibly, these controllers are difficult without pre fetching - added to chat main also
        cell.layer.shouldRasterize = true
        cell.layer.rasterizationScale = UIScreen.main.scale
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

import Foundation
import UIKit

class WalletFeeder : UITableViewCell {
    
    var walletTable : WalletTable?
    
    let leftIcon : UIButton = {
        
        let dcl = UIButton()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = .clear
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.backgroundColor = UIColor.buttonGreyChat
        dcl.layer.masksToBounds = true
        dcl.layer.cornerRadius = 20
        let image = UIImage(named: "wallet_add_money_icon")?.withRenderingMode(.alwaysOriginal)
        dcl.setImage(image, for: .normal)
        
        return dcl
    }()
    
    var increasePriceLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "+465"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .right
        hfl.font = UIFont(name: FontKit().segoeBold, size: 15)
        
        return hfl
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Cashback from Kwiks"
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 16)
        
        return hfl
    }()
    
    var subHeaderLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "23-02-2023"
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 14)
        
        return hfl
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor .clear
        self.contentView.isUserInteractionEnabled = false
        self.addViews()
        
    }
    
    func addViews() {
        
        self.addSubview(self.leftIcon)
        self.addSubview(self.increasePriceLabel)
        self.addSubview(self.headerLabel)
        self.addSubview(self.subHeaderLabel)

        self.leftIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        self.leftIcon.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 27).isActive = true
        self.leftIcon.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.leftIcon.widthAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.increasePriceLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: 0).isActive = true
        self.increasePriceLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -30).isActive = true
        self.increasePriceLabel.heightAnchor.constraint(equalToConstant: 40).isActive = true
        self.increasePriceLabel.sizeToFit()
        
        self.headerLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: -10).isActive = true
        self.headerLabel.leftAnchor.constraint(equalTo: self.leftIcon.rightAnchor, constant: 11).isActive = true
        self.headerLabel.rightAnchor.constraint(equalTo: self.increasePriceLabel.leftAnchor, constant: -20).isActive = true
        self.headerLabel.sizeToFit()
        
        self.subHeaderLabel.centerYAnchor.constraint(equalTo: self.leftIcon.centerYAnchor, constant: 10).isActive = true
        self.subHeaderLabel.leftAnchor.constraint(equalTo: self.leftIcon.rightAnchor, constant: 11).isActive = true
        self.subHeaderLabel.rightAnchor.constraint(equalTo: self.increasePriceLabel.leftAnchor, constant: -20).isActive = true
        self.subHeaderLabel.sizeToFit()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

