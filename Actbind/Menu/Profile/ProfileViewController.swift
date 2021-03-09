//
//  ProfileViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit

final class ProfileViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var profile = Profile.allProfile
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let username = userDefaults.string(forKey: "username")
            navigationBarTitle.title = "@" + username!

            if appColor == "Original" {
                postButton.tintColor = UIColor(named: "BlackWhite")
                backButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                postButton.tintColor = UIColor(named: appColor!)
                backButton.tintColor = UIColor(named: appColor!)
            }
        }
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        tableView.reloadData()
    }

    @IBAction func postButtonAction(_ sender: Any) {
        UserDefaults.standard.set("Off", forKey: "flashonoff")

        performSegue(withIdentifier: "toCameraView", sender: nil)
    }
    
    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backButtonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}

// extensionは何かを追加していく ViewControllerというクラスの中にUITableViewDataSource機能を追加していく
extension ProfileViewController: UITableViewDataSource {
    // tableviewの中に何個のセクションを追加するか
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    // 一つのtableviewの中に何個のセルが必要か
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profile.count
    }
    
    // tavleviewの中で使われているセルの特定
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell", for: indexPath) as! ProfileTableViewCell
        
        // ここからの内容がセルに反映される
        // 順番にcellの方のpostに送っていく
        cell.profile = profile[indexPath.row]
        // ここまで
        return cell
    }
}
