//
//  HomeViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import CoreLocation
import UIKit

final class HomeViewController: UIViewController, CLLocationManagerDelegate {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var post = Post.allPosts
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var logoButton: UIButton!

    private var isLoaded: Bool = false

    var locationManager: CLLocationManager!
    // 測位精度
    let locationAccuracy: [Double] = [
        kCLLocationAccuracyBestForNavigation,
        kCLLocationAccuracyBest,
        kCLLocationAccuracyNearestTenMeters,
        kCLLocationAccuracyHundredMeters,
        kCLLocationAccuracyKilometer,
        kCLLocationAccuracyThreeKilometers
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // locationManager初期化
        locationManager = CLLocationManager()

        // ユーザーの使用許可を確認
        locationManager.requestWhenInUseAuthorization()
                
        // 使用許可に対するステータス
        let status = CLLocationManager.authorizationStatus()
         
        if status == .authorizedWhenInUse {
            // delegateを設定
            locationManager.delegate = self
         
            // 測位精度の設定
            locationManager.desiredAccuracy = locationAccuracy[1]
                    
            // アップデートする距離半径(m)
            locationManager.distanceFilter = 10000
         
            // 位置情報の取得を開始
            locationManager.startUpdatingLocation()
        }
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24)]

        isLoaded = true
    }

    @IBAction func logoButtonTouchUpInside(_ sender: Any) {
        // view自体のトップ
        tableView.setContentOffset(CGPoint.zero, animated: true)
        // セルのトップ
        // tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: .top, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager,
                         didUpdateLocations locations: [CLLocation])
    {
        // 最初のデータ
        let location = locations.first
     
        // 緯度
        let latitude = location?.coordinate.latitude
        // 経度
        let longitude = location?.coordinate.longitude
        
        UserDefaults.standard.set(latitude, forKey: "latitude")
        UserDefaults.standard.set(longitude, forKey: "longitude")
     
        // 位置情報の取得を停止
        locationManager.stopUpdatingLocation()
    }
    
    @IBAction func postMenuButtonTouchUpInside(_ sender: Any) {
        let monndaitoukouhoukokuText = NSLocalizedString("monndainoarutoukouwohoukoku", comment: "")
        let cancelText = NSLocalizedString("kyannseru", comment: "")

        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let monndaitoukouhoukokuButton = UIAlertAction(title: monndaitoukouhoukokuText, style: .destructive, handler: { _ in
            self.performSegue(withIdentifier: "toWebViewmonndainoarutoukouwohoukoku", sender: nil)
        })
        let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)
        
        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(monndaitoukouhoukokuButton)
        alertController.addAction(cancelButton)

        alertController.popoverPresentationController?.sourceView = view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width / 2, y: screenSize.size.height, width: 0, height: 0)

        present(alertController, animated: true, completion: nil)
    }
    
    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toWebViewmonndainoarutoukouwohoukoku" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! WebViewController
     
            // 値の設定
            nextView.weburl = NSLocalizedString("monndainoarutoukouwohoukokuurl", comment: "")
        }
    }
}

extension HomeViewController: MainViewControllerProtocol {
    func onTapScrollToTop() {
        // 一番上に移動
        if isLoaded {
            tableView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension HomeViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // postの中を自動的に数える　　　postの分だけcellを作る
        return post.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellImage = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as! PostTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cellImage.post = post[indexPath.row]
        // ここまで
        return cellImage
    }
}
