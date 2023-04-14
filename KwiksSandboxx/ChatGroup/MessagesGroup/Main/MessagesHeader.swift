//
//  ChatHeader.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/3/23.

import Foundation
import UIKit

class MessagesHeader : UIView, UITextFieldDelegate {
    
    //Selector that decides between bestie, family, archived and requests
    public enum StateSelection {
        case bestie
        case family
        case archived
        case requests
    }
    
    //Use this var as the main reference
    public var stateSelector = StateSelection.bestie
    
    var messagesContainer : MessagesContainer?
    
    var headerContainer : UIView = {
        
        let hc = UIView()
        hc.translatesAutoresizingMaskIntoConstraints = false
        hc.backgroundColor = UIColor.kwiksGreen
        
        return hc
    }()
    
    lazy var backButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().backIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor.kwiksMatteBlack
        cbf.addTarget(self, action: #selector(self.handleBackButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    var timeCover : UIView = {
        
        let tc = UIView()
        tc.translatesAutoresizingMaskIntoConstraints = false
        tc.backgroundColor = UIColor.kwiksGreen
        
       return tc
    }()
    
    var headerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = S().messages
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 24)
        
        return hfl
    }()
    
    lazy var newConversationButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().newConvoIcon)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor .black
        cbf.addTarget(self, action: #selector(self.handleNewConvoIcon(sender:)), for: .touchUpInside)

        return cbf
        
    }()
    
    lazy var searchButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.backgroundColor = .clear
        let image = UIImage(named: S().magGlass)?.withRenderingMode(.alwaysOriginal)
        cbf.setImage(image, for: UIControl.State.normal)
        cbf.tintColor = UIColor .black
        cbf.addTarget(self, action: #selector(self.handleSearchIconOpen(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    var headerStackSelection : UIStackView = {
        
        let sv = UIStackView()
        sv.translatesAutoresizingMaskIntoConstraints = false
        sv.axis = .horizontal
        sv.distribution = .equalCentering
        sv.alignment = .center
        sv.contentMode = .scaleAspectFit
        
        return sv
    }()
    
    lazy var bestiesButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle(S().bestiesLabel, for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksBackgroundBlack
        cbf.backgroundColor = UIColor .white
        cbf.layer.cornerRadius = 15
        cbf.tag = 1
        cbf.addTarget(self, action: #selector(self.handleCategorySelection(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var familyButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle(S().familyLabel, for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksBackgroundBlack
        cbf.backgroundColor = UIColor .white
        cbf.layer.cornerRadius = 15
        cbf.tag = 2
        cbf.addTarget(self, action: #selector(self.handleCategorySelection(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var archivedButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle(S().archivedLabel, for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksBackgroundBlack
        cbf.backgroundColor = UIColor .white
        cbf.layer.cornerRadius = 15
        cbf.tag = 3
        cbf.addTarget(self, action: #selector(self.handleCategorySelection(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var requestsButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle(S().requestsLabel, for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksBackgroundBlack
        cbf.backgroundColor = UIColor .white
        cbf.layer.cornerRadius = 15
        cbf.tag = 4
        cbf.addTarget(self, action: #selector(self.handleCategorySelection(sender:)), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var searchtextField: UITextField = {
        
        let etfc = UITextField()
        let placeholder = NSAttributedString(string: "Search", attributes: [NSAttributedString.Key.foregroundColor: UIColor.chatTextGrey])
        etfc.attributedPlaceholder = placeholder
        etfc.translatesAutoresizingMaskIntoConstraints = false
        etfc.textAlignment = .left
        etfc.textColor = UIColor.chatTextGrey
        etfc.font = UIFont(name: FontKit().segoeSemiBold, size: 14)
        etfc.allowsEditingTextAttributes = false
        etfc.autocorrectionType = .no
        etfc.delegate = self
        etfc.backgroundColor = UIColor.searchWhite
        etfc.keyboardAppearance = UIKeyboardAppearance.dark
        etfc.returnKeyType = UIReturnKeyType.done
        etfc.keyboardType = .alphabet
        etfc.leftViewMode = .always
        etfc.isSecureTextEntry = false
        etfc.layer.borderColor = UIColor .clear.cgColor
        etfc.layer.borderWidth = 1
        etfc.alpha = 0.0
        etfc.addTarget(self, action: #selector(handleSearchTextFieldChange(textField:)), for: .editingChanged)
        return etfc
        
    }()
    
    lazy var searchCancelButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Cancel", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 15)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = .clear
        cbf.tintColor = UIColor.kwiksMatteBlack
        cbf.alpha = 0.0
        cbf.addTarget(self, action: #selector(self.handleCloseSearchField), for: .touchUpInside)
        cbf.contentHorizontalAlignment = .center
        
        return cbf
        
    }()
    
    lazy var toolBar : UIToolbar = {
        
        let bar = UIToolbar()
        let space = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let done = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(self.handleCloseSearchField))
        bar.items = [space, done]
        bar.tintColor = .kwiksGreen
        bar.sizeToFit()
        
        return bar
        
    }()
  
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.kwiksGreen
        self.translatesAutoresizingMaskIntoConstraints = false
        self.addViews()
        self.dummyData()
        self.searchtextField.addPadding(.both(25), "mag_icon_header")
        
        self.searchtextField.inputAccessoryView = self.toolBar
       
    }
    
    func dummyData() {
        
        self.buttonFormat(tag: 1)//manually setting besties first
        let label = "\(S().messages) (\(32))"
        self.headerLabel.colorFontString(text: label, coloredText: "(\(32))", color: UIColor .white, fontName: FontKit().segoeSemiBold, fontSize: 24)
    }
    
    func addViews() {
        
        let timeCoverHeight : CGFloat = CGFloat(0.0).statusBarHeight()
        
        self.addSubview(self.headerContainer)
        self.addSubview(self.timeCover)

        self.headerContainer.addSubview(self.backButton)
        self.headerContainer.addSubview(self.headerLabel)
        self.headerContainer.addSubview(self.newConversationButton)
        self.headerContainer.addSubview(self.searchButton)

        //subviews first
        self.headerStackSelection.addArrangedSubview(self.bestiesButton)
        self.headerStackSelection.addArrangedSubview(self.familyButton)
        self.headerStackSelection.addArrangedSubview(self.archivedButton)
        self.headerStackSelection.addArrangedSubview(self.requestsButton)

        self.headerContainer.addSubview(self.headerStackSelection)
        self.headerContainer.addSubview(self.searchtextField)
        self.headerContainer.addSubview(self.searchCancelButton)

        self.timeCover.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        self.timeCover.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.timeCover.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.timeCover.heightAnchor.constraint(equalToConstant: timeCoverHeight).isActive = true

        self.headerContainer.topAnchor.constraint(equalTo: self.timeCover.bottomAnchor).isActive = true
        self.headerContainer.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        self.headerContainer.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
        self.headerContainer.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        self.backButton.centerYAnchor.constraint(equalTo: self.headerContainer.centerYAnchor, constant: -30).isActive = true
        self.backButton.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 15).isActive = true
        self.backButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.backButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.headerLabel.leftAnchor.constraint(equalTo: self.backButton.rightAnchor, constant: -7).isActive = true
        self.headerLabel.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor, constant: -2).isActive = true
        self.headerLabel.sizeToFit()
        
        self.newConversationButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.newConversationButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -15).isActive = true
        self.newConversationButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.newConversationButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.searchButton.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.searchButton.rightAnchor.constraint(equalTo: self.newConversationButton.leftAnchor, constant: 0).isActive = true
        self.searchButton.heightAnchor.constraint(equalToConstant: 44).isActive = true
        self.searchButton.widthAnchor.constraint(equalToConstant: 44).isActive = true
        
        self.headerStackSelection.topAnchor.constraint(equalTo: self.headerLabel.bottomAnchor, constant: 15).isActive = true
        self.headerStackSelection.leftAnchor.constraint(equalTo: self.headerContainer.leftAnchor, constant: 15).isActive = true
        self.headerStackSelection.rightAnchor.constraint(equalTo: self.headerContainer.rightAnchor, constant: -15).isActive = true
        self.headerStackSelection.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        self.bestiesButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.bestiesButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.bestiesButton.sizeToFit()
        
        self.familyButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.familyButton.widthAnchor.constraint(equalToConstant: 75).isActive = true
        self.familyButton.sizeToFit()
        
        self.archivedButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.archivedButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        self.archivedButton.sizeToFit()
        
        self.requestsButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.requestsButton.widthAnchor.constraint(equalToConstant: 78).isActive = true
        self.requestsButton.sizeToFit()
        
        self.searchtextField.leftAnchor.constraint(equalTo: self.bestiesButton.leftAnchor, constant: 10).isActive = true
        self.searchtextField.centerYAnchor.constraint(equalTo: self.backButton.centerYAnchor).isActive = true
        self.searchtextField.heightAnchor.constraint(equalToConstant: 35).isActive = true
        self.searchtextField.rightAnchor.constraint(equalTo: self.searchButton.leftAnchor).isActive = true
        self.searchtextField.layer.cornerRadius = 17.5
        
        self.searchCancelButton.leftAnchor.constraint(equalTo: self.searchtextField.rightAnchor, constant: 8).isActive = true
        self.searchCancelButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        self.searchCancelButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.searchCancelButton.centerYAnchor.constraint(equalTo: self.searchtextField.centerYAnchor).isActive = true
    }
   
    //each button has a tag 1-4
    @objc func handleCategorySelection(sender:UIButton) {
        
        UIDevice.vibrateLight()
        
        switch sender.tag {
            
                case 1: stateSelector = .bestie
                self.buttonFormat(tag: 1)
                case 2: stateSelector = .family
                self.buttonFormat(tag: 2)
                case 3: stateSelector = .archived
                self.buttonFormat(tag: 3)
                case 4: stateSelector = .requests
                self.buttonFormat(tag: 4)
            
                default:  stateSelector = .bestie
        }
    }
    
    func buttonFormat(tag : Int) {
        
        if tag == 3 { //this is the archived tag, give it a little space and animate it
            self.messagesContainer?.messagesTable.adjustForArchived(shouldAdjust: true)
        } else {
            self.messagesContainer?.messagesTable.adjustForArchived(shouldAdjust: false)
        }
        
        switch tag {
            
        case 1: print("🟢 STATE -> Besties")
            
            self.bestiesButton.backgroundColor = UIColor .white
            self.bestiesButton.tintColor = UIColor .black
            
            self.familyButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.familyButton.tintColor = UIColor.unSelectedTextColor
            
            self.archivedButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.archivedButton.tintColor = UIColor.unSelectedTextColor
            
            self.requestsButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.requestsButton.tintColor = UIColor.unSelectedTextColor
            
        case 2: print("🟢 STATE -> Family")
            
            self.familyButton.backgroundColor = UIColor .white
            self.familyButton.tintColor = UIColor .black
            
            self.bestiesButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.bestiesButton.tintColor = UIColor.unSelectedTextColor
            
            self.archivedButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.archivedButton.tintColor = UIColor.unSelectedTextColor
            
            self.requestsButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.requestsButton.tintColor = UIColor.unSelectedTextColor
            
        case 3: print("🟢 STATE -> Archived")
            
            self.archivedButton.backgroundColor = UIColor .white
            self.archivedButton.tintColor = UIColor .black
            
            self.bestiesButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.bestiesButton.tintColor = UIColor.unSelectedTextColor
            
            self.familyButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.familyButton.tintColor = UIColor.unSelectedTextColor
            
            self.requestsButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.requestsButton.tintColor = UIColor.unSelectedTextColor
            
        case 4: print("🟢 STATE -> Requests")
            
            self.requestsButton.backgroundColor = UIColor .white
            self.requestsButton.tintColor = UIColor .black
            
            self.bestiesButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.bestiesButton.tintColor = UIColor.unSelectedTextColor
            
            self.familyButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.familyButton.tintColor = UIColor.unSelectedTextColor
            
            self.archivedButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            self.archivedButton.tintColor = UIColor.unSelectedTextColor
            
        default: print("nothing")
            
        }
    }
    
    @objc func handleBackButton() {
        self.messagesContainer?.handleBackButton()
    }
   
    @objc func handleNewConvoIcon(sender:UIButton) {
        print(#function)
    }
   
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

///searching can be conducted down here where it's less noisy since this feature is confusing
extension MessagesHeader {
    
    func textFieldControl(shouldOpen : Bool) {
        UIDevice.vibrateLight()
        if shouldOpen {
            self.searchtextField.alpha = 1.0
            self.searchCancelButton.alpha = 1.0
            self.searchButton.isHidden = true
            self.newConversationButton.isHidden = true
            self.searchtextField.becomeFirstResponder()
        } else {
            self.searchtextField.alpha = 0.0
            self.searchCancelButton.alpha = 0.0
            self.searchButton.isHidden = false
            self.newConversationButton.isHidden = false
            self.searchtextField.text = ""
            self.searchtextField.resignFirstResponder()
        }
    }
    
    @objc func handleSearchIconOpen(sender:UIButton) {
        UIDevice.vibrateLight()
        self.textFieldControl(shouldOpen: true)
    }
    
    @objc func handleCloseSearchField() {
        UIDevice.vibrateLight()
        self.textFieldControl(shouldOpen: false)
    }
    
    @objc func handleSearchTextFieldChange(textField : UITextField) {
        guard let typedText = textField.text else {return}
        self.filteredCount(searchText: typedText)
    }
    
    func filteredCount(searchText: String) {
        print("search text: \(searchText)")
    }
}
