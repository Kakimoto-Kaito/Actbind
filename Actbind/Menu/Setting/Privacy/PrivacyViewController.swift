//
//  PrivacyViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/14.
//

import UIKit

final class PrivacyViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nextImage: UIImageView!
    @IBOutlet weak var accessLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("puraibasi-", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
            }

            if appColor == "Original" {
                nextImage.image = UIImage(named: "defaultNext")
            } else if appColor == "Red" {
                nextImage.image = UIImage(named: "redNext")
            } else if appColor == "Orange" {
                nextImage.image = UIImage(named: "orangeNext")
            } else if appColor == "Yellow" {
                nextImage.image = UIImage(named: "yellowNext")
            } else if appColor == "Green" {
                nextImage.image = UIImage(named: "greenNext")
            } else if appColor == "Blue" {
                nextImage.image = UIImage(named: "blueNext")
            } else {
                nextImage.image = UIImage(named: "purpleNext")
            }
        }

        accessLabel.text = NSLocalizedString("puraibasi-akusesujyoukyou", comment: "")

        backButton.image = UIImage(named: "back")
    }

    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    @IBAction func accessButtonTouchUpInside(_ sender: Any) {
        UIApplication.shared.open(URL(string: UIApplication.openSettingsURLString)!, options: [:], completionHandler: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
