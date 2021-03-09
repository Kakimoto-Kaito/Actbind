//
//  DeleteYourAccountViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class DeleteAccountViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var arigatouLabel: UILabel!
    @IBOutlet weak var tanosimiLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    @IBOutlet weak var deleteButtonRight: NSLayoutConstraint!
    @IBOutlet weak var deleteButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonRight: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonLeft: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("akaunntosakujyo", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                cancelButton.backgroundColor = UIColor(named: appColor!)
            }
        }

        backButton.image = UIImage(named: "back")
        
        arigatouLabel.text = NSLocalizedString("arigatou", comment: "")
        
        tanosimiLabel.text = NSLocalizedString("tanosimi", comment: "")
        
        deleteButton.setTitle(NSLocalizedString("sakujyo", comment: ""), for: .normal)
        
        cancelButton.setTitle(NSLocalizedString("kyannseru", comment: ""), for: .normal)
        
        activityView.layer.cornerRadius = 16
        activityView.isHidden = true
        
        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .default)
        checkmarkImage.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        activityLabel.text = NSLocalizedString("akaunntowosakujyotyuu", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    @IBAction func deleteButtonTouchDown(_ sender: Any) {
        deleteButtonRight.constant = 25
        deleteButtonLeft.constant = 25

        deleteButton.setTitleColor(UIColor(named: "Red"), for: .normal)
    }

    @IBAction func deleteButtonTouchDragOutside(_ sender: Any) {
        deleteButtonRight.constant = 20
        deleteButtonLeft.constant = 20

        deleteButton.setTitleColor(UIColor(named: "Red"), for: .normal)
    }

    @IBAction func deleteButtonTouchUpInside(_ sender: Any) {
        deleteButtonRight.constant = 20
        deleteButtonLeft.constant = 20

        deleteButton.setTitleColor(UIColor(named: "Red"), for: .normal)

        deleteButton.isEnabled = false
        screenEdgePanGesture.isEnabled = false
        backButton.isEnabled = false
        cancelButton.isEnabled = false
        
        activityView.isHidden = false
        checkmarkImage.isHidden = true
        activityIndicator.startAnimating()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            if let userDefaults = self.userDefaults {
                userDefaults.removeAll()
                UserDefaults.standard.removeAll()
            }
            
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            
            self.activityIndicator.stopAnimating()
            self.checkmarkImage.isHidden = false
            self.activityLabel.text = NSLocalizedString("akaunntogasakujyosaremasita", comment: "")
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.performSegue(withIdentifier: "toRebootToLoginViewController", sender: nil)
            }
        }
    }
    
    @IBAction func cancelButtonTouchDown(_ sender: Any) {
        cancelButton.alpha = 0.5
        cancelButtonRight.constant = 25
        cancelButtonLeft.constant = 25
    }
    
    @IBAction func cancelButtonTouchDragOutside(_ sender: Any) {
        cancelButton.alpha = 1.0
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20
    }
    
    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        cancelButton.alpha = 1.0
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20
        
        // 2つ前のViewControllerに戻る
        let index = navigationController!.viewControllers.count - 3
        navigationController?.popToViewController(navigationController!.viewControllers[index], animated: true)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
