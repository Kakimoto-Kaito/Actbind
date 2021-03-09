//
//  Covid19TaisakuTableViewCell.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/05.
//

import UIKit

final class Covid19TaisakuTableViewCell: UITableViewCell {
    @IBOutlet weak var covid19TaisakuImage: UIImageView!
    @IBOutlet weak var covid19TaisakuText: UILabel!
    
    // ダミーのAPI
    var covid19: Covid19! {
        // didSet:表示された時にpostから情報を取ってきてUIを勝手にを更新する
        didSet {
            // 画面が表示された時に発動する
            updateUI()
        }
    }
    
    // private:このファイル内でしか使えないfuncの時
    private func updateUI() {
        // layerMinXMinYCorner    左上
        // layerMaxXMinYCorner    右上
        // layerMinXMaxYCorner    左下
        // layerMaxXMaxYCorner    右下
        // 右上と左上を角丸にする設定
        
        covid19TaisakuImage.image! = covid19.image
        covid19TaisakuImage.layer.cornerRadius = 16
        covid19TaisakuImage.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        covid19TaisakuText.text! = covid19.text
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
