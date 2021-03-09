//
//  Post.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/29.
//

import UIKit

final class Post {
    // プロパティー
    var id: Int
    var user: User
    var postColor: String
    var postImage: UIImage! // 写真がない可能性もある
    var postText: String
    var postDate: String
    
    // ポストIDはポストのデータを習得するときに必要
    init(postId: Int, author: User, postColor: String, postText: String, postImage: UIImage!, postDate: String)
    {
        id = postId
        user = author
        self.postColor = postColor
        self.postText = postText
        self.postImage = postImage // なしでもOK
        self.postDate = postDate
    }
    
    // Sampleデータ
    static let allPosts = [
        Post(postId: 1, author: User.allUsers()[1], postColor: "orange", postText: "綺麗に紅葉してました！🍁", postImage: UIImage(named: "momiji")!, postDate: "2021-03-03 13:57:00"),
        Post(postId: 1, author: User.allUsers()[1], postColor: "blue", postText: "写真投稿のSNSを作りたかったのに、自分の技術がなかったために文字投稿のSNSに切り替えました", postImage: UIImage(named: "image5")!, postDate: "2021-02-25 13:57:00"),
        Post(postId: 1, author: User.allUsers()[1], postColor: "red", postText: "写真投稿のSNSを作りたかったのに、自分の技術がなかったために文字投稿のSNSに切り替えました", postImage: UIImage(named: "image1")!, postDate: "2021-02-24 13:57:00"),
        Post(postId: 1, author: User.allUsers()[1], postColor: "red", postText: "写真投稿のSNSを作りたかったのに、自分の技術がなかったために文字投稿のSNSに切り替えました", postImage: UIImage(named: "image1")!, postDate: "2021-02-11 13:57:00"),
        Post(postId: 2, author: User.allUsers()[0], postColor: "blue", postText: "このSNSの特徴は投稿ごとにイメージカラーを決めることができます", postImage: UIImage(named: "image5")!, postDate: "2020-10-13 12:34:56"),
        Post(postId: 3, author: User.allUsers()[1], postColor: "green", postText: "これによってテキストベースSNSによくある捉え方の違いによる揉め事を少しでも抑えることができます", postImage: UIImage(named: "image4")!, postDate: "2020-10-12 12:34:56"),
        Post(postId: 4, author: User.allUsers()[0], postColor: "yellow", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image3")!, postDate: "2020-10-11 12:34:56"),
        Post(postId: 5, author: User.allUsers()[0], postColor: "purple", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image6")!, postDate: "2020-10-10 12:34:56"),
        Post(postId: 6, author: User.allUsers()[0], postColor: "orange", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image2")!, postDate: "2020-10-09 12:34:56"),
        Post(postId: 7, author: User.allUsers()[0], postColor: "orange", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image2")!, postDate: "2020-10-08 12:34:56"),
        Post(postId: 8, author: User.allUsers()[0], postColor: "orange", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image2")!, postDate: "2020-10-07 12:34:56"),
        Post(postId: 9, author: User.allUsers()[0], postColor: "orange", postText: "久しぶりに髪を切れてよかった", postImage: UIImage(named: "image2")!, postDate: "2020-09-06 12:34:56"),
        Post(postId: 10, author: User.allUsers()[0], postColor: "orange", postText: "", postImage: UIImage(named: "image2")!, postDate: "2019-10-05 12:34:56"),
    ]
}
