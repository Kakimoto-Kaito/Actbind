//
//  PersonalInformationViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class PersonalInformationViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var contactInfoLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var birthdayLabel: UILabel!
    @IBOutlet weak var deleteYourAccountLabel: UILabel!
    @IBOutlet weak var nextImage1: UIImageView!
    @IBOutlet weak var nextImage2: UIImageView!
    @IBOutlet weak var nextImage3: UIImageView!
    @IBOutlet weak var nextImage4: UIImageView!
    @IBOutlet weak var nextImage5: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("kojinnnojyouhou", comment: "")

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
                nextImage4.image = UIImage(named: "defaultNext")
                nextImage5.image = UIImage(named: "defaultNext")
            } else if appColor == "Red" {
                nextImage1.image = UIImage(named: "redNext")
                nextImage2.image = UIImage(named: "redNext")
                nextImage3.image = UIImage(named: "redNext")
                nextImage4.image = UIImage(named: "redNext")
                nextImage5.image = UIImage(named: "redNext")
            } else if appColor == "Orange" {
                nextImage1.image = UIImage(named: "orangeNext")
                nextImage2.image = UIImage(named: "orangeNext")
                nextImage3.image = UIImage(named: "orangeNext")
                nextImage4.image = UIImage(named: "orangeNext")
                nextImage5.image = UIImage(named: "orangeNext")
            } else if appColor == "Yellow" {
                nextImage1.image = UIImage(named: "yellowNext")
                nextImage2.image = UIImage(named: "yellowNext")
                nextImage3.image = UIImage(named: "yellowNext")
                nextImage4.image = UIImage(named: "yellowNext")
                nextImage5.image = UIImage(named: "yellowNext")
            } else if appColor == "Green" {
                nextImage1.image = UIImage(named: "greenNext")
                nextImage2.image = UIImage(named: "greenNext")
                nextImage3.image = UIImage(named: "greenNext")
                nextImage4.image = UIImage(named: "greenNext")
                nextImage5.image = UIImage(named: "greenNext")
            } else if appColor == "Blue" {
                nextImage1.image = UIImage(named: "blueNext")
                nextImage2.image = UIImage(named: "blueNext")
                nextImage3.image = UIImage(named: "blueNext")
                nextImage4.image = UIImage(named: "blueNext")
                nextImage5.image = UIImage(named: "blueNext")
            } else {
                nextImage1.image = UIImage(named: "purpleNext")
                nextImage2.image = UIImage(named: "purpleNext")
                nextImage3.image = UIImage(named: "purpleNext")
                nextImage4.image = UIImage(named: "purpleNext")
                nextImage5.image = UIImage(named: "purpleNext")
            }
        }
        
        backButton.image = UIImage(named: "back")

        nameLabel.text = NSLocalizedString("namae", comment: "")

        contactInfoLabel.text = NSLocalizedString("rennrakusakijyouhou", comment: "")

        genderLabel.text = NSLocalizedString("seibetu", comment: "")

        birthdayLabel.text = NSLocalizedString("tannjyoubi", comment: "")

        deleteYourAccountLabel.text = NSLocalizedString("akaunntokannri", comment: "")
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
}
