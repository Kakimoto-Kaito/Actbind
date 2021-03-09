//
//  AccountCreatingViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpAccountCreatingViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0
    var birthday = 0
    var username = ""

    @IBOutlet weak var accountCreatingLabel: UILabel!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()

        accountCreatingLabel.text = NSLocalizedString("akaunntowosakiseisiteimasu", comment: "")
        activityIndicator.startAnimating()

        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
            self.activityIndicator.stopAnimating()
            self.performSegue(withIdentifier: "toSignUpOkViewController", sender: nil)
        }
    }

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toSignUpOkViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpOkViewController

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
