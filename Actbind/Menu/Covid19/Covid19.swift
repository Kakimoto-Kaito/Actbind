//
//  Covid19.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/05.
//

import UIKit

final class Covid19 {
    // プロパティー
    var image: UIImage!
    var text: String
    
    // ポストIDはポストのデータを習得するときに必要
    init(text: String, image: UIImage!) {
        self.text = text
        self.image = image
    }
    
    // Sampleデータ
    static let allCovid19 = [
        Covid19(text: NSLocalizedString("tewoarau", comment: ""), image: UIImage(named: "tewoarau")!),
        Covid19(text: NSLocalizedString("kyoriwotoru", comment: ""), image: UIImage(named: "kyoriwotoru")!),
        Covid19(text: NSLocalizedString("taionnwohakaru", comment: ""), image: UIImage(named: "masukuwosuru")!),
        Covid19(text: NSLocalizedString("masukuwosuru", comment: ""), image: UIImage(named: "taionnwohakaru")!),
    ]
}
