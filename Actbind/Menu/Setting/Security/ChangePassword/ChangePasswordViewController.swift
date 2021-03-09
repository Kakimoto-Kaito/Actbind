//
//  ChangePasswordViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/14.
//

import AudioToolbox
import UIKit

final class ChangePasswordViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet var screenEdgePanGesture: UIScreenEdgePanGestureRecognizer!
    @IBOutlet weak var currentpasswordTextField: UITextField!
    @IBOutlet weak var passwordExplanationLabel: UILabel!
    @IBOutlet weak var newpasswordTextField: UITextField!
    @IBOutlet weak var newagainpasswordTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonRight: NSLayoutConstraint!
    @IBOutlet weak var saveButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var activityView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var checkmarkImage: UIImageView!
    @IBOutlet weak var activityLabel: UILabel!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var cancelButtonRight: NSLayoutConstraint!
    @IBOutlet weak var cancelButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("pasuwa-do", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                cancelButton.setTitleColor(UIColor(named: appColor!), for: .normal)
            }
        }

        backButton.image = UIImage(named: "back")

        currentpasswordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("gennzainopasuwa-do", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        currentpasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        currentpasswordTextField.leftViewMode = UITextField.ViewMode.always
        currentpasswordTextField.layer.cornerRadius = 8
        currentpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        currentpasswordTextField.layer.borderWidth = 1
        currentpasswordTextField.layer.masksToBounds = true

        passwordExplanationLabel.text = NSLocalizedString("pasuwa-dosetumei", comment: "")

        newpasswordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("atarasiipasuwa-do", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        newpasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        newpasswordTextField.leftViewMode = UITextField.ViewMode.always
        newpasswordTextField.layer.cornerRadius = 8
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newpasswordTextField.layer.borderWidth = 1
        newpasswordTextField.layer.masksToBounds = true

        newagainpasswordTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("atarasiipasuwa-domouitidonyuuryoku", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        newagainpasswordTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        newagainpasswordTextField.leftViewMode = UITextField.ViewMode.always
        newagainpasswordTextField.layer.cornerRadius = 8
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newagainpasswordTextField.layer.borderWidth = 1
        newagainpasswordTextField.layer.masksToBounds = true

        errorLabel.text = ""
        errorViewBottom.constant = -60

        saveButton.setTitle(NSLocalizedString("hozonn", comment: ""), for: .normal)

        cancelButton.setTitle(NSLocalizedString("kyannseru", comment: ""), for: .normal)

        activityView.layer.cornerRadius = 16
        activityView.isHidden = true

        let checkmarkConfig = UIImage.SymbolConfiguration(pointSize: 40, weight: .bold, scale: .default)
        checkmarkImage.image = UIImage(systemName: "checkmark", withConfiguration: checkmarkConfig)
        activityLabel.text = NSLocalizedString("hennkounaiyousetteityuu", comment: "")
    }

    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func currentpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func currentpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let appColor = userDefaults.string(forKey: "appcolor")

                        if appColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: appColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func currentpasswordTextFieldEditingDidBegin(_ sender: Any) {
        currentpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func currentpasswordTextFieldEditingDidEnd(_ sender: Any) {
        currentpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func newpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func newpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let appColor = userDefaults.string(forKey: "appcolor")

                        if appColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: appColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func newpasswordTextFieldEditingDidBegin(_ sender: Any) {
        newpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        currentpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func newpasswordTextFieldEditingDidEnd(_ sender: Any) {
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func newagainpasswordDidEndOnExit(_ sender: Any) {}

    @IBAction func newagainpasswordTextFieldEditingChanged(_ sender: Any) {
        // passwordTextFieldに入力された文字数を取得
        let nowpasswordCount = currentpasswordTextField.text!.count
        let newpasswordCount = newpasswordTextField.text!.count
        let newagainpasswordCount = newagainpasswordTextField.text!.count

        // パスワードが8文字以上の時
        if nowpasswordCount >= 8 {
            // パスワードが8文字以上の時
            if newpasswordCount >= 8 {
                // パスワードが8文字以上の時
                if newagainpasswordCount >= 8 {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if let userDefaults = userDefaults {
                        let appColor = userDefaults.string(forKey: "appcolor")

                        if appColor == "Original" {
                            saveButton.backgroundColor = UIColor(named: "Blue")
                        } else {
                            saveButton.backgroundColor = UIColor(named: appColor!)
                        }
                    }
                    // パスワードが8文字未満の時
                } else {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                }
                // パスワードが8文字未満の時
            } else {
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
            // パスワードが8文字未満の時
        } else {
            saveButton.isEnabled = false
            saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            saveButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func newagainpasswordTextFieldEditingDidBegin(_ sender: Any) {
        newagainpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        currentpasswordTextField.layer.borderColor = UIColor.systemBlue.cgColor
        newpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func newagainpasswordTextFieldEditingDidEnd(_ sender: Any) {
        newagainpasswordTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func saveButtonTouchDown(_ sender: Any) {
        saveButton.alpha = 0.5
        saveButtonRight.constant = 25
        saveButtonLeft.constant = 25
    }

    @IBAction func saveButtonTouchDragOutside(_ sender: Any) {
        saveButton.alpha = 1.0
        saveButtonRight.constant = 20
        saveButtonLeft.constant = 20
    }

    @IBAction func saveButtonTouchUpInside(_ sender: Any) {
        saveButton.alpha = 1.0
        saveButtonRight.constant = 20
        saveButtonLeft.constant = 20

        view.endEditing(true)

        let nowpasswordTextFieldNotwhitespaces = currentpasswordTextField.text!.remove(characterSet: .whitespaces)
        let newpasswordTextFieldNotwhitespaces = newpasswordTextField.text!.remove(characterSet: .whitespaces)
        let newagainpasswordTextFieldNotwhitespaces = newagainpasswordTextField.text!.remove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let password = userDefaults.string(forKey: "password")
            // パスワードが正しい時
            var afterPassword = ""
            
            for oneText in nowpasswordTextFieldNotwhitespaces {
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
            
            if password == afterPassword {
                // パスワードが正しい時
                if PasswordViewController.isValidPassword(newpasswordTextFieldNotwhitespaces) {
                    // パスワードが正しい時
                    if PasswordViewController.isValidPassword(newagainpasswordTextFieldNotwhitespaces) {
                        if newpasswordTextFieldNotwhitespaces == newagainpasswordTextFieldNotwhitespaces {
                            var afterPassword = ""
                            
                            for oneText in newpasswordTextFieldNotwhitespaces {
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
                            if password == afterPassword {
                                navigationController?.popViewController(animated: true)
                            } else {
                                saveButton.isEnabled = false
                                screenEdgePanGesture.isEnabled = false
                                backButton.isEnabled = false
                                cancelButton.isEnabled = false

                                activityView.isHidden = false
                                checkmarkImage.isHidden = true
                                activityIndicator.startAnimating()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    userDefaults.setValue(afterPassword, forKeyPath: "password")

                                    let generator = UINotificationFeedbackGenerator()
                                    generator.notificationOccurred(.success)

                                    self.activityIndicator.stopAnimating()
                                    self.checkmarkImage.isHidden = false
                                    self.activityLabel.text = NSLocalizedString("hennkounaiyouhozonn", comment: "")

                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                                        self.navigationController?.popViewController(animated: true)
                                    }
                                }
                            }
                        } else {
                            newpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                            newagainpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                            errorLabel.text = NSLocalizedString("pasuwa-dogaittisimasenn", comment: "")
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
                        // パスワードが正しくない時
                    } else {
                        newagainpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
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
                    // パスワードが正しくない時
                } else {
                    newpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
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
                // パスワードが正しくない時
            } else {
                currentpasswordTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorLabel.text = NSLocalizedString("gennzainopasuwa-dogamatigatteimasu", comment: "")
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

    @IBAction func cancelButtonTouchDown(_ sender: Any) {
        cancelButtonRight.constant = 25
        cancelButtonLeft.constant = 25

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "BlueHalf"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: appColor! + "Half"), for: .normal)
            }
        }
    }

    @IBAction func cancelButtonTouchDragOutside(_ sender: Any) {
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: appColor!), for: .normal)
            }
        }
    }

    @IBAction func cancelButtonTouchUpInside(_ sender: Any) {
        cancelButtonRight.constant = 20
        cancelButtonLeft.constant = 20

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                cancelButton.setTitleColor(UIColor(named: "Blue"), for: .normal)
            } else {
                cancelButton.setTitleColor(UIColor(named: appColor!), for: .normal)
            }
        }

        navigationController?.popViewController(animated: true)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
