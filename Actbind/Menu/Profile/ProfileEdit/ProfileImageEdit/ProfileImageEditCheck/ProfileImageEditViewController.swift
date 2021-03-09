//
//  ProfileImageEditViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit

final class ProfileImageEditViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    // 撮影画面で撮影した画像
    var profileimage: UIImage?
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("purofi-rusyasinn", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                saveButton.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                saveButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        saveButton.setTitleTextAttributes(attributes, for: .normal)
        saveButton.title = NSLocalizedString("hozonn", comment: "")
        
        profileImage.image = profileimage
        profileImage.layer.cornerRadius = profileImage.layer.bounds.width / 2
        
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
    }
    
    @IBAction func saveButton(_ sender: Any) {
        saveButton.isEnabled = false
        screenEdgePanGesture.isEnabled = false
        backButton.isEnabled = false
        
        activityView.isHidden = false
        checkmarkImage.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            let profileImage = self.profileimage!.jpegData(compressionQuality: 1)
            // データ登録・更新
            if let userDefaults = self.userDefaults {
                userDefaults.setValue(profileImage, forKeyPath: "profileimage")
            }
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            self.activityIndicator.stopAnimating()
            self.checkmarkImage.isHidden = false
            self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
