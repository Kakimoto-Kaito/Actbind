//
//  SignUpConfirmationCodeViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import AudioToolbox
import UIKit

class SignUpConfirmationCodeViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var confirmationCode = ""

    @IBOutlet weak var signUpConfirmationCodeTitleLabel: UILabel!
    @IBOutlet weak var confirmationCodeExplanationLabel: UILabel!
    @IBOutlet weak var confirmationCodeRequestButton: UIButton!
    @IBOutlet weak var confirmationCodeTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        signUpConfirmationCodeTitleLabel.text = NSLocalizedString("ninnsyouko-dowonyuuryoku", comment: "")

        if NSLocalizedString("language", comment: "") == "Chinese, Sim" {
            confirmationCodeExplanationLabel.text = "输入我们发送给" + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Chinese, Tra" {
            confirmationCodeExplanationLabel.text = "輸入我們發送給" + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Dutch" {
            confirmationCodeExplanationLabel.text = "Voer de verificatiecode in die naar " + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "German" {
            confirmationCodeExplanationLabel.text = "Bitte geben Sie den an " + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Hindi" {
            confirmationCodeExplanationLabel.text = "हमारे द्वारा " + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Hungarian" {
            confirmationCodeExplanationLabel.text = "Kérjük, írja be az " + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Japanese" || NSLocalizedString("language", comment: "") == "Korean" {
            confirmationCodeExplanationLabel.text = mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else if NSLocalizedString("language", comment: "") == "Turkish" {
            confirmationCodeExplanationLabel.text = "Lütfen " + mailaddress + NSLocalizedString("ninnsyouko-dosetumei", comment: "")
        } else {
            confirmationCodeExplanationLabel.text = NSLocalizedString("ninnsyouko-dosetumei", comment: "") + mailaddress
        }
        
        confirmationCodeRequestButton.setTitle(NSLocalizedString("ninnsyouko-dorikuesuto", comment: ""), for: .normal)
        
        confirmationCodeTextField.placeholder = NSLocalizedString("ninnsyouko-do", comment: "")
        // UITextFieldの左側に余白（10px）を入れる
        confirmationCodeTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        confirmationCodeTextField.leftViewMode = UITextField.ViewMode.always
        confirmationCodeTextField.layer.cornerRadius = 8
        confirmationCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
        confirmationCodeTextField.layer.borderWidth = 1
        confirmationCodeTextField.layer.masksToBounds = true
        
        errorViewBottom.constant = -60
        
        nextButton.setTitle(NSLocalizedString("tugihe", comment: ""), for: .normal)
        
        haveAccountButton.title = NSLocalizedString("akaunntowoomotinokata", comment: "")
    }

    @IBAction func confirmationCodeRequestButtonTouchDown(_ sender: Any) {
        confirmationCodeRequestButton.backgroundColor = UIColor(named: "BlueHalf")
    }

    @IBAction func confirmationCodeRequestButtonTouchDragOutside(_ sender: Any) {
        confirmationCodeRequestButton.backgroundColor = UIColor.clear
    }

    @IBAction func confirmationCodeRequestButtonTouchUpInside(_ sender: Any) {
        confirmationCodeRequestButton.backgroundColor = UIColor.clear

        // 乱数
        let createConfirmationCode = Int.random(in: 100_000 ..< 1_000_000)
        // 乱数をstring型にする
        let requestConfirmationCodeString = String(createConfirmationCode)
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func ConfirmationCodeTextFieldDidEndOnExit(_ sender: Any) {}
    
    @IBAction func ConfirmationCodeTextFieldEditingChanged(_ sender: Any) {
        if confirmationCodeTextField.text!.count == 6 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor.lightGray, for: .normal)
            nextButton.backgroundColor = UIColor.systemGray5
        }
    }

    @IBAction func ConfirmationCodeTextFieldEditingDidBegin(_ sender: Any) {
        confirmationCodeTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func ConfirmationCodeTextFieldEditingDidEnd(_ sender: Any) {
        confirmationCodeTextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    @IBAction func nextButtonTouchDown(_ sender: Any) {
        nextButton.alpha = 0.5
        nextButtonRight.constant = 25
        nextButtonLeft.constant = 25
    }

    @IBAction func nextButtonTouchDragOutside(_ sender: Any) {
        nextButton.alpha = 1.0
        nextButtonRight.constant = 20
        nextButtonLeft.constant = 20
    }

    @IBAction func nextButtonTouchUpInside(_ sender: Any) {
        nextButton.alpha = 1.0
        nextButtonRight.constant = 20
        nextButtonLeft.constant = 20

        if confirmationCodeTextField.text == confirmationCode {
            performSegue(withIdentifier: "toSignUpPasswordViewController", sender: nil)
        } else {
            confirmationCodeTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = NSLocalizedString("ninnsyouko-doera-", comment: "")
            UIView.transition(
                // アニメーションさせるview
                with: errorView,
                // アニメーションの秒数
                duration: 0.2,
                // アニメーションの指定 等速
                options: [.curveLinear],
                // アニメーション中の処理
                animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: -163) },
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
                            animations: { self.errorView.transform = CGAffineTransform(translationX: 0, y: 163) },
                            completion: nil
                        )
                    }
                }
            )

            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func haveAccountButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // セグエ実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toSignUpPasswordViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpPasswordViewController
     
            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailaddress
        }
    }
}
