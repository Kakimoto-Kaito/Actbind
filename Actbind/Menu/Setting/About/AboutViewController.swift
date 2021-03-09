//
//  AboutViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class AboutViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var termsOfServiceLabel: UILabel!
    @IBOutlet weak var nextImage1: UIImageView!
    @IBOutlet weak var privacyPolicyLabel: UILabel!
    @IBOutlet weak var nextImage2: UIImageView!
    @IBOutlet weak var licenseLabel: UILabel!
    @IBOutlet weak var nextImage3: UIImageView!
    @IBOutlet weak var versionText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("actbindnituite", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
            }

            if appColor == "Original" {
                nextImage1.image = UIImage(named: "defaultNext")
                nextImage2.image = UIImage(named: "defaultNext")
                nextImage3.image = UIImage(named: "defaultNext")
            } else if appColor == "Red" {
                nextImage1.image = UIImage(named: "redNext")
                nextImage2.image = UIImage(named: "redNext")
                nextImage3.image = UIImage(named: "redNext")
            } else if appColor == "Orange" {
                nextImage1.image = UIImage(named: "orangeNext")
                nextImage2.image = UIImage(named: "orangeNext")
                nextImage3.image = UIImage(named: "orangeNext")
            } else if appColor == "Yellow" {
                nextImage1.image = UIImage(named: "yellowNext")
                nextImage2.image = UIImage(named: "yellowNext")
                nextImage3.image = UIImage(named: "yellowNext")
            } else if appColor == "Green" {
                nextImage1.image = UIImage(named: "greenNext")
                nextImage2.image = UIImage(named: "greenNext")
                nextImage3.image = UIImage(named: "greenNext")
            } else if appColor == "Blue" {
                nextImage1.image = UIImage(named: "blueNext")
                nextImage2.image = UIImage(named: "blueNext")
                nextImage3.image = UIImage(named: "blueNext")
            } else {
                nextImage1.image = UIImage(named: "purpleNext")
                nextImage2.image = UIImage(named: "purpleNext")
                nextImage3.image = UIImage(named: "purpleNext")
            }
        }
        
        backButton.image = UIImage(named: "back")

        termsOfServiceLabel.text = NSLocalizedString("riyoukiyaku", comment: "")
        privacyPolicyLabel.text = NSLocalizedString("puraibasi-porisi-", comment: "")
        licenseLabel.text = NSLocalizedString("raisensu", comment: "")

        versionText.text = NSLocalizedString("ba-jyonn", comment: "") + version
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toTermsOfServiceAboutActbindWebViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! AboutActbindWebViewController
     
            // 値の設定
            nextView.contents = "riyoukiyaku"
            nextView.weburl = "https://actbind.com/"
        }
        
        // Segueの識別子確認
        if segue.identifier == "toPrivacyPolicyAboutActbindWebViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! AboutActbindWebViewController
     
            // 値の設定
            nextView.contents = "puraibasi-porisi-"
            nextView.weburl = "https://actbind.com/"
        }
        
        // Segueの識別子確認
        if segue.identifier == "toLicenseAboutActbindWebViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! AboutActbindWebViewController
     
            // 値の設定
            nextView.contents = "raisensu"
            nextView.weburl = "https://actbind.com/"
        }
    }
}
