//
//  Covid19ViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import CoreLocation
import UIKit

final class Covid19ViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    var covid19 = Covid19.allCovid19

    let latitude = UserDefaults.standard.string(forKey: "latitude")
    let longitude = UserDefaults.standard.string(forKey: "longitude")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var covid19TableView: UITableView!
    @IBOutlet weak var covid19OmoiLabel: UILabel!
    @IBOutlet weak var covid19SiteButton: UIButton!
    @IBOutlet weak var covid19SiteButtonRight: NSLayoutConstraint!
    @IBOutlet weak var covid19SiteButtonLeft: NSLayoutConstraint!
    @IBOutlet weak var covid19TaisakuLabel: UILabel!
    @IBOutlet weak var covid19TaisakuLabelSub: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("koronauirusunituite", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                covid19SiteButton.backgroundColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                covid19SiteButton.backgroundColor = UIColor(named: appColor!)
            }
        }
        
        backButton.image = UIImage(named: "back")
        
        covid19OmoiLabel.text = NSLocalizedString("coronauirusunorikoeyou", comment: "")
        covid19SiteButton.setTitle(NSLocalizedString("kuwasiijyouhou", comment: ""), for: .normal)
        
        covid19TaisakuLabel.text = NSLocalizedString("kannsenntaisaku", comment: "")
        covid19TaisakuLabelSub.text = NSLocalizedString("mamorou", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func covid19SiteButtonTouchDown(_ sender: Any) {
        covid19SiteButton.alpha = 0.5
        covid19SiteButtonRight.constant = 25
        covid19SiteButtonLeft.constant = 25
    }
    
    @IBAction func covid19SiteButtonTouchDragOutside(_ sender: Any) {
        covid19SiteButton.alpha = 1.0
        covid19SiteButtonRight.constant = 20
        covid19SiteButtonLeft.constant = 20
    }
    
    @IBAction func covid19SiteButtonTouchUpInside(_ sender: Any) {
        covid19SiteButton.alpha = 1.0
        covid19SiteButtonRight.constant = 20
        covid19SiteButtonLeft.constant = 20
        
        let latitudeInt = Double(latitude!)!
        let longitudeInt = Double(longitude!)!
        
        let location = CLLocation(latitude: latitudeInt, longitude: longitudeInt)
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let placemark = placemarks?.first, error == nil {
                print("name: \(placemark.name ?? "")")
                let isoCountryCode = placemark.isoCountryCode
                UserDefaults.standard.set(isoCountryCode, forKey: "isoCountryCode")
            }
        }
        
        performSegue(withIdentifier: "toCovid19WebViewController", sender: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension Covid19ViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return covid19.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Covid19TaisakuCell", for: indexPath) as! Covid19TaisakuTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cell.covid19 = covid19[indexPath.row]
        // ここまで
        return cell
    }
}
