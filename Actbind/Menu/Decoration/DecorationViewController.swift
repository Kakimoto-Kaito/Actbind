//
//  DecorationViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class DecorationViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet var screebEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var selectColorLabel: UILabel!
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var defaultSpaceView: UIView!
    @IBOutlet weak var defaultBorderView: UIView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var redSpaceView: UIView!
    @IBOutlet weak var redBorderView: UIView!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var orangeSpaceView: UIView!
    @IBOutlet weak var orangeBorderView: UIView!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var yellowSpaceView: UIView!
    @IBOutlet weak var yellowBorderView: UIView!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var greenSpaceView: UIView!
    @IBOutlet weak var greenBorderView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blueSpaceView: UIView!
    @IBOutlet weak var blueBorderView: UIView!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var purpleSpaceView: UIView!
    @IBOutlet weak var purpleBorderView: UIView!
    @IBOutlet weak var okButton: UIButton!
    @IBOutlet weak var okButtonRight: NSLayoutConstraint!
    @IBOutlet weak var okButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("dekore-syonn", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                okButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                okButton.backgroundColor = UIColor(named: appColor!)
            }

            if appColor == "Original" {
                selectColorLabel.text = NSLocalizedString("orijinaru", comment: "")

                defaultBorderView.backgroundColor = UIColor(named: "Border")
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Red" {
                selectColorLabel.text = NSLocalizedString("red", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor(named: "Border")
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Orange" {
                selectColorLabel.text = NSLocalizedString("orange", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor(named: "Border")
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Yellow" {
                selectColorLabel.text = NSLocalizedString("yellow", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor(named: "Border")
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Green" {
                selectColorLabel.text = NSLocalizedString("green", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor(named: "Border")
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Blue" {
                selectColorLabel.text = NSLocalizedString("blue", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor(named: "Border")
                purpleBorderView.backgroundColor = UIColor.clear
            } else if appColor == "Purple" {
                selectColorLabel.text = NSLocalizedString("purple", comment: "")

                defaultBorderView.backgroundColor = UIColor.clear
                redBorderView.backgroundColor = UIColor.clear
                orangeBorderView.backgroundColor = UIColor.clear
                yellowBorderView.backgroundColor = UIColor.clear
                greenBorderView.backgroundColor = UIColor.clear
                blueBorderView.backgroundColor = UIColor.clear
                purpleBorderView.backgroundColor = UIColor(named: "Border")
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        defaultButton.layer.cornerRadius = defaultButton.layer.bounds.width / 2
        defaultSpaceView.layer.cornerRadius = defaultSpaceView.layer.bounds.width / 2
        defaultBorderView.layer.cornerRadius = defaultBorderView.layer.bounds.width / 2
        
        redButton.layer.cornerRadius = redButton.layer.bounds.width / 2
        redSpaceView.layer.cornerRadius = redSpaceView.layer.bounds.width / 2
        redBorderView.layer.cornerRadius = redBorderView
            .layer.bounds.width / 2
        
        orangeButton.layer.cornerRadius = orangeButton.layer.bounds.width / 2
        orangeSpaceView.layer.cornerRadius = orangeSpaceView.layer.bounds.width / 2
        orangeBorderView.layer.cornerRadius = orangeBorderView
            .layer.bounds.width / 2
        
        yellowButton.layer.cornerRadius = yellowButton.layer.bounds.width / 2
        yellowSpaceView.layer.cornerRadius = yellowSpaceView.layer.bounds.width / 2
        yellowBorderView.layer.cornerRadius = yellowBorderView.layer.bounds.width / 2
        
        greenButton.layer.cornerRadius = greenButton.layer.bounds.width / 2
        greenSpaceView.layer.cornerRadius = greenSpaceView.layer.bounds.width / 2
        greenBorderView.layer.cornerRadius = greenBorderView.layer.bounds.width / 2
        
        blueButton.layer.cornerRadius = blueButton.layer.bounds.width / 2
        blueSpaceView.layer.cornerRadius = blueSpaceView.layer.bounds.width / 2
        blueBorderView.layer.cornerRadius = blueBorderView.layer.bounds.width / 2
        
        purpleButton.layer.cornerRadius = purpleButton.layer.bounds.width / 2
        purpleSpaceView.layer.cornerRadius = purpleSpaceView.layer.bounds.width / 2
        purpleBorderView.layer.cornerRadius = purpleBorderView.layer.bounds.width / 2
        
        okButton.setTitle(NSLocalizedString("OK", comment: ""), for: .normal)

        activityView.layer.cornerRadius = 16
        activityView.isHidden = true
        
        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 38, weight: .bold, scale: .default)
        checkmarkImage.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        activityLabel.text = NSLocalizedString("hennkounaiyousetteityuu", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func defaultButton(_ sender: Any) {
        backButton.tintColor = UIColor.label
        
        selectColorLabel.text = NSLocalizedString("orijinaru", comment: "")
        
        defaultBorderView.backgroundColor = UIColor(named: "Border")
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Blue")
    }
    
    @IBAction func redButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Red")
        
        selectColorLabel.text = NSLocalizedString("red", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor(named: "Border")
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Red")
    }
    
    @IBAction func orangeButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Orange")
        
        selectColorLabel.text = NSLocalizedString("orange", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor(named: "Border")
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Orange")
    }
    
    @IBAction func yellowButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Yellow")
        
        selectColorLabel.text = NSLocalizedString("yellow", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor(named: "Border")
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Yellow")
    }
    
    @IBAction func greenButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Green")
        
        selectColorLabel.text = NSLocalizedString("green", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor(named: "Border")
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Green")
    }
    
    @IBAction func blueButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Blue")
        
        selectColorLabel.text = NSLocalizedString("blue", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor(named: "Border")
        purpleBorderView.backgroundColor = UIColor.clear
        
        okButton.backgroundColor = UIColor(named: "Blue")
    }
    
    @IBAction func purpleButton(_ sender: Any) {
        backButton.tintColor = UIColor(named: "Purple")
        
        selectColorLabel.text = NSLocalizedString("purple", comment: "")
        
        defaultBorderView.backgroundColor = UIColor.clear
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor(named: "Border")
        
        okButton.backgroundColor = UIColor(named: "Purple")
    }
    
    @IBAction func okButtonTouchDown(_ sender: Any) {
        okButton.alpha = 0.5
        okButtonRight.constant = 25
        okButtonLeft.constant = 25
    }
    
    @IBAction func okButtonTouchDragOutside(_ sender: Any) {
        okButton.alpha = 1.0
        okButtonRight.constant = 20
        okButtonLeft.constant = 20
    }
    
    @IBAction func okButtonTouchUpInside(_ sender: Any) {
        okButton.alpha = 1.0
        okButtonRight.constant = 20
        okButtonLeft.constant = 20

        okButton.isEnabled = false
        defaultButton.isEnabled = false
        redButton.isEnabled = false
        orangeButton.isEnabled = false
        yellowButton.isEnabled = false
        greenButton.isEnabled = false
        blueButton.isEnabled = false
        purpleButton.isEnabled = false
        screebEdgePanGesture.isEnabled = false
        backButton.isEnabled = false

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
        
            if selectColorLabel.text == NSLocalizedString("orijinaru", comment: "") {
                if appColor == "Original" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Original", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else if selectColorLabel.text == NSLocalizedString("red", comment: "") {
                if appColor == "Red" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Red", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else if selectColorLabel.text == NSLocalizedString("orange", comment: "") {
                if appColor == "Orange" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Orange", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else if selectColorLabel.text == NSLocalizedString("yellow", comment: "") {
                if appColor == "Yellow" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Yellow", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else if selectColorLabel.text == NSLocalizedString("green", comment: "") {
                if appColor == "Green" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Green", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else if selectColorLabel.text == NSLocalizedString("blue", comment: "") {
                if appColor == "Blue" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Blue", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
            } else {
                if appColor == "Purple" {
                    navigationController?.popViewController(animated: true)
                } else {
                    userDefaults.setValue("Purple", forKeyPath: "appcolor")
                    activityView.isHidden = false
                    checkmarkImage.isHidden = true
                    activityIndicator.startAnimating()

                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)

                        self.activityIndicator.stopAnimating()
                        self.checkmarkImage.isHidden = false
                        self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                            self.performSegue(withIdentifier: "toRebootToMainViewController", sender: self)
                        }
                    }
                }
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
