//
//  SignUpAccountNameViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpUserNameViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = 0

    @IBOutlet weak var signUpUserNameTitleLabel: UILabel!
    @IBOutlet weak var userNameExplanationLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
        print(birthday)
        signUpUserNameTitleLabel.text = NSLocalizedString("yu-za-ne-muwonyuuryoku", comment: "")

        userNameExplanationLabel.text = NSLocalizedString("yu-za-ne-musetumei", comment: "")

        userNameTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("yu-za-ne-mu", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        userNameTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        userNameTextField.leftViewMode = UITextField.ViewMode.always
        userNameTextField.layer.cornerRadius = 8
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
        userNameTextField.layer.borderWidth = 1
        userNameTextField.layer.masksToBounds = true

        errorViewBottom.constant = -60

        nextButton.setTitle(NSLocalizedString("tugihe", comment: ""), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = NSLocalizedString("akaunntowoomotinokata", comment: "")
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func userNameTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func userNameTextFieldEditingChanged(_ sender: Any) {
        // アカウントネームが正しい時
        if userNameTextField.text!.count >= 5, userNameTextField.text!.count <= 30 {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
            // アカウントネームが正しくない時
        } else {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
        }
    }

    @IBAction func userNameTextFieldEditingDidBegin(_ sender: Any) {
        userNameTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func userNameTextFieldEditingDidEnd(_ sender: Any) {
        userNameTextField.layer.borderColor = UIColor.lightGray.cgColor
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

        view.endEditing(true)

        // ユーザーネームが正しい時
        if UserNameViewController.isValidAccountName(userNameTextField.text!) {
            // ユーザーネームが数字だけでない時
            if !OnlyNumberViewController.isValidOnlyNumber(userNameTextField.text!) {
                // ユーザーネームがアンダーバーだけでない時
                if !OnlyUnderbarViewController.isValidOnlyUnderbar(userNameTextField.text!) {
                    performSegue(withIdentifier: "toSignUpCheckViewController", sender: nil)
                    // ユーザーネームがアンダーバーだけの時
                } else {
                    userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
                    errorLabel.text = NSLocalizedString("annda-ba-dakeera-", comment: "")
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
                // ユーザーネームが数字だけの時
            } else {
                userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
                errorLabel.text = NSLocalizedString("suujidakeera-", comment: "")
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
            // ユーザーネームが正しくない時
        } else {
            userNameTextField.layer.borderColor = UIColor.systemPink.cgColor
            errorLabel.text = NSLocalizedString("yu-za-ne-muera-", comment: "")
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

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // 入力された文字の大文字を小文字に
        let userNameMini = userNameTextField.text!.lowercased()
        let userNameMiniNotwhitespaces = userNameMini.remove(characterSet: .whitespaces)

        // Segueの識別子確認
        if segue.identifier == "toSignUpCheckViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpCheckViewController

            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailaddress
            nextView.password = password
            nextView.gender = gender
            nextView.birthday = birthday
            nextView.username = userNameMiniNotwhitespaces
        }
    }
}
