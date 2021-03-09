//
//  RebootToLoginViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/07.
//

import UIKit

final class RebootToLoginViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.performSegue(withIdentifier: "rebootToLogin", sender: nil)
        }
    }
}
