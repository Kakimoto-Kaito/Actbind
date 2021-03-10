//
//  SignUpOkViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpOkViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = 0
    var username = ""

    @IBOutlet weak var signUpOkTitleLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var startButtonRight: NSLayoutConstraint!
    @IBOutlet weak var startButtonLeft: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpOkTitleLabel.text = NSLocalizedString("actbindheyoukoso", comment: "")

        startButton.setTitle(NSLocalizedString("hajimeru", comment: ""), for: .normal)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)

        // データ登録・更新
        if let userDefaults = self.userDefaults {
            userDefaults.setValue(1, forKeyPath: "id")
            userDefaults.setValue("", forKeyPath: "createddate")
            userDefaults.setValue(name1, forKeyPath: "name1")
            userDefaults.setValue(name2, forKeyPath: "name2")
            userDefaults.setValue(mailaddress, forKeyPath: "mailaddress")
            userDefaults.setValue(password, forKeyPath: "password")
            userDefaults.setValue(gender, forKeyPath: "gender")
            userDefaults.setValue(birthday, forKeyPath: "birthday")
            userDefaults.setValue(username, forKeyPath: "username")
            let defaultProfileImage = UIImage(named: "defaultProfileImage")
            let profileImage = defaultProfileImage!.jpegData(compressionQuality: 1)
            userDefaults.setValue(profileImage, forKeyPath: "profileimage")
            userDefaults.setValue("", forKeyPath: "bio")
            userDefaults.setValue("Original", forKeyPath: "appcolor")
            userDefaults.setValue("On", forKeyPath: "savephoto")
            let likepostidArray: [Int] = []
            userDefaults.setValue(likepostidArray, forKey: "likepostid")
            // ログイン！
            userDefaults.setValue(true, forKeyPath: "loginrecord")
        }
    }

    @IBAction func startButtonTouchDown(_ sender: Any) {
        startButton.alpha = 0.5
        startButtonRight.constant = 25
        startButtonLeft.constant = 25
    }

    @IBAction func startButtonTouchDragOutside(_ sender: Any) {
        startButton.alpha = 1.0
        startButtonRight.constant = 20
        startButtonLeft.constant = 20
    }

    @IBAction func startButtonTouchUpInside(_ sender: Any) {
        startButton.alpha = 1.0
        startButtonRight.constant = 20
        startButtonLeft.constant = 20

        performSegue(withIdentifier: "toMainViewController", sender: nil)
    }
}
