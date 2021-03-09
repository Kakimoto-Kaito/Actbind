//
//  SignUpBirthdayViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import AudioToolbox
import UIKit

final class SignUpBirthdayViewController: UIViewController {
    var name1 = ""
    var name2 = ""
    var mailaddress = ""
    var password = ""
    var gender = 0

    @IBOutlet weak var signUpBirthdayTitleLabel: UILabel!
    @IBOutlet weak var birthdayExplanationLabel: UILabel!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var nextButtonRight: NSLayoutConstraint!
    @IBOutlet weak var nextButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var birthdayPicker: UIDatePicker!
    @IBOutlet weak var haveAccountButton: UIBarButtonItem!

    var misscount = 0
    var birthdayAAA = ""
    var birthdayInt = 0
    var birthday = ""
    var birthdayOk = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpBirthdayTitleLabel.text = NSLocalizedString("tannjyoubiwosenntaku", comment: "")

        birthdayExplanationLabel.text = NSLocalizedString("tannjyoubisetumei", comment: "")

        // 日付のフォーマット
        let birthdayFormatter = DateFormatter()

        birthdayFormatter.dateStyle = .long

        ageLabel.text = ""
        // (from: datePicker.date))を指定してあげることで、datePickerで指定した日付が表示される
        let birthdayTextFieldPlaceholder = "\(birthdayFormatter.string(from: birthdayPicker.date))"

        birthdayTextField.attributedPlaceholder = NSAttributedString(string: birthdayTextFieldPlaceholder, attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
        // UITextFieldの左側に余白（10px）を入れる
        birthdayTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
        birthdayTextField.leftViewMode = UITextField.ViewMode.always
        birthdayTextField.layer.cornerRadius = 8
        birthdayTextField.layer.borderColor = UIColor.systemBlue.cgColor
        birthdayTextField.layer.borderWidth = 1
        birthdayTextField.layer.masksToBounds = true

        nextButton.setTitle(NSLocalizedString("tugihe", comment: ""), for: .normal)

        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 12.0)]
        haveAccountButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        haveAccountButton.title = NSLocalizedString("akaunntowoomotinokata", comment: "")

        // 150年前のdateを取得
        let date150 = Calendar.current.date(byAdding: .year, value: -150, to: Date())!

        // ピッカー設定
        birthdayPicker.datePickerMode = UIDatePicker.Mode.date
        birthdayPicker.timeZone = NSTimeZone.local
        birthdayPicker.locale = Locale.current
        birthdayPicker.calendar = Calendar.current
        birthdayPicker.maximumDate = Date()
        birthdayPicker.minimumDate = date150
        birthdayPicker.preferredDatePickerStyle = .wheels
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func birthdayPickerValueChanged(_ sender: Any) {
        // 日付のフォーマット
        let birthdayFormatter = DateFormatter()

        birthdayFormatter.dateStyle = .long

        // (from: datePicker.date))を指定してあげることで、datePickerで指定した日付が表示される
        birthdayTextField.text = "\(birthdayFormatter.string(from: birthdayPicker.date))"
        // 選択された誕生日をyyyy/MM/ddに変える
        let ageTextFieldTextyyyy = DateFormatter()
        ageTextFieldTextyyyy.dateFormat = "yyyy"
        let ageyyyy = ageTextFieldTextyyyy.string(from: birthdayPicker.date)
        let ageyyyyInt = Int(ageyyyy)

        // 選択された誕生日をyyyy/MM/ddに変える
        let ageTextFieldTextmm = DateFormatter()
        ageTextFieldTextmm.dateFormat = "MM"
        let agemm = ageTextFieldTextmm.string(from: birthdayPicker.date)
        let agemmInt = Int(agemm)

        // 選択された誕生日をyyyy/MM/ddに変える
        let ageTextFieldTextdd = DateFormatter()
        ageTextFieldTextdd.dateFormat = "dd"
        let agedd = ageTextFieldTextdd.string(from: birthdayPicker.date)
        let ageddInt = Int(agedd)

        let birthdate = DateComponents(year: ageyyyyInt, month: agemmInt, day: ageddInt)
        var age: Int

        // 年齢を算出します
        let calendar = Calendar.current
        let now = calendar.dateComponents([.year, .month, .day], from: Date())
        let ageComponents = calendar.dateComponents([.year], from: birthdate, to: now)
        age = ageComponents.year!
        let ageString = String(age)

        if NSLocalizedString("language", comment: "") == "Arabic" {
            ageLabel.text = NSLocalizedString("sai", comment: "") + ageString
        } else {
            ageLabel.text = ageString + NSLocalizedString("sai", comment: "")
        }

        nextButton.isEnabled = true
        nextButton.setTitleColor(UIColor(named: "White"), for: .normal)
        nextButton.backgroundColor = UIColor(named: "Blue")
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

        // 選択された誕生日をyyyy/MM/ddに変える
        let birthdayTextFieldTextAAA = DateFormatter()
        birthdayTextFieldTextAAA.dateFormat = "yyyyMMdd"
        birthdayAAA = birthdayTextFieldTextAAA.string(from: birthdayPicker.date)
        birthdayInt = Int(birthdayAAA)!

        // 選択された誕生日のyyyyMMddを取得
        let birthdayTextFieldText = DateFormatter()
        birthdayTextFieldText.dateFormat = "yyyyMMdd"
        birthday = "\(birthdayTextFieldText.string(from: birthdayPicker.date))"

        // 13年前のyyyyMMddを取得
        let birthdayTextFieldTextA = Calendar.current.date(byAdding: .year, value: -13, to: Date())!
        let birthdayTextFieldTextOk = DateFormatter()
        birthdayTextFieldTextOk.dateFormat = "yyyyMMdd"
        birthdayOk = "\(birthdayTextFieldTextOk.string(from: birthdayTextFieldTextA))"

        if birthday <= birthdayOk {
            performSegue(withIdentifier: "toSignUpUserNameViewController", sender: nil)
        } else if misscount == 0 || misscount == 1 {
            misscount += 1

            let alertText = NSLocalizedString("jissainotannjyoubi", comment: "")
            let okText = NSLocalizedString("OK", comment: "")

            let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okText, style: UIAlertAction.Style.cancel, handler: nil)

            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)

            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        } else {
            let alertText = NSLocalizedString("akaunntowosakuseidekimasenndesita", comment: "")
            let okText = NSLocalizedString("OK", comment: "")

            let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okText, style: .cancel, handler: { _ in
                self.dismiss(animated: true, completion: nil)
            })

            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)

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
        // Segueの識別子確認
        if segue.identifier == "toSignUpUserNameViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SignUpUserNameViewController

            // 値の設定
            nextView.name1 = name1
            nextView.name2 = name2
            nextView.mailaddress = mailaddress
            nextView.password = password
            nextView.gender = gender
            nextView.birthday = birthdayInt
        }
    }
}
