//
//  SettingViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class SettingViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var accountLabel: UILabel!
    @IBOutlet weak var privacyLabel: UILabel!
    @IBOutlet weak var securityLabel: UILabel!
    @IBOutlet weak var photoLabel: UILabel!
    @IBOutlet weak var appLanguageLabel: UILabel!
    @IBOutlet weak var aboutLabel: UILabel!
    @IBOutlet weak var accountImage: UIImageView!
    @IBOutlet weak var privacyImage: UIImageView!
    @IBOutlet weak var securityImage: UIImageView!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var appLanguageImage: UIImageView!
    @IBOutlet weak var aboutImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("settei", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        accountImage.image = UIImage(named: "アセット 456")
        accountLabel.text = NSLocalizedString("akaunnto", comment: "")

        privacyImage.image = UIImage(named: "privacy")
        privacyLabel.text = NSLocalizedString("puraibasi-", comment: "")

        securityImage.image = UIImage(named: "security")
        securityLabel.text = NSLocalizedString("sekyuritexi", comment: "")

        photoImage.image = UIImage(named: "アセット 462")
        photoLabel.text = NSLocalizedString("syasinn", comment: "")
        
        appLanguageImage.image = UIImage(named: "global")
        appLanguageLabel.text = NSLocalizedString("apurinogenngo", comment: "")

        aboutImage.image = UIImage(named: "about")
        aboutLabel.text = NSLocalizedString("actbindnituite", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func appLanguageButton(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
