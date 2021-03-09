//
//  ImageSpotlightViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/24.
//

import UIKit

class ImageSpotlightViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var spotlightimage: UIImage?
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var spotLightImageView: UIImageView!
    @IBOutlet weak var cancelButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            
            if appColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        cancelButton.setImage(UIImage(named: "cancel"), for: .normal)
        
        backgroundImageView.image = spotlightimage
        spotLightImageView.image = spotlightimage
    }
    
    @IBAction func cancelBurronTouchUpInside(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
