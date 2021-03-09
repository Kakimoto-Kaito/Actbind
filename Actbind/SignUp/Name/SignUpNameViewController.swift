//
//  SignUpNameViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpNameViewController: UIViewController {
    @IBOutlet weak var signUpNameTitleLabel: UILabel!
    @IBOutlet weak var nameExplanationLabel: UILabel!
    @IBOutlet weak var name1TextField: UITextField!
    @IBOutlet weak var name2TextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNameTitleLabel.text = NSLocalizedString("namaewonyuuryoku", comment: "")

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
        name2TextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        name2TextField.leftViewMode = UITextField.ViewMode.always
        name2TextField.layer.cornerRadius = 8
        name2TextField.layer.borderColor = UIColor.lightGray.cgColor
        name2TextField.layer.borderWidth = 1
        name2TextField.layer.masksToBounds = true

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
    @IBAction func name1TextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func name1TextFieldEditingChanged(_ sender: Any) {
        // name1TextFieldが入力されていない時
        if name1TextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // name2TextFieldが入力されていない時
        } else if name2TextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // name1TextFieldとname2TextFieldが入力されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
    }

    @IBAction func name1TextFieldEditingDidBegin(_ sender: Any) {
        name1TextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func name1TextFieldEditingDidEnd(_ sender: Any) {
        name1TextField.layer.borderColor = UIColor.lightGray.cgColor
    }

    // 完了キーをタップでキーボードが閉じる
    @IBAction func name2TextFieldDidEndOnExit(_ sender: Any) {}

    @IBAction func name2TextFieldEditingChanged(_ sender: Any) {
        // name1TextFieldが入力されていない時
        if name1TextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // name2TextFieldが入力されていない時
        } else if name2TextField.text == "" {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // name1TextFieldとname2TextFieldが入力されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
    }

    @IBAction func name2TextFieldEditingDidBegin(_ sender: Any) {
        name2TextField.layer.borderColor = UIColor.systemBlue.cgColor
    }

    @IBAction func name2TextFieldEditingDidEnd(_ sender: Any) {
        name2TextField.layer.borderColor = UIColor.lightGray.cgColor
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

        performSegue(withIdentifier: "toSignUpMailAddressViewController", sender: nil)
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let name1TextFieldNotwhitespaces = name1TextField.text!.remove(characterSet: .whitespaces)
        let name2TextFieldNotwhitespaces = name2TextField.text!.remove(characterSet: .whitespaces)

        // Segueの識別子確認
        if segue.identifier == "toSignUpMailAddressViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpMailAddressViewController

            // 値の設定
            nextView.name1 = name1TextFieldNotwhitespaces
            nextView.name2 = name2TextFieldNotwhitespaces
        }
    }
}
