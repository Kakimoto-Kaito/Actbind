//
//  BioEditViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import AudioToolbox
import UIKit

final class BioEditViewController: UIViewController, UITextViewDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var bioTitleLabel: UILabel!
    @IBOutlet weak var bioTextView: UITextView!
    @IBOutlet weak var textCountLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var saveButtonRight: NSLayoutConstraint!
    @IBOutlet weak var saveButtonLeft: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        bioTextView.delegate = self
        navigationBarTitle.title = NSLocalizedString("jikosyoukaiwohennsyuu", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let bio = userDefaults.string(forKey: "bio")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
            }

            if bio == "" {
                bioTextView.text = ""
            } else {
                bioTextView.text = bio
            }

            let bioCount = bio
            textCountLabel.text = String(bioCount!.count) + "/100"
        }

        backButton.image = UIImage(named: "back")

        bioTitleLabel.text = NSLocalizedString("jikosyoukai", comment: "")

        bioTextView.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        bioTextView.sizeToFit()
        bioTextView.layer.borderColor = UIColor.lightGray.cgColor
        bioTextView.layer.borderWidth = 1.0

        saveButton.setTitle(NSLocalizedString("hozonn", comment: ""), for: .normal)
    }

    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }

    func textViewDidChange(_ textView: UITextView) {
        let bioText = bioTextView.text
        let bioCount = bioTextView.text.count
        textCountLabel.text = String(bioCount) + "/100"

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let bio = userDefaults.string(forKey: "bio")

            if bioCount < 100 {
                textCountLabel.textColor = UIColor(named: "BlackWhite")
                if bioCount == 90 {
                    let generator = UINotificationFeedbackGenerator()
                    generator.notificationOccurred(.warning)
                }
                if bio == bioText {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                } else {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if appColor == "Original" {
                        saveButton.backgroundColor = UIColor(named: "Blue")
                    } else {
                        saveButton.backgroundColor = UIColor(named: appColor!)
                    }
                }
            } else if bioCount == 100 {
                textCountLabel.textColor = UIColor.label
                AudioServicesPlaySystemSound(1003)
                AudioServicesDisposeSystemSoundID(1003)

                if bio == bioText {
                    saveButton.isEnabled = false
                    saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                    saveButton.backgroundColor = UIColor(named: "EnabledButton")
                } else {
                    saveButton.isEnabled = true
                    saveButton.setTitleColor(UIColor(named: "White"), for: .normal)
                    if appColor == "Original" {
                        saveButton.backgroundColor = UIColor(named: "Blue")
                    } else {
                        saveButton.backgroundColor = UIColor(named: appColor!)
                    }
                }
            } else {
                textCountLabel.textColor = UIColor.systemPink
                saveButton.isEnabled = false
                saveButton.setTitleColor(UIColor(named: "EnabledButtonText"), for: .normal)
                saveButton.backgroundColor = UIColor(named: "EnabledButton")
            }
        }
    }

    @IBAction func saveButtonTouchDown(_ sender: Any) {
        saveButton.alpha = 0.5
        saveButtonRight.constant = 25
        saveButtonLeft.constant = 25
    }

    @IBAction func saveButtonTouchDragOutside(_ sender: Any) {
        saveButton.alpha = 1.0
        saveButtonRight.constant = 20
        saveButtonLeft.constant = 20
    }

    // キーボード以外をタップでキーボードが閉じる
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }

    @IBAction func saveButtonTouchUpInside(_ sender: Any) {
        saveButton.alpha = 1.0
        saveButtonRight.constant = 20
        saveButtonLeft.constant = 20

        // データ登録・更新
        if let userDefaults = userDefaults {
            userDefaults.setValue(bioTextView.text, forKeyPath: "bio")
        }

        navigationController?.popViewController(animated: true)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
