//
//  AboutActbindWebViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/16.
//

import UIKit
import WebKit

final class AboutActbindWebViewController: UIViewController, UIScrollViewDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var contents = ""
    var weburl = ""
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var safariButton: UIBarButtonItem!
    @IBOutlet weak var leftButton: UIBarButtonItem!
    @IBOutlet weak var reLoadButton: UIBarButtonItem!
    @IBOutlet weak var rightButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.scrollView.delegate = self
        
        navigationBarTitle.title = NSLocalizedString(contents, comment: "")
        
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                safariButton.tintColor = UIColor(named: "BlackWhite")
                leftButton.tintColor = UIColor(named: "BlackWhite")
                reLoadButton.tintColor = UIColor(named: "BlackWhite")
                rightButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                safariButton.tintColor = UIColor(named: appColor!)
                leftButton.tintColor = UIColor(named: appColor!)
                reLoadButton.tintColor = UIColor(named: appColor!)
                rightButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        let myURL = URL(string: weburl)
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
        
        let systemButtonConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .default)
        
        backButton.image = UIImage(named: "back")
        
        safariButton.image = UIImage(systemName: "safari", withConfiguration: systemButtonConfig)
        leftButton.image = UIImage(systemName: "arrow.left", withConfiguration: systemButtonConfig)
        reLoadButton.image = UIImage(systemName: "arrow.clockwise", withConfiguration: systemButtonConfig)
        rightButton.image = UIImage(systemName: "arrow.right", withConfiguration: systemButtonConfig)
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    func scrollViewWillBeginZooming(_ scrollView: UIScrollView, with view: UIView?) {
        scrollView.pinchGestureRecognizer?.isEnabled = false
    }
    
    @IBAction func safariOpenButton(_ sender: Any) {
        let myURL = URL(string: weburl)
        UIApplication.shared.open(myURL!)
    }
    
    @IBAction func leftButtonAction(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func reLoadButtonAction(_ sender: Any) {
        webView.reload()
    }
    
    @IBAction func rightButtonAction(_ sender: Any) {
        webView.goForward()
    }
    
    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
