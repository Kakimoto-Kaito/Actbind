//
//  ChangeMailAddressViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import AudioToolbox
import UIKit

final class ChangeMailAddressViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var mailAddressExplanationLabel: UILabel!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorTextLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("rennrakusakijyouhou", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let mailaddress = userDefaults.string(forKey: "mailaddress")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                confirmationButton.backgroundColor = UIColor(named: appColor!)
            }

            mailAddressTextField.text = mailaddress
        }
        
        backButton.image = UIImage(named: "back")
        
        mailAddressExplanationLabel.text = NSLocalizedString("me-ruadoresusetumei", comment: "")

        mailAddressTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("me-ruadoresu", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        mailAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        mailAddressTextField.leftViewMode = UITextField.ViewMode.always
        mailAddressTextField.layer.cornerRadius = 8
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.masksToBounds = true
        
        errorTextLabel.text = ""
        errorViewBottom.constant = -60
        
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
    
    // 完了キーをタップでキーボードが閉じる
    @IBAction func mailAddressTextFieldDidEndOnExit(_ sender: Any) {}
    
    @IBAction func mailAddressTextFieldEditingChanged(_ sender: Any) {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            // mailAddressTextFieldが入力されていない時
            if mailAddressTextField.text == "" {
                confirmationButton.isEnabled = false
                confirmationButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "EnabledButton")
                // mailAddressTextFieldが入力されている時
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

    @IBAction func mailAddressTextFieldEditingDidBegin(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
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
        
        mailAddressTextField.endEditing(true)
        
        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()

        let mailAddressMiniNotwhitespaces = mailAddressMini.remove(characterSet: .whitespaces)

        if let userDefaults = userDefaults {
            let mailaddress = userDefaults.string(forKey: "mailaddress")

            // メールアドレスが正しい時
            if MailAddressViewController.isValidMailAddress(mailAddressTextField.text!) {
                if mailAddressMiniNotwhitespaces == mailaddress {
                    navigationController?.popViewController(animated: true)
                } else {
                    performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
                }
                // メールアドレスが正しくない時
            } else {
                mailAddressTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorTextLabel.text = NSLocalizedString("me-ruadoresuera-", comment: "")
                UIView.transition(
                    // アニメーションさせるview
                    with: errorView,
                    // アニメーションの秒数
                    duration: 0.2,
                    // アニメーションの指定 等速
                    options: [.curveLinear],
                    // アニメーション中の処理
                    animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: -114) },
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
                                animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: 114) },
                                completion: nil
                            )
                        }
                    }
                )

                AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
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
        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()

        let mailAddressMiniNotwhitespaces = mailAddressMini.remove(characterSet: .whitespaces)
        
        // Segueの識別子確認
        if segue.identifier == "toSaveNewInformationViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SaveNewInformationViewController
     
            // 値の設定
            nextView.mailaddress = mailAddressMiniNotwhitespaces
        }
    }
}
