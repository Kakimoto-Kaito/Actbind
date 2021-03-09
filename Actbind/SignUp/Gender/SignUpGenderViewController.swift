//
//  SignUpGenderViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpGenderViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""

    @IBOutlet weak var signUpGenderTitleLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpGenderTitleLabel.text = NSLocalizedString("seibetuwosenntaku", comment: "")

        genderLabel.text = ""

        genderSegmentedControl.setTitle(NSLocalizedString("dannsei", comment: ""), forSegmentAt: 0)
        genderSegmentedControl.setTitle(NSLocalizedString("jyosei", comment: ""), forSegmentAt: 1)
        genderSegmentedControl.setTitle(NSLocalizedString("sonota", comment: ""), forSegmentAt: 2)

        nextButton.setTitle(NSLocalizedString("tugihe", comment: ""), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = NSLocalizedString("akaunntowoomotinokata", comment: "")
    }

    @IBAction func genderSegmentedControlValueChanged(_ sender: Any) {
        // セグメントが変更されたときの処理
        // 選択されているセグメントのインデックス
        let selectedIndex = genderSegmentedControl.selectedSegmentIndex
        // 選択されたインデックスの文字列を取得してラベルに設定
        genderLabel.text = genderSegmentedControl.titleForSegment(at: selectedIndex)

        // 選択されていない時
        if genderSegmentedControl.selectedSegmentIndex == UISegmentedControl.noSegment {
            nextButton.isEnabled = false
            nextButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "EnabledButton")
            // 選択されている時
        } else {
            nextButton.isEnabled = true
            nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
            nextButton.backgroundColor = UIColor(named: "Blue")
        }
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

        performSegue(withIdentifier: "toSignUpBirthdayViewController", sender: nil)
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
        if segue.identifier == "toSignUpBirthdayViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpBirthdayViewController

            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailaddress
            nextView.password = password
            // セグメントコントロールが何番目に止まっているかでスイッチ
            switch genderSegmentedControl.selectedSegmentIndex {
            case 0:
                nextView.gender = 1
            case 1:
                nextView.gender = 2
            case 2:
                nextView.gender = 9
            default:
                nextView.gender = 0
            }
        }
    }
}
