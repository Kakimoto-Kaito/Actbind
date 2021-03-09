//
//  Covid19WebViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/02/19.
//

import UIKit
import WebKit

final class Covid19WebViewController: UIViewController, WKUIDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    let isoCountryCode = UserDefaults.standard.string(forKey: "isoCountryCode")
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

        let systemButtonConfig = UIImage.SymbolConfiguration(pointSize: 32, weight: .bold, scale: .default)

        backButton.image = UIImage(named: "back")
        safariButton.image = UIImage(systemName: "safari", withConfiguration: systemButtonConfig)
        leftButton.image = UIImage(systemName: "arrow.left", withConfiguration: systemButtonConfig)
        reLoadButton.image = UIImage(systemName: "arrow.clockwise", withConfiguration: systemButtonConfig)
        rightButton.image = UIImage(systemName: "arrow.right", withConfiguration: systemButtonConfig)
        
        // アメリカ
        if isoCountryCode == "US" {
            navigationBarTitle.title = "https://www.usa.gov/coronavirus"
            let myURL = URL(string: "https://www.usa.gov/coronavirus")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // イギリス
        } else if isoCountryCode == "GB" {
            navigationBarTitle.title = "https://www.gov.uk/coronavirus"
            let myURL = URL(string: "https://www.gov.uk/coronavirus")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // イタリア
        } else if isoCountryCode == "IT" {
            navigationBarTitle.title = "http://www.governo.it/it/coronavirus"
            let myURL = URL(string: "http://www.governo.it/it/coronavirus")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // インド
        } else if isoCountryCode == "IN" {
            navigationBarTitle.title = "https://www.india.gov.in/"
            let myURL = URL(string: "https://www.india.gov.in/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // オーストラリア
        } else if isoCountryCode == "AU" {
            navigationBarTitle.title = "https://www.australia.gov.au/"
            let myURL = URL(string: "https://www.australia.gov.au/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // オランダ
        } else if isoCountryCode == "NL" {
            navigationBarTitle.title = "https://www.government.nl/topics/coronavirus-covid-19"
            let myURL = URL(string: "https://www.government.nl/topics/coronavirus-covid-19")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // スイス
        } else if isoCountryCode == "CH" {
            navigationBarTitle.title = "https://www.bag.admin.ch/bag/de/home/krankheiten/ausbrueche-epidemien-pandemien/aktuelle-ausbrueche-epidemien/novel-cov.html"
            let myURL = URL(string: "https://www.bag.admin.ch/bag/de/home/krankheiten/ausbrueche-epidemien-pandemien/aktuelle-ausbrueche-epidemien/novel-cov.html")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // スペイン
        } else if isoCountryCode == "ES" {
            navigationBarTitle.title = "https://coronavirus.es.gov.br/#o-que-e"
            let myURL = URL(string: "https://coronavirus.es.gov.br/#o-que-e")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // ドイツ
        } else if isoCountryCode == "DE" {
            navigationBarTitle.title = "https://www.bundesregierung.de/breg-en"
            let myURL = URL(string: "https://www.bundesregierung.de/breg-en")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // 日本
        } else if isoCountryCode == "JP" {
            navigationBarTitle.title = "https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/0000164708_00001.html"
            let myURL = URL(string: "https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/0000164708_00001.html")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // ノルウェー
        } else if isoCountryCode == "NO" {
            navigationBarTitle.title = "https://www.regjeringen.no/en/topics/koronavirus-covid-19/id2692388/"
            let myURL = URL(string: "https://www.regjeringen.no/en/topics/koronavirus-covid-19/id2692388/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // フランス
        } else if isoCountryCode == "FR" {
            navigationBarTitle.title = "https://www.impots.gouv.fr/portail/"
            let myURL = URL(string: "https://www.impots.gouv.fr/portail/")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
            // 世界保健機関
        } else {
            navigationBarTitle.title = "https://www.who.int/home"
            let myURL = URL(string: "https://www.who.int/home")
            let myRequest = URLRequest(url: myURL!)
            webView.load(myRequest)
        }
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func safariOpenButton(_ sender: Any) {
        // アメリカ
        if isoCountryCode == "US" {
            let myURL = URL(string: "https://www.usa.gov/coronavirus")
            UIApplication.shared.open(myURL!)
            // イギリス
        } else if isoCountryCode == "GB" {
            let myURL = URL(string: "https://www.gov.uk/coronavirus")
            UIApplication.shared.open(myURL!)
            // イタリア
        } else if isoCountryCode == "IT" {
            let myURL = URL(string: "http://www.governo.it/it/coronavirus")
            UIApplication.shared.open(myURL!)
            // インド
        } else if isoCountryCode == "IN" {
            let myURL = URL(string: "https://www.india.gov.in/")
            UIApplication.shared.open(myURL!)
            // オーストラリア
        } else if isoCountryCode == "AU" {
            let myURL = URL(string: "https://www.australia.gov.au/")
            UIApplication.shared.open(myURL!)
            // オランダ
        } else if isoCountryCode == "NL" {
            let myURL = URL(string: "https://www.government.nl/topics/coronavirus-covid-19")
            UIApplication.shared.open(myURL!)
            // スイス
        } else if isoCountryCode == "CH" {
            let myURL = URL(string: "https://www.bag.admin.ch/bag/de/home/krankheiten/ausbrueche-epidemien-pandemien/aktuelle-ausbrueche-epidemien/novel-cov.html")
            UIApplication.shared.open(myURL!)
            // スペイン
        } else if isoCountryCode == "ES" {
            let myURL = URL(string: "https://coronavirus.es.gov.br/#o-que-e")
            UIApplication.shared.open(myURL!)
            // ドイツ
        } else if isoCountryCode == "DE" {
            let myURL = URL(string: "https://www.bundesregierung.de/breg-en")
            UIApplication.shared.open(myURL!)
            // 日本
        } else if isoCountryCode == "JP" {
            let myURL = URL(string: "https://www.mhlw.go.jp/stf/seisakunitsuite/bunya/0000164708_00001.html")
            UIApplication.shared.open(myURL!)
            // ノルウェー
        } else if isoCountryCode == "NO" {
            let myURL = URL(string: "https://www.regjeringen.no/en/topics/koronavirus-covid-19/id2692388/")
            UIApplication.shared.open(myURL!)
            // フランス
        } else if isoCountryCode == "FR" {
            let myURL = URL(string: "https://www.impots.gouv.fr/portail/")
            UIApplication.shared.open(myURL!)
            // 世界保健機関
        } else {
            let myURL = URL(string: "https://www.who.int/home")
            UIApplication.shared.open(myURL!)
        }
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
