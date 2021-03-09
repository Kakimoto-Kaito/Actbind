//
//  ChangeBirthdayViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import AudioToolbox
import UIKit

final class ChangeBirthdayViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var birthdayPicker: UIDatePicker!

    var birthdayAAA = ""
    var birthdayInt = 0
    var nowday = ""
    var birthdayOk = ""
    var birthdayString = ""
    
    class DateUtils {
        class func dateFromString(string: String, format: String) -> Date {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            return formatter.date(from: string)!
        }

        class func stringFromDate(date: Date, format: String) -> String {
            let formatter = DateFormatter()
            formatter.calendar = Calendar(identifier: .gregorian)
            formatter.dateFormat = format
            // formatter.dateStyle = .long
            return formatter.string(from: date)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("tannjyoubi", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let birthday = userDefaults.string(forKey: "birthday")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                confirmationButton.backgroundColor = UIColor(named: appColor!)
            }

            backButton.image = UIImage(named: "back")

            // Dateに変換
            let birthdayDate = DateUtils.dateFromString(string: birthday!, format: "yyyyMMdd")
            // 日付のフォーマット
            let birthdayFormatter = DateFormatter()
            birthdayFormatter.dateStyle = .long
            birthdayTextField.text = "\(birthdayFormatter.string(from: birthdayDate))"

            birthdayTextField.attributedPlaceholder = NSAttributedString(string: NSLocalizedString("tannjyoubi", comment: ""), attributes: [NSAttributedString.Key.foregroundColor: UIColor(named: "TextFieldText")!])
            // UITextFieldの左側に余白（10px）を入れる
            birthdayTextField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 0))
            birthdayTextField.leftViewMode = UITextField.ViewMode.always
            birthdayTextField.layer.cornerRadius = 8
            birthdayTextField.layer.borderColor = UIColor.systemBlue.cgColor
            birthdayTextField.layer.borderWidth = 1
            birthdayTextField.layer.masksToBounds = true

            confirmationButton.setTitle(NSLocalizedString("kakuninn", comment: ""), for: .normal)

            // 150年前のdateを取得
            let date150 = Calendar.current.date(byAdding: .year, value: -150, to: Date())!
            
            // ピッカー設定
            birthdayPicker.datePickerMode = UIDatePicker.Mode.date
            birthdayPicker.timeZone = NSTimeZone.local
            birthdayPicker.locale = Locale.current
            birthdayPicker.calendar = Calendar.current
            birthdayPicker.date = birthdayDate
            birthdayPicker.maximumDate = Date()
            birthdayPicker.minimumDate = date150
            birthdayPicker.preferredDatePickerStyle = .wheels
        }
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

    @IBAction func birthdayPickerValueChanged(_ sender: Any) {
        // 日付のフォーマット
        let birthdayFormatter = DateFormatter()

        birthdayFormatter.dateStyle = .long

        // (from: datePicker.date))を指定してあげることで、datePickerで指定した日付が表示される
        birthdayTextField.text = "\(birthdayFormatter.string(from: birthdayPicker.date))"
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

        // 選択された誕生日をyyyy/MM/ddに変える
        let birthdayTextFieldTextAAA = DateFormatter()
        birthdayTextFieldTextAAA.dateFormat = "yyyyMMdd"
        birthdayAAA = birthdayTextFieldTextAAA.string(from: birthdayPicker.date)
        birthdayInt = Int(birthdayAAA)!

        // 選択された誕生日のyyyyMMddを取得
        let birthdayTextFieldText = DateFormatter()
        birthdayTextFieldText.dateFormat = "yyyyMMdd"
        nowday = "\(birthdayTextFieldText.string(from: birthdayPicker.date))"

        // 13年前のyyyyMMddを取得
        let birthdayTextFieldTextA = Calendar.current.date(byAdding: .year, value: -13, to: Date())!
        let birthdayTextFieldTextOk = DateFormatter()
        birthdayTextFieldTextOk.dateFormat = "yyyyMMdd"
        birthdayOk = "\(birthdayTextFieldTextOk.string(from: birthdayTextFieldTextA))"

        if let userDefaults = userDefaults {
            let birthday = userDefaults.string(forKey: "birthday")

            // Dateに変換
            let birthdayDate = DateUtils.dateFromString(string: birthday!, format: "yyyyMMdd")

            let birthdayTextFieldTextOk = DateFormatter()
            birthdayTextFieldTextOk.dateStyle = .long
            birthdayString = "\(birthdayTextFieldTextOk.string(from: birthdayDate))"
        }
        if nowday <= birthdayOk {
            if birthdayString == birthdayTextField.text {
                navigationController?.popViewController(animated: true)
            } else {
                performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
            }
        } else {
            let alertText = NSLocalizedString("tannjyoubiwohennkoudekinai", comment: "")
            let message = ""
            let okText = NSLocalizedString("OK", comment: "")

            let alertController = UIAlertController(title: alertText, message: message, preferredStyle: .alert)

            let okButton = UIAlertAction(title: okText, style: .cancel, handler: { _ in
                self.navigationController?.popViewController(animated: true)
            })

            alertController.addAction(okButton)

            present(alertController, animated: true, completion: nil)
            
            AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
        }
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toSaveNewInformationViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SaveNewInformationViewController
     
            // 値の設定
            nextView.birthday = birthdayInt
            nextView.birthdayString = birthdayTextField.text!
        }
    }
}
