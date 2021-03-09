//
//  User.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/29.
//

import UIKit

final class User {
    var id: Int
    var userName: String
    var mailAddress: String
    var password: String
    var gender: Int
    var birthDay: Int
    var accountName: String
    var profileImage: UIImage!
    var userSelfIntroduction: String
    // var interestId = [String]()
    
    init(id: Int, userName: String, mailAddress: String, password: String, gender: Int, birthDay: Int, accountName: String, profileImage: UIImage, userSelfIntroduction: String) {
        self.id = id
        self.userName = userName
        self.mailAddress = mailAddress
        self.password = password
        self.gender = gender
        self.birthDay = birthDay
        self.accountName = accountName
        self.profileImage = profileImage
        self.userSelfIntroduction = userSelfIntroduction
    }
    
    // MARK: - Private
    
    class func allUsers() -> [User] {
        return [
            User(id: 1, userName: "山田花子", mailAddress: "steave@info.com", password: "hanako", gender: 2, birthDay: 2000 / 01 / 03, accountName: "hanako_1", profileImage: UIImage(named: "defaultProfileImage")!, userSelfIntroduction: "私は学生です"),
            User(id: 2, userName: "柿本海斗", mailAddress: "mark@info.com", password: "tarou", gender: 1, birthDay: 2001 / 07 / 30, accountName: "tarou_2", profileImage: UIImage(named: "111")!, userSelfIntroduction: "僕は兵庫県に住んでいます"),
        ]
    }
}
