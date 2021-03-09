//
//  ProfileTableViewCell.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit

final class ProfileTableViewCell: UITableViewCell {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var userProfileImage: UIImageView!
    @IBOutlet weak var userProfileImageBorderView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var bioLabel: UILabel!
    @IBOutlet weak var bioLabelTop: NSLayoutConstraint!
    @IBOutlet weak var profileEditButton: UIButton!
    @IBOutlet weak var profileEditButtonRight: NSLayoutConstraint!
    @IBOutlet weak var profileEditButtonLeft: NSLayoutConstraint!
    
    // ダミーのAPI
    var profile: Profile! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
            if appColor == "Original" {
                userProfileImageBorderView.backgroundColor = UIColor(named: "Blue")
                profileEditButton.backgroundColor = UIColor(named: "Blue")
            } else {
                userProfileImageBorderView.backgroundColor = UIColor(named: appColor!)
                profileEditButton.backgroundColor = UIColor(named: appColor!)
            }
            
            let profileimage = userDefaults.data(forKey: profile.text1)
            let name1 = userDefaults.string(forKey: profile.text2)
            let name2 = userDefaults.string(forKey: profile.text3)
            let bio = userDefaults.string(forKey: profile.text4)
            let profileImage = UIImage(data: profileimage!)
            userProfileImage.image = profileImage
            userProfileImage.layer.cornerRadius = userProfileImage.layer.bounds.width / 2
            userProfileImageBorderView.layer.cornerRadius = userProfileImageBorderView.layer.bounds.width / 2
            nameLabel.text = name1! + name2!
            bioLabel.text = bio
        }
        
        profileEditButton.setTitle(NSLocalizedString("purofi-ruwohennsyuu", comment: ""), for: .normal)
        
        if bioLabel.text == "" {
            bioLabelTop.constant = 0
        } else {
            bioLabelTop.constant = 8
        }
    }
    
    @IBAction func profileEditButtonTouchDown(_ sender: Any) {
        profileEditButton.alpha = 0.5
        profileEditButtonRight.constant = 25
        profileEditButtonLeft.constant = 25
    }
    
    @IBAction func profileEditButtonTouchDragOutside(_ sender: Any) {
        profileEditButton.alpha = 1.0
        profileEditButtonRight.constant = 20
        profileEditButtonLeft.constant = 20
    }
    
    @IBAction func profileEditButtonTouchUpInside(_ sender: Any) {
        profileEditButton.alpha = 1.0
        profileEditButtonRight.constant = 20
        profileEditButtonLeft.constant = 20
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
