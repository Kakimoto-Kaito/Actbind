//
//  ChangeGenderViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/02.
//

import UIKit

final class ChangeGenderViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var genderSegmentedControl: UISegmentedControl!
    @IBOutlet weak var confirmationButton: UIButton!
    @IBOutlet weak var confirmationButtonRight: NSLayoutConstraint!
    @IBOutlet weak var confirmationButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var backButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        navigationBarTitle.title = NSLocalizedString("seibetu", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let gender = userDefaults.integer(forKey: "gender")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                confirmationButton.backgroundColor = UIColor(named: appColor!)
            }

            if gender == 1 {
                genderLabel.text = NSLocalizedString("dannsei", comment: "")
                genderSegmentedControl.selectedSegmentIndex = 0
            } else if gender == 2 {
                genderLabel.text = NSLocalizedString("jyosei", comment: "")
                genderSegmentedControl.selectedSegmentIndex = 1
            } else {
                genderLabel.text = NSLocalizedString("sonota", comment: "")
                genderSegmentedControl.selectedSegmentIndex = 2
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        genderSegmentedControl.setTitle(NSLocalizedString("dannsei", comment: ""), forSegmentAt: 0)
        genderSegmentedControl.setTitle(NSLocalizedString("jyosei", comment: ""), forSegmentAt: 1)
        genderSegmentedControl.setTitle(NSLocalizedString("sonota", comment: ""), forSegmentAt: 2)

        confirmationButton.setTitle(NSLocalizedString("kakuninn", comment: ""), for: .normal)
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func genderSegmentedControlValueChanged(_ sender: Any) {
        // セグメントが変更されたときの処理
        // 選択されているセグメントのインデックス
        let selectedIndex = genderSegmentedControl.selectedSegmentIndex
        // 選択されたインデックスの文字列を取得してラベルに設定
        genderLabel.text = genderSegmentedControl.titleForSegment(at: selectedIndex)

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: "Blue")
            } else {
                confirmationButton.setTitleColor(UIColor(named: "White"), for: .normal)
                confirmationButton.backgroundColor = UIColor(named: appColor!)
            }
        }
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

        if let userDefaults = userDefaults {
            let gender = userDefaults.integer(forKey: "gender")

            // セグメントコントロールが何番目に止まっているかでスイッチ
            switch genderSegmentedControl.selectedSegmentIndex {
            case 0:
                if gender == 1 {
                    navigationController?.popViewController(animated: true)
                } else {
                    performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
                }
            case 1:
                if gender == 2 {
                    navigationController?.popViewController(animated: true)
                } else {
                    performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
                }
            case 2:
                if gender == 9 {
                    navigationController?.popViewController(animated: true)
                } else {
                    performSegue(withIdentifier: "toSaveNewInformationViewController", sender: nil)
                }
            default:
                print("error")
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
        // Segueの識別子確認
        if segue.identifier == "toSaveNewInformationViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! SaveNewInformationViewController
     
            // 値の設定
            // セグメントコントロールが何番目に止まっているかでスイッチ
            switch genderSegmentedControl.selectedSegmentIndex {
            case 0:
                nextView.gender = 1
                nextView.genderString = genderLabel.text!
            case 1:
                nextView.gender = 2
                nextView.genderString = genderLabel.text!
            case 2:
                nextView.gender = 9
                nextView.genderString = genderLabel.text!
            default:
                print("error")
            }
        }
    }
}
