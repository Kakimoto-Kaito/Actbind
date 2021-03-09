//
//  PostViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit

final class PostViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    var postcolor = ""
    var postimage: UIImage?

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var postButton: UIBarButtonItem!
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var postColor: UIView!
    @IBOutlet weak var postText: UITextView!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var postDate: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("toukouwosakusei", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            let name1 = userDefaults.string(forKey: "name1")
            let name2 = userDefaults.string(forKey: "name2")
            let profileimage = userDefaults.data(forKey: "profileimage")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                postButton.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                postButton.tintColor = UIColor(named: appColor!)
            }

            let profileImage = UIImage(data: profileimage!)
            userProfileImage.image = profileImage
            userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2

            nameLabel.text = name1! + name2!
        }
        
        backButton.image = UIImage(named: "back")
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        postButton.setTitleTextAttributes(attributes, for: .normal)
        postButton.title = NSLocalizedString("syea", comment: "")
        
        if postcolor == "red" {
            postColor.backgroundColor = UIColor(named: "Red")
        } else if postcolor == "orange" {
            postColor.backgroundColor = UIColor(named: "Orange")
        } else if postcolor == "yellow" {
            postColor.backgroundColor = UIColor(named: "Yellow")
        } else if postcolor == "green" {
            postColor.backgroundColor = UIColor(named: "Green")
        } else if postcolor == "blue" {
            postColor.backgroundColor = UIColor(named: "Blue")
        } else {
            postColor.backgroundColor = UIColor(named: "Purple")
        }
        postColor.layer.cornerRadius = postColor.layer.bounds.height / 2
        
        postText.textContainerInset = UIEdgeInsets(top: 10.0, left: 10.0, bottom: 10.0, right: 10.0)
        postText.sizeToFit()
        postText.layer.borderColor = UIColor.lightGray.cgColor
        postText.layer.borderWidth = 1.0
        
        postImage.image = postimage
        postImage.layer.cornerRadius = 16
        
        postDate.text = NSLocalizedString("jikann", comment: "")
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    struct Post: Codable {
        let postId: Int
        let userId: Int
        let postColor: String
        let postImage: Data
        let postText: String
        let postDate: Date
    }
    
    @IBAction func postButtonAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
