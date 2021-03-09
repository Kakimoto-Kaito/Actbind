//
//  SignUpNgViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/17.
//

import UIKit

final class SignUpNoViewController: UIViewController {
    @IBOutlet weak var signUpNgTitleLabel: UILabel!
    @IBOutlet weak var returnButton: UIButton!
    @IBOutlet weak var returnButtonRight: NSLayoutConstraint!
    @IBOutlet weak var returnButtonLeft: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        signUpNgTitleLabel.text = NSLocalizedString("akaunntowosakuseidekimasenndesita", comment: "")

        returnButton.setTitle(NSLocalizedString("modoru", comment: ""), for: .normal)

        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.error)
    }

    @IBAction func returnButtonTouchDown(_ sender: Any) {
        returnButton.alpha = 0.5
        returnButtonRight.constant = 25
        returnButtonLeft.constant = 25
    }

    @IBAction func returnButtonTouchDragOutside(_ sender: Any) {
        returnButton.alpha = 1.0
        returnButtonRight.constant = 20
        returnButtonLeft.constant = 20
    }

    @IBAction func returnButtonTouchUpInside(_ sender: Any) {
        returnButton.alpha = 1.0
        returnButtonRight.constant = 20
        returnButtonLeft.constant = 20

        dismiss(animated: true, completion: nil)
    }
}
