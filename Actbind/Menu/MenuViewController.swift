//
//  MenuViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class MenuViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    var menu = Menu.allMenu
    
    let version = Bundle.main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as! String
    let build = Bundle.main.object(forInfoDictionaryKey: "CFBundleVersion") as! String

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImageBorderView: UIView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var menuTableView: UITableView!

    var dayHour = ""
    private var isLoaded: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // 今の日時
        let nowDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())!
        let hourFormatter = DateFormatter()
        hourFormatter.dateFormat = "HH"
        // 今の時間
        dayHour = "\(hourFormatter.string(from: nowDate))"
        let hourInt = Int(dayHour)!

        if NSLocalizedString("language", comment: "") == "Japanese" {
            if 5 ... 10 ~= hourInt {
                navigationBarTitle.title = NSLocalizedString("ohayou", comment: "")
            } else if 11 ... 18 ~= hourInt {
                navigationBarTitle.title = NSLocalizedString("konnnitiha", comment: "")
            } else {
                navigationBarTitle.title = NSLocalizedString("konnbannha", comment: "")
            }
        } else {
            if 5 ... 11 ~= hourInt {
                navigationBarTitle.title = NSLocalizedString("ohayou", comment: "")
            } else if 12 ... 18 ~= hourInt {
                navigationBarTitle.title = NSLocalizedString("konnnitiha", comment: "")
            } else {
                navigationBarTitle.title = NSLocalizedString("konnbannha", comment: "")
            }
        }
        
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            if appColor == "Original" {
                userProfileImageBorderView.backgroundColor = UIColor(named: "Blue")
            } else {
                userProfileImageBorderView.backgroundColor = UIColor(named: appColor!)
            }
        }
        
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2
        userProfileImageBorderView.layer.cornerRadius = userProfileImageBorderView.layer.bounds.width / 2
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [.font: UIFont.boldSystemFont(ofSize: 24)]

        isLoaded = true
        
        if let userDefaults = userDefaults {
            let profileimage = userDefaults.data(forKey: "profileimage")
            let username = userDefaults.string(forKey: "username")
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
            
            let profileImage = UIImage(data: profileimage!)
            userProfileImage.image = profileImage
            userNameLabel.text = "@" + username!
            nameLabel.text = name1! + name2!
        }
    }

    @IBAction func profileButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toProfileView", sender: self)
    }
    
    @IBAction func covid19ButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toCovid19View", sender: self)
    }

    @IBAction func inotiwomamoruButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toWebViewinotiwomamoru", sender: self)
    }

    @IBAction func activityButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toActivityView", sender: self)
    }

    @IBAction func reportButtonTouchUpInside(_ sender: Any) {
        let alertText = NSLocalizedString("monndaiwohoukoku", comment: "")
        let kinouhoukokuText = NSLocalizedString("kinouhoukoku", comment: "")
        let fidobakkuText = NSLocalizedString("fi-dobakku", comment: "")
        let cancelText = NSLocalizedString("kyannseru", comment: "")

        let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .actionSheet)

        let kinouhoukokuButton = UIAlertAction(title: kinouhoukokuText, style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toWebViewkinouhoukoku", sender: self)
        })
        let fidobakkuButton = UIAlertAction(title: fidobakkuText, style: .default, handler: { _ in
            self.performSegue(withIdentifier: "toWebViewfi-dobakku", sender: self)
        })
        let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

        alertController.view.tintColor = UIColor(named: "BlackWhite")
        alertController.addAction(kinouhoukokuButton)
        alertController.addAction(fidobakkuButton)
        alertController.addAction(cancelButton)

        alertController.popoverPresentationController?.sourceView = view
        let screenSize = UIScreen.main.bounds
        // ここで表示位置を調整
        // xは画面中央、yは画面下部になる様に指定
        alertController.popoverPresentationController?.sourceRect = CGRect(x: screenSize.size.width / 2, y: screenSize.size.height, width: 0, height: 0)

        present(alertController, animated: true, completion: nil)
    }

    @IBAction func decorationButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toDecorationView", sender: self)
    }

    @IBAction func settingButtonTouchUpInside(_ sender: Any) {
        performSegue(withIdentifier: "toSettingView", sender: self)
    }
    
    @IBAction func logoutBottonTouchUpInside(_ sender: Any) {
        if let userDefaults = userDefaults {
            let username = userDefaults.string(forKey: "username")

            if NSLocalizedString("language", comment: "") == "Arabic" {
                let alertText = "?" + "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Chinese, Sim" {
                let alertText = NSLocalizedString("roguautosimasuka", comment: "") + "@" + username! + "吗？"
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Chinese, Tra" {
                let alertText = NSLocalizedString("roguautosimasuka", comment: "") + "@" + username! + "嗎？"
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "German" {
                let alertText = "Möchten Sie sich von " + "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Hindi" {
                let alertText = "क्या आप " + "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Hungarian" {
                let alertText = "Ki szeretne jelentkezni az " + "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Japanese" {
                let alertText = "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else if NSLocalizedString("language", comment: "") == "Thai" {
                let alertText = "คุณต้องการออกจากระบบ " + "@" + username! + NSLocalizedString("roguautosimasuka", comment: "")
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            } else {
                let alertText = NSLocalizedString("roguautosimasuka", comment: "") + "@" + username! + "?"
                let logoutText = NSLocalizedString("roguauto", comment: "")
                let cancelText = NSLocalizedString("kyannseru", comment: "")

                let alertController = UIAlertController(title: alertText, message: nil, preferredStyle: .alert)

                let logoutButton = UIAlertAction(title: logoutText, style: .destructive, handler: { _ in
                    userDefaults.setValue(false, forKeyPath: "loginrecord")
                    self.performSegue(withIdentifier: "rogout", sender: self)
                })
                let cancelButton = UIAlertAction(title: cancelText, style: .cancel, handler: nil)

                alertController.view.tintColor = UIColor(named: "BlackWhite")
                alertController.addAction(logoutButton)
                alertController.addAction(cancelButton)

                present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toWebViewinotiwomamoru" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! WebViewController
     
            // 値の設定
            nextView.weburl = "https://no-heart-no-sns.smaj.or.jp/"
        }
        
        // Segueの識別子確認
        if segue.identifier == "toWebViewkinouhoukoku" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! WebViewController
     
            // 値の設定
            nextView.weburl = NSLocalizedString("kinouhoukokuurl", comment: "")
        }

        // Segueの識別子確認
        if segue.identifier == "toWebViewfi-dobakku" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! WebViewController

            // 値の設定
            nextView.weburl = NSLocalizedString("fi-dobakkuurl", comment: "")
        }
    }
}

extension MenuViewController: MainViewControllerProtocol {
    func onTapScrollToTop() {
        // 一番上に移動
        if isLoaded {
            menuTableView.setContentOffset(CGPoint.zero, animated: true)
        }
    }
}

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension MenuViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "menuCell", for: indexPath) as! MenuTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cell.menu = menu[indexPath.row]
        // ここまで
        return cell
    }
}
