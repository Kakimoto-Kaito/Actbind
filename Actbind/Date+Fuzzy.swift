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
            if (diffSec / minute) == 1 {
                result = String(format: NSLocalizedString("funnmae", comment: ""), "\(diffSec / minute)")
            } else {
                result = String(format: NSLocalizedString("fukusuufunnmae", comment: ""), "\(diffSec / minute)")
            }
        } else if diffSec < day {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd", options: 0, locale: Locale.current)!
            let postDateMonth = dateFormatter.string(from: self)
            let nowDateMonth = dateFormatter.string(from: Date())
            
            if postDateMonth == nowDateMonth {
                if (diffSec / hour) == 1 {
                    result = String(format: NSLocalizedString("jikannmae", comment: ""), "\(diffSec / hour)")
                } else {
                    result = String(format: NSLocalizedString("fukusuujikannmae", comment: ""), "\(diffSec / hour)")
                }
            } else {
                result = String(format: NSLocalizedString("nitimae", comment: ""), "1")
            }
        } else if diffSec < week {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "dd", options: 0, locale: Locale.current)!
            let postDateDay = dateFormatter.string(from: self)
            let sevenDaysAgoDate = Calendar.current.date(byAdding: .day, value: -7, to: Date())!
            let sevenDaysAgoDateDay = dateFormatter.string(from: sevenDaysAgoDate)
            print(postDateDay)
            print(sevenDaysAgoDateDay)
            if postDateDay != sevenDaysAgoDateDay {
                if (diffSec / day) == 1 {
                    result = String(format: NSLocalizedString("nitimae", comment: ""), "\(diffSec / day)")
                } else {
                    result = String(format: NSLocalizedString("fukusuunitimae", comment: ""), "\(diffSec / day)")
                }
            } else {
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMd", options: 0, locale: Locale.current)!
                result = dateFormatter.string(from: self)
            }
        } else {
            let dateFormatter = DateFormatter()
            
            dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyy", options: 0, locale: Locale.current)!
            let postDateYear = dateFormatter.string(from: self)
            let nowDateYear = dateFormatter.string(from: Date())
            
            if postDateYear == nowDateYear {
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "MMMMd", options: 0, locale: Locale.current)!
                result = dateFormatter.string(from: self)
            } else {
                dateFormatter.dateFormat = DateFormatter.dateFormat(fromTemplate: "yyyyMMMMd", options: 0, locale: Locale.current)!
                result = dateFormatter.string(from: self)
            }
        }

        return result
    }
}
