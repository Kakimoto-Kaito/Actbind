//
//  UpdateViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class UpdateViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var updateLabel: UILabel!
    @IBOutlet weak var updateButton: UIButton!
    @IBOutlet weak var updateButtonRight: NSLayoutConstraint!
    @IBOutlet weak var updateButtonLeft: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        updateLabel.text = NSLocalizedString("atarasiiba-jyonnni", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                updateButton.backgroundColor = UIColor(named: "Blue")
            } else {
                updateButton.backgroundColor = UIColor(named: appColor!)
            }
        }

        updateButton.setTitle(NSLocalizedString("appude-to", comment: ""), for: .normal)
    }

    @IBAction func updateButtonTouchDown(_ sender: Any) {
        updateButton.alpha = 0.5
        updateButtonRight.constant = 25
        updateButtonLeft.constant = 25
    }

    @IBAction func updateButtonTouchDragOutside(_ sender: Any) {
        updateButton.alpha = 1.0
        updateButtonRight.constant = 20
        updateButtonLeft.constant = 20
    }

    @IBAction func updateButtonTouchUpInside(_ sender: Any) {
        updateButton.alpha = 1.0
        updateButtonRight.constant = 20
        updateButtonLeft.constant = 20

        // TestFlightアプリのURL
        let url = URL(string: "https://itunes.apple.com/jp/app/apple-store/id899247664?mt=8")!

        // URLを開けるかをチェックする
        if UIApplication.shared.canOpenURL(url) {
            // URLを開く
            UIApplication.shared.open(url, options: [:]) { success in
                if success {
                    print("Launching \(url) was successful")
                }
            }
        }
    }
}
