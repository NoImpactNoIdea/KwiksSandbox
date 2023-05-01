//
//  ChatTable.swift
//  Kwiks
//

import Foundation
import UIKit

class MessagesTable : UITableView, UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource {
    
    private let messagesTableID = "messagesTableID"
    
    var messagesContainer : MessagesContainer?
   
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
        self.layer.cornerRadius = 40
        self.clipsToBounds = true
        self.separatorStyle = .none
        self.allowsSelection = false
        
        self.register(MessagesFeeder.self, forCellReuseIdentifier: self.messagesTableID)
    }
  
    override func layoutSubviews() {
        super.layoutSubviews()
        self.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func adjustForArchived(shouldAdjust : Bool) {
        DispatchQueue.main.async {
            
            if shouldAdjust {
                UIView.animate(withDuration: 0.04, delay: 0) {
                    self.messagesContainer?.archiveHeaderLabel.alpha = 1.0
                }
                self.setContentOffset(CGPoint(x: 0, y: -60), animated: true)
            } else {
                UIView.animate(withDuration: 0.075, delay: 0) {
                    self.messagesContainer?.archiveHeaderLabel.alpha = 0.0
                }
                self.setContentOffset(.zero, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = self.dequeueReusableCell(withIdentifier: self.messagesTableID, for: indexPath) as! MessagesFeeder
         cell.messagesTable = self
         //speed & performance bump possibly, these controllers are difficult without pre fetching - added to chat main also
         cell.layer.shouldRasterize = true
         cell.layer.rasterizationScale = UIScreen.main.scale
        
         return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
       
        //three dot menu
        let threeDotMenu = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
            self.menuExpansion()
        }
        
        threeDotMenu.backgroundColor = UIColor .kwiksGreen
        
        let threeDotImage = UIImage(named: S().threeDotsVertical)?.withRenderingMode(.alwaysOriginal)
        threeDotMenu.image = threeDotImage
        
        //pinned functionality
        let pinMenu = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
            self.pinMessage() //pass the datasource here, then hit the endpoint to pin
        }
        
        pinMenu.backgroundColor = UIColor .kwiksDeepGreen
        
        let pinImage = UIImage(named: S().whitePinLargeTable)?.withRenderingMode(.alwaysOriginal)
        pinMenu.image = pinImage
        
        
        //trash functionality
        let trashMenu = UIContextualAction(style: .normal, title: "") {  (contextualAction, view, boolValue) in
            self.deleteConversation(indexpath: indexPath) //remove the cell, then call the endpoint
        }
        
        trashMenu.backgroundColor = UIColor .red
        
        let trashImage = UIImage(named: S().trashIcon)?.withRenderingMode(.alwaysOriginal)
        trashMenu.image = trashImage
        
        let swipeActions = UISwipeActionsConfiguration(actions: [trashMenu, threeDotMenu, pinMenu])

        return swipeActions
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.adjustForArchived(shouldAdjust: false) //edge case for when adjusted text is visible and someone scrolls
    }
    
    @objc func pinMessage() {
        ///move up to top index of 0 unless we are flipped, then last index
        print(#function)
    }
    @objc func menuExpansion() {
        print(#function)
        self.messagesContainer?.handleThreeDotMenu()//pass the data source here
    }
    @objc func deleteConversation(indexpath : IndexPath) {
        print(#function)
    }
    
    @objc func handleCellSelection(sender:UIButton) {
        
        let selectedButtonCell = sender.superview as! UITableViewCell
        guard let indexPath = self.indexPath(for: selectedButtonCell) else {return}
        self.messagesContainer?.handleCellSelection()
        self.adjustForArchived(shouldAdjust: false) //edge case for when adjusted text is visible and someone scrolls
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class MessagesFeeder : UITableViewCell {
    
    var messagesTable : MessagesTable?
    
    let containerView : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = UIColor .white
        ff.isUserInteractionEnabled = true
        
        return ff
    }()
    
    lazy var profilePhoto : UIImageView = {
        
        let dcl = UIImageView()
        dcl.translatesAutoresizingMaskIntoConstraints = false
        dcl.backgroundColor = UIColor.profilePhotoBackgroundColor
        dcl.contentMode = .scaleAspectFill
        dcl.isUserInteractionEnabled = false
        dcl.clipsToBounds = true
        dcl.isUserInteractionEnabled = true
        dcl.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.handleProfilePhotoTaps(sender:))))
       
        return dcl
    }()
    
    let infoContainer : UIView = {
        
        let ic = UIView()
        ic.translatesAutoresizingMaskIntoConstraints = false
        ic.backgroundColor = .clear
        
       return ic
    }()
    
    var nameLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Caleb Klein"
        hfl.textColor = UIColor.black
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 15)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    var commentLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Good evening so happy to see you.. ❤️ "
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .left
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 12)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    let dividerLine : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = UIColor.dividerLineGrey.withAlphaComponent(0.4)
        ff.isUserInteractionEnabled = true
        
        return ff
    }()
    
    var notificationCircle : UILabel = {
        
        let nc = UILabel()
        nc.translatesAutoresizingMaskIntoConstraints = false
        nc.backgroundColor = UIColor .kwiksGreen
        nc.textColor = UIColor .white
        nc.font = UIFont(name: FontKit().segoeSemiBold, size: 12)
        nc.text = "3"
        nc.textAlignment = .center
        nc.adjustsFontSizeToFitWidth = false
        nc.layer.masksToBounds = true
        
        return nc
    }()
    
    var dateTimeLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "5:45PM"
        hfl.textColor = UIColor.chatTextGrey
        hfl.textAlignment = .right
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 12)
        hfl.isUserInteractionEnabled = true
        hfl.numberOfLines = 1
        
        return hfl
    }()
    
    lazy var pinIcon : UIImageView = {
        
        let cbf = UIImageView()
        cbf.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: S().messagePinIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.image = image
        cbf.contentMode = .scaleAspectFit
        cbf.backgroundColor = UIColor.pinLightGreen
        cbf.tintColor = UIColor.kwiksDeepGreen
        
        return cbf
    }()
    
    lazy var dummyMessageButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        cbf.addTarget(self, action: #selector(self.handleMessageTap), for: .touchUpInside)
        
        return cbf
        
    }()
    
   
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = UIColor .clear
        self.addViews()
        self.containerView.layer.cornerRadius = 20
        
        let image = UIImage(named: "stock_photo_man")?.withRenderingMode(.alwaysOriginal)
        self.profilePhoto.image = image
        self.contentView.isUserInteractionEnabled = false
        
    }
   
    func addViews() {
        
        self.addSubview(self.containerView)
        self.addSubview(self.profilePhoto)
        self.addSubview(self.infoContainer)
        self.addSubview(self.nameLabel)
        self.addSubview(self.commentLabel)
        self.addSubview(self.dividerLine)
        self.addSubview(self.notificationCircle)
        self.addSubview(self.pinIcon)
        self.addSubview(self.dateTimeLabel)
        self.addSubview(self.dummyMessageButton)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true

        self.profilePhoto.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        self.profilePhoto.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.profilePhoto.heightAnchor.constraint(equalToConstant: 60).isActive = true
        self.profilePhoto.widthAnchor.constraint(equalToConstant: 60).isActive = true
        self.profilePhoto.layer.cornerRadius = 30
        
        self.infoContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.infoContainer.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.infoContainer.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.infoContainer.widthAnchor.constraint(equalToConstant: 75).isActive = true
        
        self.nameLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        self.nameLabel.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 24).isActive = true
        self.nameLabel.rightAnchor.constraint(equalTo: self.infoContainer.leftAnchor, constant: -10).isActive = true
        self.nameLabel.sizeToFit()
        
        self.commentLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        self.commentLabel.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 24).isActive = true
        self.commentLabel.rightAnchor.constraint(equalTo: self.infoContainer.leftAnchor, constant: -10).isActive = true
        self.commentLabel.sizeToFit()
        
        self.dividerLine.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        self.dividerLine.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true
        self.dividerLine.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.dividerLine.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        self.notificationCircle.rightAnchor.constraint(equalTo: self.infoContainer.rightAnchor, constant: -20).isActive = true
        self.notificationCircle.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -10).isActive = true
        self.notificationCircle.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.notificationCircle.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.notificationCircle.layer.cornerRadius = 10
        
        self.pinIcon.rightAnchor.constraint(equalTo: self.notificationCircle.leftAnchor, constant: -5).isActive = true
        self.pinIcon.centerYAnchor.constraint(equalTo: self.notificationCircle.centerYAnchor, constant: 0).isActive = true
        self.pinIcon.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.pinIcon.widthAnchor.constraint(equalToConstant: 20).isActive = true
        self.pinIcon.layer.cornerRadius = 10
        
        self.dateTimeLabel.rightAnchor.constraint(equalTo: self.notificationCircle.rightAnchor).isActive = true
        self.dateTimeLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 10).isActive = true
        self.dateTimeLabel.sizeToFit()
        
        self.dummyMessageButton.leftAnchor.constraint(equalTo: self.profilePhoto.rightAnchor, constant: 0).isActive = true
        self.dummyMessageButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
        self.dummyMessageButton.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        self.dummyMessageButton.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true

    }
    
    //profile view taps
    @objc func handleProfilePhotoTaps(sender:UIGestureRecognizer) {
        if let imageView = sender.view as? UIImageView {
            print("IMAGE: \(imageView)")
        }
    }
    
    //general taps
    @objc func handleMessageTap(sender:UIButton) {
        self.messagesTable?.handleCellSelection(sender: sender)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.containerView.layer.maskedCorners = [.layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
