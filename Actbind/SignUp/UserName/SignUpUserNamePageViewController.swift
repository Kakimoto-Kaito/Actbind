//
//  SignUpAccountNamePageViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/01.
//

import UIKit

final class SignUpUserNamePageViewController: UIViewController {
    @IBOutlet weak var page1: UIView!
    @IBOutlet weak var page2: UIView!
    @IBOutlet weak var page3: UIView!
    @IBOutlet weak var page4: UIView!
    @IBOutlet weak var page5: UIView!
    @IBOutlet weak var page6: UIView!
    @IBOutlet weak var page7: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()

        page1.layer.cornerRadius = page1.layer.bounds.width / 2
        page2.layer.cornerRadius = page2.layer.bounds.width / 2
        page3.layer.cornerRadius = page3.layer.bounds.width / 2
        page4.layer.cornerRadius = page4.layer.bounds.width / 2
        page5.layer.cornerRadius = page5.layer.bounds.width / 2
        page6.layer.cornerRadius = page6.layer.bounds.width / 2
        page7.layer.cornerRadius = page7.layer.bounds.width / 2
    }
}
