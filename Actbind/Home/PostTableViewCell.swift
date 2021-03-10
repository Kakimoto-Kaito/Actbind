//
//  PostTableViewCell.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class PostTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var postColor: UIView!
    @IBOutlet weak var postTextLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var heartButton: UIButton!
    @IBOutlet weak var postDateLabel: UILabel!
    
    var heart = "Off"
    
    // ダミーのAPI
    var post: Post! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        let postcolor = post.postColor
        
        // この中に書いていくことがページが表示された時に画面上に映るもの
        // userNameやposeImageなど、どのようにして表示させていくか
        userProfileImage.image = post.user.profileImage // post(API)の中にあるuserの中にあるprofileImage
        userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2
        
        userNameLabel.text = post.user.userName
        
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
        
        postTextLabel.text = post.postText
        
        postImage.image = post.postImage
        postImage.layer.cornerRadius = 15
        
        if let userDefaults = userDefaults {
            // userDefaultsに保存された値の取得
            let likepostidArray: [Int] = userDefaults.array(forKey: "likepostid") as! [Int]
            
            if likepostidArray.contains(post.id) {
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
        
        // DateFomatterクラスのインスタンス生成
        let dateFormatter = DateFormatter()
         
        dateFormatter.calendar = Calendar.current
        dateFormatter.locale = Locale.current
        dateFormatter.timeZone = NSTimeZone.local
         
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
         
        // データ変換（String→Date）
        let postdate = dateFormatter.date(from: post.postDate)
         
        postDateLabel.text = postdate!.toFuzzy()
    }
    
    @IBAction func heartButtonTouchUpInside(_ sender: Any) {
        if let userDefaults = userDefaults {
            // userDefaultsに保存された値の取得
            var likepostidArray: [Int] = userDefaults.array(forKey: "likepostid") as! [Int]
            
            if heart == "Off" {
                likepostidArray.append(post.id)
                // 配列の保存
                userDefaults.setValue(likepostidArray, forKey: "likepostid")
                
                heartButton.setImage(UIImage(named: "heart"), for: .normal)
                heart = "On"
            } else {
                likepostidArray.removeAll(where: { $0 == post.id })
                // 配列の保存
                userDefaults.setValue(likepostidArray, forKey: "likepostid")
                
                heartButton.setImage(UIImage(named: "heart mono"), for: .normal)
                heart = "Off"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
