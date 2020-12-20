//
//  AbstractController.swift
//  iTunes
//
//  Created by Muhammad Nadeem on 16/12/2020.
//

import UIKit

class AbstractController: UIViewController, UITextFieldDelegate, UIGestureRecognizerDelegate {
    
    /// prevents adding tap gesture to dismiss keyboard -- this is used in scenes where there aren't input fields and the tap gesture may conflicts with libs e.g. Hakawai mentions due to textViewEndEditing
    internal var dismissKeyboardTapGesture: Bool = false
    var enableBackGesture: Bool = true {
        didSet {
            // enable swipe left back guesture
            self.navigationController?.interactivePopGestureRecognizer?.isEnabled = enableBackGesture
        }
    }
    
    /// Instaniate view controller from main story board
    ///
    /// **Warning:** Make sure to set storyboard id the same as the controller class name
    class func getInstance<T:AbstractController>(from storyboard:UIStoryboard) -> T?{
        return storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? T
    }
    
    public static var className:String {
        return String(describing: self.self)
    }
    
    // MARK: Navigation Bar
    func setNavBarTitle(title : String) {
        self.navigationItem.titleView = nil
        self.navigationItem.title = title
    }
    
    func setNavBarTitle(title: String, color: UIColor) {
        let titleViewFrame = CGRect(x: 80, y: 0, width: ScreenSize.width - 160, height: 44)
        let titleLabelFrame = CGRect(x: 0, y: 0, width: titleViewFrame.width, height: titleViewFrame.height)
        let titleView = UIView(frame: titleViewFrame)
        let titleLabel = UILabel(frame: titleLabelFrame)
        titleLabel.text = title
        titleLabel.textAlignment = .center
        titleLabel.font = AppFonts.normalBold
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.textColor = color
        titleView.addSubview(titleLabel)
        self.navigationItem.titleView = titleView
    }
    
    func setNavBarLogo(logo: UIImage) {
        let titleViewFrame = CGRect(x: 80, y: 0, width: ScreenSize.width - 160, height: 44)
        let titleView = UIView(frame: titleViewFrame)
        let iv = UIImageView(image: logo)
        iv.frame = CGRect(x: (titleViewFrame.width/2) - 22, y: 0, width: 44, height: titleViewFrame.height)
        iv.contentMode = .scaleAspectFit
        titleView.addSubview(iv)
        self.navigationItem.titleView = titleView
    }
    
    var showNavBorder:Bool = true {
        didSet {
            if let navigationController = UIApplication.visibleNavigationController() {
                navigationController.navigationBar.setBackgroundImage(UIImage(), for: .default)
                navigationController.navigationBar.shadowImage = UIImage()
                if(showNavBorder) {
                    navigationController.navigationBar.setBottomBorderColor(color: AppColors.gray)
                } else {
                    navigationController.navigationBar.setBottomBorderColor(color: UIColor.clear)
                }
            }
        }
    }
    
    /// Navigation bar custome back button
    var navBackButton : UIBarButtonItem  {
        let _navBackButton   = UIButton()
        _navBackButton.setImage(UIImage(named: "navBack"), for: .normal)
        _navBackButton.setImage(UIImage(named: "navBack"), for: .highlighted)
        _navBackButton.setImage(UIImage(named: "navBack"), for: .selected)
        _navBackButton.imageView?.contentMode = .scaleAspectFit
        _navBackButton.imageEdgeInsets = UIEdgeInsets.zero
        _navBackButton.addTarget(self, action: #selector(backButtonAction(_:)), for: .touchUpInside)
        return UIBarButtonItem(customView: _navBackButton)
    }

    
    
    /// Enable back button on left side of navigation bar
    var showNavBackButton: Bool = false {
        didSet {
            if (showNavBackButton) {
                self.navigationItem.leftBarButtonItem = navBackButton
            } else {
                self.navigationItem.leftBarButtonItems = nil
                self.navigationItem.leftBarButtonItems = nil
            }
        }
    }
    
    /// Show navigation bar loader
    func showNavLoader(dark: Bool, isViewInteractionEnabled: Bool = false) {
        let activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.startAnimating()
        if dark {
            activityIndicator.color = AppColors.green
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: activityIndicator)
        self.view.isUserInteractionEnabled = isViewInteractionEnabled
    }
    
    /// Hide navigation bar loader
    func hideNavLoader() {
        self.navigationItem.rightBarButtonItem = nil
        self.navigationItem.rightBarButtonItems = nil
        self.view.isUserInteractionEnabled = true
    }
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        if dismissKeyboardTapGesture {
            // hide keyboard when tapping on non input control
            let tapGesture: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
            tapGesture.cancelsTouchesInView = false
            view.addGestureRecognizer(tapGesture)
        }
        
        // add navigation title logo
        self.setNavBarTitle(title: "")
        
        // hide nav border by default
        self.showNavBorder = false
        
        // customize view
        self.customizeView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // hide default back button
        self.navigationItem.hidesBackButton = true
        self.navigationItem.backBarButtonItem = nil
        self.navigationController?.navigationBar.backItem?.backBarButtonItem = nil
        self.navigationController?.navigationBar.backItem?.title = ""
        self.navigationItem.setHidesBackButton(true, animated: false)
        self.navigationController?.navigationBar.backItem?.setHidesBackButton(true, animated: false)
        // enable swipe left back guesture
        if enableBackGesture {
            self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.view.endEditing(true)
    }
    
    /// Customize all view members (fonts - style - text)
    func customizeView() {
    }

    @objc func backButtonAction(_ sender: AnyObject) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @objc func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }
    
    //MARK: UIGuesture recognizer delegate
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldBeRequiredToFailBy otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
