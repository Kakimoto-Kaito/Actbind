//
//  SignUpCheckViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpCheckViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = 0
    var username = ""

    @IBOutlet weak var signUpOkTitleLabel: UILabel!
    @IBOutlet weak var signUpOkExplanationLabel: UILabel!
    @IBOutlet weak var termsOfServiceButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var signUpButtonRight: NSLayoutConstraint!
    @IBOutlet weak var signUpButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpOkTitleLabel.text = NSLocalizedString("tourokukannryou", comment: "")

        signUpOkExplanationLabel.text = NSLocalizedString("doui", comment: "")

        termsOfServiceButton.setTitle(NSLocalizedString("riyoukiyaku", comment: ""), for: .normal)

        signUpButton.setTitle(NSLocalizedString("touroku", comment: ""), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = NSLocalizedString("akaunntowoomotinokata", comment: "")
    }

    @IBAction func termsOfServiceButtonTouchDown(_ sender: Any) {
        termsOfServiceButton.backgroundColor = UIColor(named: "BlueHalf")
    }

    @IBAction func termsOfServiceButtonTouchDragOutside(_ sender: Any) {
        termsOfServiceButton.backgroundColor = UIColor.clear
    }

    @IBAction func termsOfServiceButtonTouchUpInside(_ sender: Any) {
        termsOfServiceButton.backgroundColor = UIColor.clear
    }

    @IBAction func signUpButtonTouchDown(_ sender: Any) {
        signUpButton.alpha = 0.5
        signUpButtonRight.constant = 25
        signUpButtonLeft.constant = 25
    }

    @IBAction func signUpButtonTouchDragOutside(_ sender: Any) {
        signUpButton.alpha = 1.0
        signUpButtonRight.constant = 20
        signUpButtonLeft.constant = 20
    }

    @IBAction func signUpButtonTouchUpInside(_ sender: Any) {
        signUpButton.alpha = 1.0
        signUpButtonRight.constant = 20
        signUpButtonLeft.constant = 20

        performSegue(withIdentifier: "toAccountCreatingViewController", sender: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func haveAccountButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toAboutActbindWebViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! AboutActbindWebViewController
     
            // 値の設定
            nextView.weburl = "https://actbind.com/"
        }
        
        // Segueの識別子確認
        if segue.identifier == "toAccountCreatingViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpAccountCreatingViewController

            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailaddress
            nextView.password = password
            nextView.gender = gender
            nextView.birthday = birthday
            nextView.username = username
        }
    }
}
