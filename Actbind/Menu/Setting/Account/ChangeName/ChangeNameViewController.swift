//
//  ChangeNameViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class ChangeNameViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var nameExplanationLabel: UILabel!
    @IBOutlet weak var name1TextField: UITextField!
    @IBOutlet weak var name2TextField: UITextField!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("namae", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                confirmationButton.backgroundColor = UIColor(named: appColor!)
            }

            name1TextField.text = name1

            name2TextField.text = name2
        }
        
        backButton.image = UIImage(named: "back")

        nameExplanationLabel.text = NSLocalizedString("namaesetumei", comment: "")
        
        if NSLocalizedString("language", comment: "") == "Arabic" || NSLocalizedString("language", comment: "") == "Chinese, Sim" || NSLocalizedString("language", comment: "") == "Chinese, Tra" || NSLocalizedString("language", comment: "") == "Hebrew" || NSLocalizedString("language", comment: "") == "Hungarian" || NSLocalizedString("language", comment: "") == "Japanese" || NSLocalizedString("language", comment: "") == "Korean" {
            name1TextField.textContentType = .familyName
            name2TextField.textContentType = .givenName
        } else {
            name1TextField.textContentType = .givenName
            name2TextField.textContentType = .familyName
        }
        
        name1TextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("namae1", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        name1TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        name1TextField.leftViewMode = UITextField.ViewMode.always
        name1TextField.layer.cornerRadius = 8
        name1TextField.layer.borderColor = UIColor.lightGray.cgColor
        name1TextField.layer.borderWidth = 1
        name1TextField.layer.masksToBounds = true
        
        name2TextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("namae2", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // name1TextField.textContentType = UITextContentType.givenName
        name2TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        name2TextField.leftViewMode = UITextField.ViewMode.always
        name2TextField.layer.cornerRadius = 8
        name2TextField.layer.borderColor = UIColor.lightGray.cgColor
        name2TextField.layer.borderWidth = 1
        name2TextField.layer.masksToBounds = true
        
        confirmationButton.setTitle(NSLocalizedString("kakuninn", comment: ""), for: .normal)
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

    @IBAction func name1TextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func name1TextFieldEditingChanged(_ sender: Any) {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            // name1TextFieldが入力されていない時
            if name1TextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
                // name2TextFieldが入力されていない時
            } else if name2TextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
            } else {
                if appColor == "Original" {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: "Blue")
                } else {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: appColor!)
                }
            }
        }
    }

    @IBAction func name1TextFieldEditingDidBegin(_ sender: Any) {
        name1TextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func name1TextFieldEditingDidEnd(_ sender: Any) {
        name1TextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func name2TextFieldDidEndOnExit(_ sender: Any) {}
    
    @IBAction func name2TextFieldEditingChanged(_ sender: Any) {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            // name1TextFieldが入力されていない時
            if name1TextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
                // name2TextFieldが入力されていない時
            } else if name2TextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
            } else {
                if appColor == "Original" {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: "Blue")
                } else {
                    confirmationButton.isEnabled = true
                    confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    confirmationButton.backgroundColor = UIColor(named: appColor!)
                }
            }
        }
    }

    @IBAction func name2TextFieldEditingDidBegin(_ sender: Any) {
        name2TextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func name2TextFieldEditingDidEnd(_ sender: Any) {
        name2TextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func confirmationButtonTouchDown(_ sender: Any) {
        confirmationButton.alpha = 0.5
        confirmationButtonRight.constant = 25
        confirmationButtonLeft.constant = 25
    }
    
    @IBAction func confirmationButtonTouchDragOutside(_ sender: Any) {
        confirmationButton.alpha = 1.0
        confirmationButtonRight.constant = 20
        confirmationButtonLeft.constant = 20
    }
    
    @IBAction func confirmationButtonTouchUpInside(_ sender: Any) {
        confirmationButton.alpha = 1.0
        confirmationButtonRight.constant = 20
        confirmationButtonLeft.constant = 20
        
        name1TextField.endEditing(true)
        name2TextField.endEditing(true)

        let name1TextFieldNotwhitespaces = name1TextField.text!.remove(characterSet: .whitespaces)
        let name2TextFieldNotwhitespaces = name2TextField.text!.remove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
        
            if name1TextFieldNotwhitespaces == name1 {
                if name2TextFieldNotwhitespaces == name2 {
                    navigationController?.popViewController(animated: true)
                } else {
                    performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
                }
            } else {
                performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
            }
        }
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name1TextFieldNotwhitespaces = name1TextField.text!.remove(characterSet: .whitespaces)
        let name2TextFieldNotwhitespaces = name2TextField.text!.remove(characterSet: .whitespaces)
        
        // Segueの識別子確認
        if segue.identifier == "toSaveNewInformationViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SaveNewInformationViewController
     
            // 値の設定
            nextView.name1 = name1TextFieldNotwhitespaces
            nextView.name2 = name2TextFieldNotwhitespaces
        }
    }
}
