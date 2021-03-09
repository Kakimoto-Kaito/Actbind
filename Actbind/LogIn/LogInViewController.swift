//
//  LogInViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class LogInViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var logInButton: UIButton!
    @IBOutlet weak var logInButtonRight: NSLayoutConstraint!
    @IBOutlet weak var logInButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpButtonRight: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        mailAddressTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("me-ruadoresu", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        mailAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        mailAddressTextField.leftViewMode = UITextField.ViewMode.always
        mailAddressTextField.layer.cornerRadius = 8
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.masksToBounds = true

        passwordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("pasuwa-do", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        passwordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        passwordTextField.leftViewMode = UITextField.ViewMode.always
        passwordTextField.layer.cornerRadius = 8
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderWidth = 1
        passwordTextField.layer.masksToBounds = true

        errorViewBottom.constant = -60

        logInButton.setTitle(NSLocalizedString("roguinn", comment: ""), for: .normal)

        signUpButton.setTitle(NSLocalizedString("atarasiiakaunntowosakusei", comment: ""), for: .normal)
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func mailAddressTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func mailAddressTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let passwordCount = passwordTextField.text!.count

        // パスワードが8文字以上の時
        if passwordCount >= 8 {
            // mailAddressTextFieldが入力されていない時
            if mailAddressTextField.text == "" {
                logInButton.isEnabled = false
                logInButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                logInButton.backgroundColor = UIColor(named: "EnabledButton")
                // mailAddressTextFieldが入力されている時
            } else {
                logInButton.isEnabled = true
                logInButton.setTitleColor(UIColor(named: "White"), for: .normal)
                logInButton.backgroundColor = UIColor(named: "Blue")
            }
            // パスワードが8文字未満の時
        } else {
            logInButton.isEnabled = false
            logInButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            logInButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func mailAddressTextFieldEditingDidBegin(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.systemBlue.cgColor
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func passwordTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func passwordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let passwordCount = passwordTextField.text!.count

        // パスワードが8文字以上の時
        if passwordCount >= 8 {
            // mailAddressTextFieldが入力されていない時
            if mailAddressTextField.text == "" {
                logInButton.isEnabled = false
                logInButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                logInButton.backgroundColor = UIColor(named: "EnabledButton")
                // mailAddressTextFieldが入力されている時
            } else {
                logInButton.isEnabled = true
                logInButton.setTitleColor(UIColor(named: "White"), for: .normal)
                logInButton.backgroundColor = UIColor(named: "Blue")
            }
            // パスワードが8文字未満の時
        } else {
            logInButton.isEnabled = false
            logInButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            logInButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func passwordTextFieldEditingDidBegin(_ sender: Any) {
        passwordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func passwordTextFieldEditingDidEnd(_ sender: Any) {
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func logInButtonTouchDown(_ sender: Any) {
        logInButton.alpha = 0.5
        logInButtonRight.constant = 25
        logInButtonLeft.constant = 25
    }

    @IBAction func logInButtonTouchDragOutside(_ sender: Any) {
        logInButton.alpha = 1.0
        logInButtonRight.constant = 20
        logInButtonLeft.constant = 20
    }

    @IBAction func logInButtonTouchUpInside(_ sender: Any) {
        logInButton.alpha = 1.0
        logInButtonRight.constant = 20
        logInButtonLeft.constant = 20

        view.endEditing(true)

        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()
        let mailAddressMiniNotwhitespaces = mailAddressMini.remove(characterSet: .whitespaces)
        let passwordTextFieldNotwhitespaces = passwordTextField.text!.remove(characterSet: .whitespaces)
        
        var afterPassword = ""
        
        for oneText in passwordTextFieldNotwhitespaces {
            let oneTextString = String(oneText)
            
            if oneTextString == "a" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "ns83bs")
                afterPassword += afterOneTextString
            } else if oneTextString == "b" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "8hs7hw")
                afterPassword += afterOneTextString
            } else if oneTextString == "c" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "js83js")
                afterPassword += afterOneTextString
            } else if oneTextString == "d" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "8m10wn")
                afterPassword += afterOneTextString
            } else if oneTextString == "e" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "92ns9m")
                afterPassword += afterOneTextString
            } else if oneTextString == "f" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "lai01k")
                afterPassword += afterOneTextString
            } else if oneTextString == "g" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "85bdhe")
                afterPassword += afterOneTextString
            } else if oneTextString == "h" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "unsi83")
                afterPassword += afterOneTextString
            } else if oneTextString == "i" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "85bd00")
                afterPassword += afterOneTextString
            } else if oneTextString == "j" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "85bu8f")
                afterPassword += afterOneTextString
            } else if oneTextString == "k" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "78y347")
                afterPassword += afterOneTextString
            } else if oneTextString == "l" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "0a1pij")
                afterPassword += afterOneTextString
            } else if oneTextString == "m" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "80434h")
                afterPassword += afterOneTextString
            } else if oneTextString == "n" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "hhh874")
                afterPassword += afterOneTextString
            } else if oneTextString == "o" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "7d7y74")
                afterPassword += afterOneTextString
            } else if oneTextString == "p" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "ncnr7c")
                afterPassword += afterOneTextString
            } else if oneTextString == "q" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "3d7ys7")
                afterPassword += afterOneTextString
            } else if oneTextString == "r" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "hzmq85")
                afterPassword += afterOneTextString
            } else if oneTextString == "s" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "7d4y7u")
                afterPassword += afterOneTextString
            } else if oneTextString == "t" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "7yd7yd")
                afterPassword += afterOneTextString
            } else if oneTextString == "u" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "j1fzb7")
                afterPassword += afterOneTextString
            } else if oneTextString == "v" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "7s378h")
                afterPassword += afterOneTextString
            } else if oneTextString == "w" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "hfcu8h")
                afterPassword += afterOneTextString
            } else if oneTextString == "x" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "nfufu4")
                afterPassword += afterOneTextString
            } else if oneTextString == "y" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jr8xy4")
                afterPassword += afterOneTextString
            } else if oneTextString == "z" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "hf5855")
                afterPassword += afterOneTextString
            } else if oneTextString == "A" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "fj45jf")
                afterPassword += afterOneTextString
            } else if oneTextString == "B" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jfu82f")
                afterPassword += afterOneTextString
            } else if oneTextString == "C" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "u58djd")
                afterPassword += afterOneTextString
            } else if oneTextString == "D" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "141fjn")
                afterPassword += afterOneTextString
            } else if oneTextString == "E" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "114i9j")
                afterPassword += afterOneTextString
            } else if oneTextString == "F" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "0p1huw")
                afterPassword += afterOneTextString
            } else if oneTextString == "G" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "q25kfi")
                afterPassword += afterOneTextString
            } else if oneTextString == "H" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "fu4283")
                afterPassword += afterOneTextString
            } else if oneTextString == "I" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "h0iewq")
                afterPassword += afterOneTextString
            } else if oneTextString == "J" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "mz1xu3")
                afterPassword += afterOneTextString
            } else if oneTextString == "K" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "8932jn")
                afterPassword += afterOneTextString
            } else if oneTextString == "L" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "0xasm3")
                afterPassword += afterOneTextString
            } else if oneTextString == "M" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "xfhu3i")
                afterPassword += afterOneTextString
            } else if oneTextString == "N" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jadz8d")
                afterPassword += afterOneTextString
            } else if oneTextString == "O" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "814jkd")
                afterPassword += afterOneTextString
            } else if oneTextString == "P" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jzdm89")
                afterPassword += afterOneTextString
            } else if oneTextString == "Q" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "18xurj")
                afterPassword += afterOneTextString
            } else if oneTextString == "R" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jmza39")
                afterPassword += afterOneTextString
            } else if oneTextString == "S" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "19zajk")
                afterPassword += afterOneTextString
            } else if oneTextString == "T" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "i93u2h")
                afterPassword += afterOneTextString
            } else if oneTextString == "U" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "lk3zaz")
                afterPassword += afterOneTextString
            } else if oneTextString == "V" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "918u89")
                afterPassword += afterOneTextString
            } else if oneTextString == "W" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "1274nf")
                afterPassword += afterOneTextString
            } else if oneTextString == "X" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "11izjj")
                afterPassword += afterOneTextString
            } else if oneTextString == "Y" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "890x13")
                afterPassword += afterOneTextString
            } else if oneTextString == "Z" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "1hx1uj")
                afterPassword += afterOneTextString
            } else if oneTextString == "0" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "fj2iu8")
                afterPassword += afterOneTextString
            } else if oneTextString == "1" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "izxhe2")
                afterPassword += afterOneTextString
            } else if oneTextString == "2" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "ucg83y")
                afterPassword += afterOneTextString
            } else if oneTextString == "3" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "kaljd8")
                afterPassword += afterOneTextString
            } else if oneTextString == "4" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "u23wuh")
                afterPassword += afterOneTextString
            } else if oneTextString == "5" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "t9u8xh")
                afterPassword += afterOneTextString
            } else if oneTextString == "6" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "jeqr83")
                afterPassword += afterOneTextString
            } else if oneTextString == "7" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "u8453u")
                afterPassword += afterOneTextString
            } else if oneTextString == "8" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "du34em")
                afterPassword += afterOneTextString
            } else if oneTextString == "9" {
                let afterOneTextString = oneTextString.replacingOccurrences(of: oneTextString, with: "924nf3")
                afterPassword += afterOneTextString
            }
        }
        
        if let userDefaults = userDefaults {
            let mailaddress = userDefaults.string(forKey: "mailaddress")
            let password = userDefaults.string(forKey: "password")

            // メールアドレスが正しい時
            if MailAddressViewController.isValidMailAddress(mailAddressTextField.text!) {
                // パスワードが正しい時
                if PasswordViewController.isValidPassword(passwordTextField.text!) {
                    activityIndicator.startAnimating()
                    logInButton.setTitle("", for: .normal)
                    logInButton.isEnabled = false
                    signUpButton.isEnabled = false
                    mailAddressTextField.isEnabled = false
                    passwordTextField.isEnabled = false
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                        self.activityIndicator.stopAnimating()
                        self.logInButton.setTitle(NSLocalizedString("roguinn", comment: ""), for: .normal)
                        self.logInButton.isEnabled = true
                        self.signUpButton.isEnabled = true
                        self.mailAddressTextField.isEnabled = true
                        self.passwordTextField.isEnabled = true
                        
                        // 登録時のメールアドレスと入力されたメールアドレスが同じ時
                        if mailaddress == mailAddressMiniNotwhitespaces {
                            // 登録時のパスワードと入力されたパスワードが同じ時
                            if password == afterPassword {
                                if let userDefaults = self.userDefaults {
                                    // ログイン！
                                    userDefaults.setValue(true, forKeyPath: "loginrecord")
                                }
                                self.performSegue(withIdentifier: "toMainViewController", sender: nil)
                                // 登録時のパスワードと入力されたパスワードが違う時
                            } else {
                                let title1 = self.mailAddressTextField.text! + NSLocalizedString("pasuwa-dogamatigatteimasu", comment: "")
                                let title2 = NSLocalizedString("pasuwa-dogamatigatteimasu", comment: "") + self.mailAddressTextField.text!
                                let title3 = NSLocalizedString("pasuwa-dogamatigatteimasu", comment: "") + self.mailAddressTextField.text! + " ไม่ถูกต้อง"
                                let title4 = NSLocalizedString("pasuwa-dogamatigatteimasu", comment: "") + self.mailAddressTextField.text! + "számára"

                                let message = NSLocalizedString("nyuuryokusaretapasuwa-dohatadasikuarimasenn", comment: "")
                                let retryText = NSLocalizedString("mouitidojikkou", comment: "")

                                if NSLocalizedString("language", comment: "") == "Arabic" || NSLocalizedString("language", comment: "") == "Chinese, Sim" || NSLocalizedString("language", comment: "") == "Chinese, Tra" || NSLocalizedString("language", comment: "") == "Hebrew" || NSLocalizedString("language", comment: "") == "Hindi" || NSLocalizedString("language", comment: "") == "Japanese" || NSLocalizedString("language", comment: "") == "Korean" {
                                    let alertController = UIAlertController(title: title1, message: message, preferredStyle: .alert)

                                    let retryButton = UIAlertAction(title: retryText, style: .cancel, handler: nil)

                                    alertController.addAction(retryButton)

                                    self.present(alertController, animated: true, completion: nil)
                                } else if NSLocalizedString("language", comment: "") == "Hungarian" {
                                    let alertController = UIAlertController(title: title4, message: message, preferredStyle: .alert)

                                    let retryButton = UIAlertAction(title: retryText, style: .cancel, handler: nil)

                                    alertController.addAction(retryButton)

                                    self.present(alertController, animated: true, completion: nil)
                                } else if NSLocalizedString("language", comment: "") == "Thai" {
                                    let alertController = UIAlertController(title: title3, message: message, preferredStyle: UIAlertController.Style.alert)

                                    let retryButton = UIAlertAction(title: retryText, style: UIAlertAction.Style.cancel, handler: nil)

                                    alertController.addAction(retryButton)

                                    self.present(alertController, animated: true, completion: nil)
                                } else {
                                    let alertController = UIAlertController(title: title2, message: message, preferredStyle: .alert)

                                    let retryButton = UIAlertAction(title: retryText, style: .cancel, handler: nil)

                                    alertController.addAction(retryButton)

                                    self.present(alertController, animated: true, completion: nil)
                                }

                                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                            }
                            // 登録時のメールアドレスと入力されたメールアドレスが違う時
                        } else {
                            let alertText = NSLocalizedString("me-ruadoresugatadasikuarimasenn", comment: "")
                            let message = NSLocalizedString("akaunntogaarimasenn", comment: "")
                            let retryText = NSLocalizedString("mouitidojikkou", comment: "")

                            let alertController = UIAlertController(title: alertText, message: message, preferredStyle: .alert)

                            let retryButton = UIAlertAction(title: retryText, style: .cancel, handler: nil)

                            alertController.addAction(retryButton)

                            self.present(alertController, animated: true, completion: nil)

                            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                        }
                    }
                    // パスワードが正しくない時
                } else {
                    passwordTextField.layer.borderColor = UIColor.systemPink.cgColor
                    errorLabel.text = NSLocalizedString("pasuwa-doera-", comment: "")
                    UIView.transition(
                        // アニメーションさせるview
                        with: errorView,
                        // アニメーションの秒数
                        duration: 0.2,
                        // アニメーションの指定 等速
                        options: [.curveLinear],
                        // アニメーション中の処理
                        animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: -182) },
                        completion: { (_: Bool) in
                            DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                                UIView.transition(
                                    // アニメーションさせるview
                                    with: self.errorView,
                                    // アニメーションの秒数
                                    duration: 0.2,
                                    // アニメーションの指定 等速
                                    options: [.curveLinear],
                                    // アニメーション中の処理
                                    animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: 182) },
                                    completion: nil
                                )
                            }
                        }
                    )

                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                }
                // メールアドレスが正しくない時
            } else {
                mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorLabel.text = NSLocalizedString("me-ruadoresuera-", comment: "")
                UIView.transition(
                    // アニメーションさせるview
                    with: errorView,
                    // アニメーションの秒数
                    duration: 0.2,
                    // アニメーションの指定 等速
                    options: [.curveLinear],
                    // アニメーション中の処理
                    animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: -182) },
                    completion: { (_: Bool) in
                        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0) {
                            UIView.transition(
                                // アニメーションさせるview
                                with: self.errorView,
                                // アニメーションの秒数
                                duration: 0.2,
                                // アニメーションの指定 等速
                                options: [.curveLinear],
                                // アニメーション中の処理
                                animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: 182) },
                                completion: nil
                            )
                        }
                    }
                )

                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
            }
        }
    }

    @IBAction func signUpButtonTouchDown(_ sender: Any) {
        signUpButtonRight.constant = 25
        signUpButtonLeft.constant = 25

        signUpButton.setTitleColor(UIColor(named: "BlueHalf"), for: .normal)
    }

    @IBAction func signUpButtonTouchDragoutside(_ sender: Any) {
        signUpButtonRight.constant = 20
        signUpButtonLeft.constant = 20

        signUpButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        signUpButtonRight.constant = 20
        signUpButtonLeft.constant = 20

        signUpButton.setTitleColor(UIColor(named: "Blue"), for: .normal)

        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
        passwordTextField.layer.borderColor = UIColor.lightGray.cgColor

        view.endEditing(true)
    }
}
