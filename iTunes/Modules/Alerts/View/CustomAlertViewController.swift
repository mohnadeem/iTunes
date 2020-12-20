//
//  CustomAlertViewController.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 19/12/2020.
//

import UIKit

//customAlertStyles enumeration.
enum CustomAlertStyle {
    case defaultAlert
    case oneActionAlert
}

//custom alert delegation
@objc protocol CustomAlertViewDelegate: class {
    
    //called when action finished processing.
    func customAlertSecondButtonAction()
    @objc optional func customAlertFirstButtonAction()
}

class CustomAlertViewController: UIViewController {
    // MARK: Properties
    @IBOutlet weak var alertStackView: UIStackView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var secondButton: UIButton!
    @IBOutlet weak var centerButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var stackViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var alertViewCenterYConstraint: NSLayoutConstraint!
    
    // MARK: Data
    private var alertStyle: CustomAlertStyle = .defaultAlert
    private var delegate: CustomAlertViewDelegate?
    private var defaultAlertTitle = ""
    private var defaultAlertMsgText = ""
    private var defaultAlertBtnTitle = ""
    
    // MARK: Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        alertView.sizeToFit()
        customizeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupView()
        animateView()
    }
    
    // Remove observer on deinit
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    private func customizeView() {
        cancelButton.appStyle(title: "CANCEL".localized, font: AppFonts.small, textColor: AppColors.black)
        titleLabel.appStyle(text: "", font: AppFonts.alertBigBold, textColor: AppColors.black)
        messageLabel.appStyle(text: "", font: AppFonts.small, textColor: AppColors.grayXDark)
        dismissButton.isHidden = true
        centerButton.isHidden = true

        switch alertStyle {
        case .defaultAlert:
            titleLabel.text = defaultAlertTitle
            messageLabel.text = defaultAlertMsgText
            secondButton.appStyle(title: defaultAlertBtnTitle, font: AppFonts.smallBold, textColor: AppColors.blueDark, bgColor: AppColors.white, borderColor: AppColors.blueDark, cornerRadius: CGFloat(18), isReversedColors: true)
            dismissButton.isHidden = false
            break
        case .oneActionAlert:
            titleLabel.text = defaultAlertTitle
            messageLabel.text = defaultAlertMsgText
            cancelButton.isHidden = true
            secondButton.isHidden = true
            centerButton.isHidden = false
            centerButton.appStyle(title: defaultAlertBtnTitle, font: AppFonts.smallBold, textColor: AppColors.blueDark, bgColor: AppColors.white, borderColor: AppColors.blueDark, cornerRadius: CGFloat(18), isReversedColors: true)
            break
        }
    }
    
    private func setupView() {
        alertView.layer.cornerRadius = 10
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.6)
    }
    
    //show view with animation
    private func animateView() {
        alertView.alpha = 0;
        self.alertView.frame.origin.y = self.alertView.frame.origin.y + 50
        UIView.animate(withDuration: 0.4, animations: { () -> Void in
            self.alertView.alpha = 1.0;
            self.alertView.frame.origin.y = self.alertView.frame.origin.y - 50
        })
    }
    
    //set view style and appearance animation.
    private func setStyle(_ style:CustomAlertStyle){
        alertStyle = style
        self.providesPresentationContextTransitionStyle = true
        self.definesPresentationContext = true
        self.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        self.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
    }
    
    // set view data and components localized text
    func setData(style: CustomAlertStyle, delegate: CustomAlertViewDelegate?, title: String = "", message: String = "", actionTitle:String = "") {
        setStyle(style)
        self.delegate = delegate
        defaultAlertTitle = title
        defaultAlertMsgText = message
        defaultAlertBtnTitle = actionTitle
    }
    
    // MARK: Actions
    @IBAction func onDismissButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.customAlertFirstButtonAction?()
        }
    }
    
    @IBAction func onTapCancelButton(_ sender: Any) {
        self.dismiss(animated: true) {
            self.delegate?.customAlertFirstButtonAction?()
        }
    }
    
    @IBAction func onTapSecondButton(_ sender: Any) {
        secondButton.isEnabled = true
        self.dismiss(animated: true) {
            self.delegate?.customAlertSecondButtonAction()
        }
    }
    
    @IBAction func onTapCenterButton(_ sender: Any) {
        centerButton.isEnabled = true
        self.dismiss(animated: true) {
            self.delegate?.customAlertSecondButtonAction()
        }
    }
}
