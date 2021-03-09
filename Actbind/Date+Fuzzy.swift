//
//  NSLocalizedString+Date.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/03.
//

import Foundation

let minute = 60
let hour = minute * 60
let day = hour * 24
let week = day * 7
let year = day * 365

extension Date {
    func toFuzzy() -> String {
        // 現在時刻を取得する
        let now = Date()

        // カレンダーを作成する
        let cal = Calendar.current

        let components = cal.dateComponents([.second, .minute, .hour, .day, .year], from: self, to: now)

        // 目的などに応じて適切に書き換える必要がある
        let diffSec = components.second! + components.minute! * minute + components.hour! * hour + components.day! * day + components.year! * year

        var result = String()

        if diffSec < minute {
            result = NSLocalizedString("suubyoumae", comment: "")
        } else if diffSec < hour {
            result = String(format: NSLocalizedString("funnmae", comment: ""), "\(diffSec / minute)")
            
        } else if diffSec < day {
            result = String(format: NSLocalizedString("jikannmae", comment: ""), "\(diffSec / hour)")
            
        } else if diffSec < week {
            result = String(format: NSLocalizedString("nitimae", comment: ""), "\(diffSec / day)")
            
        } else {
            let dateFormatter = DateFormatter()
            
            if components.year! > 0 {
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMMMd", options: 0, locale: Locale.current)!
                result = dateFormatter.string(from: self)
            } else {
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMd", options: 0, locale: Locale.current)!
                result = dateFormatter.string(from: self)
            }
        }

        return result
    }
}
