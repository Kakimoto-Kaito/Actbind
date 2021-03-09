//
//  PhotoViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/23.
//

import UIKit

final class PhotoViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var savePhotoLabel: UILabel!
    @IBOutlet weak var savePhotoSwitch: UISwitch!
    @IBOutlet weak var savePhotoExplanationLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("syasinn", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let savePhoto = userDefaults.string(forKey: "savephoto")
            
            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                savePhotoSwitch.onTintColor = UIColor(named: "Green")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                savePhotoSwitch.onTintColor = UIColor(named: appColor!)
            }
            
            if savePhoto == "On" {
                savePhotoSwitch.isOn = true
            } else {
                savePhotoSwitch.isOn = false
            }
        }

        backButton.image = UIImage(named: "back")

        savePhotoLabel.text = NSLocalizedString("syasinnwohozonn", comment: "")
        
        savePhotoExplanationLabel.text = NSLocalizedString("syasinnwohozonnsetumei", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    @IBAction func savePhotoSwitchValueChanged(_ sender: Any) {
        if savePhotoSwitch.isOn == true {
            // データ登録・更新
            if let userDefaults = self.userDefaults {
                userDefaults.setValue("On", forKeyPath: "savephoto")
            }
        } else {
            // データ登録・更新
            if let userDefaults = self.userDefaults {
                userDefaults.setValue("Off", forKeyPath: "savephoto")
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
