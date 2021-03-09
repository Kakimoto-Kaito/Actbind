//
//  ProfileEditViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit

class ProfileEditViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var userProfileImageTitleLabel: UILabel!
    @IBOutlet weak var userProfileImageEditButton: UIButton!
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioEditButton: UIButton!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioButton: UIButton!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("purofi-ruwohennsyuu", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                userProfileImageEditButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
                bioEditButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                userProfileImageEditButton.setTitleColor(UIColor(named: appColor!), for: .normal)
                bioEditButton.setTitleColor(UIColor(named: appColor!), for: .normal)
            }
        }

        backButton.image = UIImage(named: "back")
        
        userProfileImageTitleLabel.text = NSLocalizedString("purofi-rusyasinn", comment: "")
        userProfileImageEditButton.setTitle(NSLocalizedString("hennsyuu", comment: ""), for: .normal)
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2
        
        bioTitleLabel.text = NSLocalizedString("jikosyoukai", comment: "")
        bioEditButton.setTitle(NSLocalizedString("hennsyuu", comment: ""), for: .normal)

        activityView.layer.cornerRadius = 16
        activityView.isHidden = true

        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .default)
        checkmarkImage.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        activityLabel.text = NSLocalizedString("hennkounaiyousetteityuu", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]

        if let userDefaults = userDefaults {
            let profileimage = userDefaults.data(forKey: "profileimage")
            let bio = userDefaults.string(forKey: "bio")

            let profileImage = UIImage(data: profileimage!)
            userProfileImage.image = profileImage

            if bio == "" {
                bioLabel.text = ""
                bioButton.setTitle(NSLocalizedString("jikosyoukai", comment: ""), for: .normal)
            } else {
                bioLabel.text = bio
                bioButton.setTitle("", for: .normal)
            }
        }
        
        bioButton.setTitleColor(UIColor(named: "TextFieldText"), for: .normal)
    }
    
    @IBAction func userProfileImageEditButtonTouchDown(_ sender: Any) {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "BlueHalf")
            } else if appColor == "Red" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "RedHalf")
            } else if appColor == "Orange" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "OrangeHalf")
            } else if appColor == "Yellow" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "YellowHalf")
            } else if appColor == "Green" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "GreenHalf")
            } else if appColor == "Blue" {
                userProfileImageEditButton.backgroundColor = UIColor(named: "BlueHalf")
            } else {
                userProfileImageEditButton.backgroundColor = UIColor(named: "PurpleHalf")
            }
        }
    }
    
    @IBAction func userProfileImageEditButtonTouchDragOutside(_ sender: Any) {
        userProfileImageEditButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func userProfileImageEditButtonTouchUpInside(_ sender: Any) {
        userProfileImageEditButton.backgroundColor = UIColor.clear
        
        UserDefaults.standard.set("Off", forKey: "flashonoff")

        let alertText = NSLocalizedString("purofi-rusyasinnhennkou", comment: "")
        let takePhotoText = NSLocalizedString("syasinnwotoru", comment: "")
        let removePhotoText = NSLocalizedString("gennzainosyasinnwosakujyo", comment: "")
        let cancelText = NSLocalizedString("kyannseru", comment: "")

        let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .actionSheet)

        let takePhotoButton = UIAlertAction(title: takePhotoText, style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toProfileImageInCameraView", sender: nil)
        })
        let removePhotoButton = UIAlertAction(title: removePhotoText, style: .default, handler: { _ in
            let alertText = NSLocalizedString("gennzainosyasinnwosakujyosimasuka", comment: "")
            let removeText = NSLocalizedString("sakujyo", comment: "")
            let cancelText = NSLocalizedString("kyannseru", comment: "")

            let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

            let removeButton = UIAlertAction(title: removeText, style: .destructive, handler: { _ in
                self.screenEdgePanGesture.isEnabled = false
                self.backButton.isEnabled = false
                self.userProfileImageEditButton.isEnabled = false
                self.tapGesture.isEnabled = false
                self.bioEditButton.isEnabled = false
                self.bioButton.isEnabled = false

                self.activityView.isHidden = false
                self.checkmarkImage.isHidden = true
                self.activityIndicator.startAnimating()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let defaultProfileImage = UIImage(named: "defaultProfileImage")
                    let profileImage = defaultProfileImage!.jpegData(compressionQuality: 1)
                    // データ登録・更新
                    if let userDefaults = self.userDefaults {
                        userDefaults.setValue(profileImage, forKeyPath: "profileimage")
                    }

                    let profileimage = UIImage(data: profileImage!)
                    self.userProfileImage.image = profileimage

                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)

                    self.activityIndicator.stopAnimating()
                    self.checkmarkImage.isHidden = false
                    self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.screenEdgePanGesture.isEnabled = true
                        self.backButton.isEnabled = true
                        self.userProfileImageEditButton.isEnabled = true
                        self.tapGesture.isEnabled = true
                        self.bioEditButton.isEnabled = true
                        self.bioButton.isEnabled = true

                        self.activityView.isHidden = true
                    }
                }
            })
            let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(removeButton)
            alertController.addAction(cancelButton)

            self.present(alertController, animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(takePhotoButton)
        alertController.addAction(removePhotoButton)
        alertController.addAction(cancelButton)

        alertController.popoverPresentationController?.sourceView = view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width / 2, y: screenSize.size.height, width: 0, height: 0)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        UserDefaults.standard.set("Off", forKey: "flashonoff")
        
        let alertText = NSLocalizedString("purofi-rusyasinnhennkou", comment: "")
        let takePhotoText = NSLocalizedString("syasinnwotoru", comment: "")
        let removePhotoText = NSLocalizedString("gennzainosyasinnwosakujyo", comment: "")
        let cancelText = NSLocalizedString("kyannseru", comment: "")

        let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .actionSheet)

        let takePhotoButton = UIAlertAction(title: takePhotoText, style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toProfileImageInCameraView", sender: nil)
        })
        let removePhotoButton = UIAlertAction(title: removePhotoText, style: .default, handler: { _ in
            let alertText = NSLocalizedString("gennzainosyasinnwosakujyosimasuka", comment: "")
            let removeText = NSLocalizedString("sakujyo", comment: "")
            let cancelText = NSLocalizedString("kyannseru", comment: "")

            let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

            let removeButton = UIAlertAction(title: removeText, style: .destructive, handler: { _ in
                self.screenEdgePanGesture.isEnabled = false
                self.backButton.isEnabled = false
                self.userProfileImageEditButton.isEnabled = false
                self.tapGesture.isEnabled = false
                self.bioEditButton.isEnabled = false
                self.bioButton.isEnabled = false

                self.activityView.isHidden = false
                self.checkmarkImage.isHidden = true
                self.activityIndicator.startAnimating()

                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    let defaultProfileImage = UIImage(named: "defaultProfileImage")
                    let profileImage = defaultProfileImage!.jpegData(compressionQuality: 1)
                    // データ登録・更新
                    if let userDefaults = self.userDefaults {
                        userDefaults.setValue(profileImage, forKeyPath: "profileimage")
                    }

                    let profileimage = UIImage(data: profileImage!)
                    self.userProfileImage.image = profileimage

                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.success)

                    self.activityIndicator.stopAnimating()
                    self.checkmarkImage.isHidden = false
                    self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        self.screenEdgePanGesture.isEnabled = true
                        self.backButton.isEnabled = true
                        self.userProfileImageEditButton.isEnabled = true
                        self.tapGesture.isEnabled = true
                        self.bioEditButton.isEnabled = true
                        self.bioButton.isEnabled = true

                        self.activityView.isHidden = true
                    }
                }
            })
            let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

            alertController.view.tintColor = UIColor(named: "BlackWhite")
            alertController.addAction(removeButton)
            alertController.addAction(cancelButton)

            self.present(alertController, animated: true, completion: nil)
        })
        let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(takePhotoButton)
        alertController.addAction(removePhotoButton)
        alertController.addAction(cancelButton)

        alertController.popoverPresentationController?.sourceView = view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width / 2, y: screenSize.size.height, width: 0, height: 0)

        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func bioEditButtonTouchDown(_ sender: Any) {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                bioEditButton.backgroundColor = UIColor(named: "BlueHalf")
            } else if appColor == "Red" {
                bioEditButton.backgroundColor = UIColor(named: "RedHalf")
            } else if appColor == "Orange" {
                bioEditButton.backgroundColor = UIColor(named: "OrangeHalf")
            } else if appColor == "Yellow" {
                bioEditButton.backgroundColor = UIColor(named: "YellowHalf")
            } else if appColor == "Green" {
                bioEditButton.backgroundColor = UIColor(named: "GreenHalf")
            } else if appColor == "Blue" {
                bioEditButton.backgroundColor = UIColor(named: "BlueHalf")
            } else {
                bioEditButton.backgroundColor = UIColor(named: "PurpleHalf")
            }
        }
    }
    
    @IBAction func bioEditButtonTouchDragOutside(_ sender: Any) {
        bioEditButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func bioEditButtonTouchUpInside(_ sender: Any) {
        bioEditButton.backgroundColor = UIColor.clear
        
        performSegue(withIdentifier: "toIntroductionMyselfEditView", sender: nil)
    }
    
    @IBAction func bioButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toIntroductionMyselfEditView", sender: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
