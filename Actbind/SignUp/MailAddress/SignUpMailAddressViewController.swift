//
//  SignUpMailAddressViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpMailAddressViewController: UIViewController {
    var name1 = ""
    var name2 = ""

    @IBOutlet weak var signUpMailAddressTitleLabel: UILabel!
    @IBOutlet weak var mailAddressExplanationLabel: UILabel!
    @IBOutlet weak var mailAddressTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var errorViewBottom: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpMailAddressTitleLabel.text = NSLocalizedString("me-ruadoresuwonyuuryoku", comment: "")

        mailAddressExplanationLabel.text = NSLocalizedString("me-ruadoresusetumei", comment: "")

        mailAddressTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("me-ruadoresu", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        mailAddressTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        mailAddressTextField.leftViewMode = UITextField.ViewMode.always
        mailAddressTextField.layer.cornerRadius = 8
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
        mailAddressTextField.layer.borderWidth = 1
        mailAddressTextField.layer.masksToBounds = true

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
    @IBAction func mailAddressTextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func mailAddressTextFieldEditingChanged(_ sender: Any) {
        // mailAddressTextFieldが入力されていない時
        if mailAddressTextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // mailAddressTextFieldが入力されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
    }

    @IBAction func mailAddressTextFieldEditingDidBegin(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func mailAddressTextFieldEditingDidEnd(_ sender: Any) {
        mailAddressTextField.layer.borderColor = UIColor.lightGray.cgColor
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

        // メールアドレスが正しい時
        if MailAddressViewController.isValidMailAddress(mailAddressTextField.text!) {
            performSegue(withIdentifier: "toSignUpPasswordViewController", sender: nil)
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
        // 入力されたメールアドレスを小文字にして代入
        let mailAddressMini = mailAddressTextField.text!.lowercased()
        let mailAddressMiniNotwhitespaces = mailAddressMini.remove(characterSet: .whitespaces)

        // 乱数
        // let confirmationCode = Int.random(in: 100000..<1000000)

        // Segueの識別子確認
        if segue.identifier == "toSignUpPasswordViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpPasswordViewController

            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailAddressMiniNotwhitespaces
            // nextView.confirmationCode = confirmationCode
        }
    }
}
