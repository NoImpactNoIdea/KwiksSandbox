//
//  WalletBalancePagination.swift
//  KwiksSandboxx
//
//  Created by Charlie Arcodia on 4/24/23.
//
//400 points high or so

import Foundation
import UIKit

class WalletBalancePagination : BaseView {
    
    var walletMain : WalletMain?
    var hasViewBeenLaidOut : Bool = false
    
    let trackLayer = CAShapeLayer()
    let pulseLayer = CAShapeLayer()
    let shapeLayer = CAShapeLayer()
    let shadowLayer = CAShapeLayer()
    
    //top container - this will house most of the components
    let containerView : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = .clear
        ff.isUserInteractionEnabled = true
        ff.layer.masksToBounds = true
        ff.layer.cornerRadius = 25
        ff.backgroundColor = UIColor.kwiksGreen
        
        return ff
    }()
    
    lazy var cashOutButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Cash Out", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = ColorKit().kwiksGreen
        cbf.tintColor = ColorKit().kwiksWhite
        cbf.addTarget(self, action: #selector(self.handleCashOutButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    lazy var addMoneyButton : UIButton = {
        
        let cbf = UIButton(type: .system)
        cbf.translatesAutoresizingMaskIntoConstraints = false
        cbf.setTitle("Add Money", for: UIControl.State.normal)
        cbf.titleLabel?.font = UIFont.init(name: FontKit().segoeSemiBold, size: 18)
        cbf.titleLabel?.adjustsFontSizeToFitWidth = true
        cbf.titleLabel?.numberOfLines = 1
        cbf.titleLabel?.adjustsFontForContentSizeCategory = true
        cbf.backgroundColor = ColorKit().kwiksWhite
        cbf.tintColor = UIColor.walletBrown
        cbf.addTarget(self, action: #selector(self.handleAddMoneyButton), for: .touchUpInside)
        
        return cbf
        
    }()
    
    var yourBalanceLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = .clear
        hfl.text = "Your Balance"
        hfl.textColor = UIColor.white
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 20)
        
        return hfl
    }()
    
    var usdEmblem : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = UIColor.emblemBrown.withAlphaComponent(0.6)
        hfl.text = "USD"
        hfl.textColor = UIColor.white
        hfl.textAlignment = .center
        hfl.layer.masksToBounds = true
        hfl.font = UIFont(name: FontKit().segoeSemiBold, size: 12)
        
        return hfl
    }()
    
    var balanceLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = UIColor.clear
        hfl.text = ""
        hfl.textColor = ColorKit().kwiksWhite
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeBold, size: 32)
        
        return hfl
    }()
    
    let cashIconButton : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "kwiks_white_dollar_sign")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        
        return sii
        
    }()
    
    let priceIncreaseContainer : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.backgroundColor = ColorKit().kwiksWhite
        ff.isUserInteractionEnabled = true
        ff.layer.masksToBounds = true
        
        return ff
    }()
    
    let arrowIncreaseIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "arrow_increase_icon")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        
        return sii
        
    }()
    
    var priceContainerLabel : UILabel = {
        
        let hfl = UILabel()
        hfl.translatesAutoresizingMaskIntoConstraints = false
        hfl.backgroundColor = UIColor.clear
        hfl.text = ""
        hfl.textColor = UIColor.kwiksMatteBlack
        hfl.textAlignment = .center
        hfl.font = UIFont(name: FontKit().segoeRegular, size: 12)
        
        return hfl
    }()
    
    //top container - this will house most of the components
    let dummyContainer : UIView = {
        
        let ff = UIView()
        ff.translatesAutoresizingMaskIntoConstraints = false
        ff.isUserInteractionEnabled = true
        ff.layer.masksToBounds = true
        ff.backgroundColor = UIColor.clear
        
        return ff
    }()
    
    let circlelabel : UILabel = {
        
        let cl = UILabel()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.textAlignment = .center
        cl.isUserInteractionEnabled = false
        cl.font = UIFont(name: FontKit().segoeBold, size: 2)
        cl.numberOfLines = 3
        cl.lineBreakMode = .byWordWrapping
        cl.textColor = .white
        cl.text = "CENTER"
        
        return cl
        
    }()
    
    let kingsCrownIcon : UIButton = {
        
        let sii = UIButton(type: .system)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.contentMode = .scaleAspectFit
        sii.isUserInteractionEnabled = true
        let image = UIImage(named: "wallet_crown")?.withRenderingMode(.alwaysOriginal)
        sii.setImage(image, for: UIControl.State.normal)
        sii.translatesAutoresizingMaskIntoConstraints = false
        sii.isUserInteractionEnabled = true
        sii.imageView?.contentMode = .scaleAspectFit
        
        return sii
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.backgroundWhiteishGrey
        self.addViews()
        
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if dummyContainer.frame.midX > 0 {
            if self.hasViewBeenLaidOut == false {
             
                self.hasViewBeenLaidOut = true
            }
        }
    }
    
    func addViews() {
        
        self.addSubview(self.containerView)
        
        self.addSubview(self.cashOutButton)
        self.addSubview(self.addMoneyButton)
        self.containerView.addSubview(self.yourBalanceLabel)
        self.containerView.addSubview(self.usdEmblem)
        self.containerView.addSubview(self.cashIconButton)
        self.containerView.addSubview(self.balanceLabel)
        self.containerView.addSubview(self.priceIncreaseContainer)
        
        self.priceIncreaseContainer.addSubview(self.arrowIncreaseIcon)
        self.priceIncreaseContainer.addSubview(self.priceContainerLabel)
        
        self.containerView.addSubview(self.dummyContainer)
        self.containerView.addSubview(self.cashIconButton)

        self.containerView.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        self.containerView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 25).isActive = true
        self.containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -25).isActive = true
        self.containerView.heightAnchor.constraint(equalToConstant: 182).isActive = true
        
        self.cashOutButton.topAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: 10).isActive = true
        self.cashOutButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        self.cashOutButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0).isActive = true
        self.cashOutButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
      
        self.cashOutButton.layer.cornerRadius = 25
        
        self.addMoneyButton.topAnchor.constraint(equalTo: self.cashOutButton.bottomAnchor, constant: 10).isActive = true
        self.addMoneyButton.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 0).isActive = true
        self.addMoneyButton.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: 0).isActive = true
        self.addMoneyButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        self.addMoneyButton.layer.cornerRadius = 25
        
        self.yourBalanceLabel.leftAnchor.constraint(equalTo: self.containerView.leftAnchor, constant: 28).isActive = true
        self.yourBalanceLabel.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 30).isActive = true
        self.yourBalanceLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        self.yourBalanceLabel.sizeToFit()
        
        self.usdEmblem.centerYAnchor.constraint(equalTo: self.yourBalanceLabel.centerYAnchor).isActive = true
        self.usdEmblem.leftAnchor.constraint(equalTo: self.yourBalanceLabel.rightAnchor, constant: 8).isActive = true
        self.usdEmblem.heightAnchor.constraint(equalToConstant: 22).isActive = true
        self.usdEmblem.widthAnchor.constraint(equalToConstant: 44).isActive = true
        self.usdEmblem.layer.cornerRadius = 22/2
        
        self.cashIconButton.topAnchor.constraint(equalTo: self.yourBalanceLabel.bottomAnchor, constant: 10).isActive = true
        self.cashIconButton.leftAnchor.constraint(equalTo: self.yourBalanceLabel.leftAnchor, constant: 4).isActive = true
        self.cashIconButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        self.cashIconButton.sizeToFit()
        
        self.balanceLabel.leftAnchor.constraint(equalTo: self.cashIconButton.rightAnchor, constant: 8).isActive = true
        self.balanceLabel.centerYAnchor.constraint(equalTo: self.cashIconButton.centerYAnchor, constant: -2).isActive = true
        self.balanceLabel.sizeToFit()
        
        self.priceIncreaseContainer.leftAnchor.constraint(equalTo: self.yourBalanceLabel.leftAnchor).isActive = true
        self.priceIncreaseContainer.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -31).isActive = true
        self.priceIncreaseContainer.heightAnchor.constraint(equalToConstant: 36).isActive = true
        self.priceIncreaseContainer.widthAnchor.constraint(equalToConstant: 143).isActive = true
        self.priceIncreaseContainer.layer.cornerRadius = 36/2
        
        self.arrowIncreaseIcon.centerYAnchor.constraint(equalTo: self.priceIncreaseContainer.centerYAnchor).isActive = true
        self.arrowIncreaseIcon.leftAnchor.constraint(equalTo: self.priceIncreaseContainer.leftAnchor, constant: 12).isActive = true
        self.arrowIncreaseIcon.heightAnchor.constraint(equalToConstant: 12).isActive = true
        self.arrowIncreaseIcon.sizeToFit()
        
        self.priceContainerLabel.leftAnchor.constraint(equalTo: self.arrowIncreaseIcon.rightAnchor, constant: 3).isActive = true
        self.priceContainerLabel.rightAnchor.constraint(equalTo: self.priceIncreaseContainer.rightAnchor, constant: -5).isActive = true
        self.priceContainerLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        self.priceContainerLabel.centerYAnchor.constraint(equalTo: self.priceIncreaseContainer.centerYAnchor).isActive = true
        self.priceContainerLabel.sizeToFit()
        
        self.dummyContainer.leftAnchor.constraint(equalTo: self.containerView.centerXAnchor, constant: 30).isActive = true
        self.dummyContainer.rightAnchor.constraint(equalTo: self.containerView.rightAnchor, constant: -10).isActive = true
        self.dummyContainer.bottomAnchor.constraint(equalTo: self.containerView.bottomAnchor, constant: -10).isActive = true
        self.dummyContainer.topAnchor.constraint(equalTo: self.containerView.topAnchor, constant: 10).isActive = true
        
        self.perform(#selector(self.handleProgression), with: nil, afterDelay: 0.1)
        
    }
    
    @objc func handleProgression() {
        self.addTheBezierCircle()
    }
    
    @objc func handleCashOutButton() {
        self.walletMain?.handleCashOutButton()
    }
    @objc func handleAddMoneyButton() {
        self.walletMain?.handleAddMoneyButton()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension WalletBalancePagination {
    
    @objc func addTheBezierCircle() {
        
        let center = CGPoint(x: dummyContainer.bounds.midX, y: dummyContainer.bounds.midY)

        let circularPath = UIBezierPath(arcCenter: .zero, radius: 43, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        let shadowPath = UIBezierPath(arcCenter: .zero, radius: 41, startAngle: 0, endAngle: 2*CGFloat.pi, clockwise: true)
        
        //BACKGROUND TRACK LAYER
        self.trackLayer.path = circularPath.cgPath
        self.trackLayer.fillColor = UIColor.kwiksGreen.cgColor
        self.trackLayer.strokeColor = UIColor.gray.withAlphaComponent(0.2).cgColor//this needs to be solid color
        self.trackLayer.lineWidth = 11.0
        self.trackLayer.position = center
        
        //LINE FILL - adjust me for the completion progress
        self.shapeLayer.path = circularPath.cgPath
        self.shapeLayer.fillColor = UIColor .clear.cgColor
        self.shapeLayer.strokeColor = UIColor.white.cgColor
        self.shapeLayer.lineWidth = 11
        self.shapeLayer.strokeEnd = 0.0
        self.shapeLayer.position = center
        self.shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        //LINE SHADOW COPY
        self.shadowLayer.path = shadowPath.cgPath
        self.shadowLayer.fillColor = UIColor .clear.cgColor
        self.shadowLayer.strokeColor = UIColor .white.withAlphaComponent(0.2).cgColor
        self.shadowLayer.lineWidth = 2.5
        self.shadowLayer.strokeEnd = 0.0
        
        self.shadowLayer.position = center
        self.shadowLayer.lineCap = CAShapeLayerLineCap.round
        
        //PULSE ANIMATION FILL
        self.pulseLayer.path = circularPath.cgPath
        self.pulseLayer.fillColor = UIColor .white.withAlphaComponent(0.15).cgColor
        self.pulseLayer.position = center
        
        self.dummyContainer.layer.addSublayer(pulseLayer)
        self.dummyContainer.layer.addSublayer(trackLayer)
        self.dummyContainer.layer.addSublayer(shapeLayer)
        self.dummyContainer.layer.addSublayer(shadowLayer)
        
        self.dummyContainer.addSubview(self.kingsCrownIcon)
        
        self.kingsCrownIcon.centerYAnchor.constraint(equalTo: self.dummyContainer.centerYAnchor, constant: 0).isActive = true
        self.kingsCrownIcon.centerXAnchor.constraint(equalTo: self.dummyContainer.centerXAnchor, constant: 0).isActive = true
        self.kingsCrownIcon.heightAnchor.constraint(equalToConstant: 26).isActive = true
        self.kingsCrownIcon.widthAnchor.constraint(equalToConstant: 26).isActive = true
        
        PulseLayerAnimation.pulseProperties(pulseLayer: self.pulseLayer, toValue: 1.08, duration: 1.2, repeatCount : Float.infinity)
        
    }
    
    ///range 0.0->1.0
    func adjustStroke(end:CGFloat) {
        self.shapeLayer.strokeEnd = end
    }
}

class PulseLayerAnimation {
    
    //PULSES ANY CALAYER
    static func pulseProperties(pulseLayer : CAShapeLayer, toValue : CGFloat, duration : Double, repeatCount : Float) {
        
        let animation = CABasicAnimation(keyPath: "transform.scale")
        
        animation.toValue = toValue
        animation.autoreverses = true
        animation.duration = duration
        animation.repeatCount = repeatCount
        animation.isRemovedOnCompletion = false
        
        pulseLayer.add(animation, forKey: "arbitrary")
        
    }
    
}
