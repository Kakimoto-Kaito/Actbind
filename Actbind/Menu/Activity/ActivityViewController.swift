//
//  ActivityViewController.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2021/02/04.
//

import UIKit

final class ActivityViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var activityTitleLabel: UILabel!
    @IBOutlet weak var activityAvgLabel: UILabel!
    @IBOutlet weak var avgTimeLabel: UILabel!
    @IBOutlet weak var activityWeekLabel: UILabel!
    @IBOutlet weak var selectActivityTimeLabel: UILabel!
    @IBOutlet weak var selectActivityDayLabel: UILabel!
    @IBOutlet weak var chartView: UIView!
    @IBOutlet weak var avgLineView: UIView!
    @IBOutlet weak var avgLineViewBottom: NSLayoutConstraint!
    @IBOutlet weak var toDayChartButton: UIButton!
    @IBOutlet weak var toDayChartView: UIView!
    @IBOutlet weak var toDayChartViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var oneDayChartButton: UIButton!
    @IBOutlet weak var oneDayChartView: UIView!
    @IBOutlet weak var oneDayChartViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var twoDayChartButton: UIButton!
    @IBOutlet weak var twoDayChartView: UIView!
    @IBOutlet weak var twoDayChartViewHeight: NSLayoutConstraint!
    
    @IBOutlet weak var threeDayChartButton: UIButton!
    @IBOutlet weak var threeDayChartView: UIView!
    @IBOutlet weak var threeDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fourDayChartButton: UIButton!
    @IBOutlet weak var fourDayChartView: UIView!
    @IBOutlet weak var fourDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var fiveDayChartButton: UIButton!
    @IBOutlet weak var fiveDayChartView: UIView!
    @IBOutlet weak var fiveDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var sixDayChartButton: UIButton!
    @IBOutlet weak var sixDayChartView: UIView!
    @IBOutlet weak var sixDayChartViewHeight: NSLayoutConstraint!
    @IBOutlet weak var toDayLabel: UILabel!
    @IBOutlet weak var oneDayLabel: UILabel!
    @IBOutlet weak var twoDayLabel: UILabel!
    @IBOutlet weak var threeDayLabel: UILabel!
    @IBOutlet weak var fourDayLabel: UILabel!
    @IBOutlet weak var fiveDayLabel: UILabel!
    @IBOutlet weak var sixDayLabel: UILabel!
    
    var toDayActivityTime = 0
    var oneDayActivityTime = 0
    var twoDayActivityTime = 0
    var threeDayActivityTime = 0
    var fourDayActivityTime = 0
    var fiveDayActivityTime = 0
    var sixDayActivityTime = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationBarTitle.title = NSLocalizedString("akuthibithi", comment: "")
        
        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")
        
            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                avgTimeLabel.textColor = UIColor(named: "Blue")
                avgLineView.backgroundColor = UIColor(named: "Blue")
                if toDayActivityTime >= 60 {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if toDayActivityTime < 60, toDayActivityTime >= 30 {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    toDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if oneDayActivityTime >= 60 {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if oneDayActivityTime < 60, oneDayActivityTime >= 30 {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    oneDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if twoDayActivityTime >= 60 {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if twoDayActivityTime < 60, twoDayActivityTime >= 30 {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    twoDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if threeDayActivityTime >= 60 {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if threeDayActivityTime < 60, threeDayActivityTime >= 30 {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    threeDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if fourDayActivityTime >= 60 {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if fourDayActivityTime < 60, fourDayActivityTime >= 30 {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    fourDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if fiveDayActivityTime >= 60 {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if fiveDayActivityTime < 60, fiveDayActivityTime >= 30 {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    fiveDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
                if sixDayActivityTime >= 60 {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Plus")
                } else if sixDayActivityTime < 60, sixDayActivityTime >= 30 {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf")
                } else {
                    sixDayChartView.backgroundColor = UIColor(named: "BlueHalf" + "Minus")
                }
                
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                avgTimeLabel.textColor = UIColor(named: appColor!)
                avgLineView.backgroundColor = UIColor(named: appColor!)
                if toDayActivityTime >= 60 {
                    toDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if toDayActivityTime < 60, toDayActivityTime >= 30 {
                    toDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    toDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if oneDayActivityTime >= 60 {
                    oneDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if oneDayActivityTime < 60, oneDayActivityTime >= 30 {
                    oneDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    oneDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if twoDayActivityTime >= 60 {
                    twoDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if twoDayActivityTime < 60, twoDayActivityTime >= 30 {
                    twoDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    twoDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if threeDayActivityTime >= 60 {
                    threeDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if threeDayActivityTime < 60, threeDayActivityTime >= 30 {
                    threeDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    threeDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if fourDayActivityTime >= 60 {
                    fourDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if fourDayActivityTime < 60, fourDayActivityTime >= 30 {
                    fourDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    fourDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if fiveDayActivityTime >= 60 {
                    fiveDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if fiveDayActivityTime < 60, fiveDayActivityTime >= 30 {
                    fiveDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    fiveDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
                
                if sixDayActivityTime >= 60 {
                    sixDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Plus")
                } else if sixDayActivityTime < 60, sixDayActivityTime >= 30 {
                    sixDayChartView.backgroundColor = UIColor(named: appColor! + "Half")
                } else {
                    sixDayChartView.backgroundColor = UIColor(named: appColor! + "Half" + "Minus")
                }
            }
        }
        
        // 日毎の値
        toDayActivityTime = 40
        oneDayActivityTime = 90
        twoDayActivityTime = 60
        threeDayActivityTime = 30
        fourDayActivityTime = 150
        fiveDayActivityTime = 50
        sixDayActivityTime = 20
        
        activityTitleLabel.text = NSLocalizedString("riyoujikann", comment: "")
        activityAvgLabel.text = NSLocalizedString("itinitinoheikinn", comment: "")
        
        let weekActivityTime = [sixDayActivityTime, fiveDayActivityTime, fourDayActivityTime, threeDayActivityTime, twoDayActivityTime, oneDayActivityTime, toDayActivityTime]
        // 平均
        let avg = weekActivityTime.reduce(0) { $0 + $1 } / weekActivityTime.count
        // 1週間の平均を計算
        let hour = avg / 60
        if hour == 0 {
            let avgString = String(avg)
            avgTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let hourString = String(hour)
            let minute = avg - (hour * 60)
            let minuteString = String(minute)
            avgTimeLabel.text = hourString + NSLocalizedString("jikann", comment: "") + " " + minuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 1週間の平均のフォーマット
        let avgWeekFormatter = DateIntervalFormatter()
        avgWeekFormatter.dateTemplate = "yyyyMMMd"
        let date = Date()
        // １週間前の日付
        let date2 = date - (60 * 60 * 144)
        activityWeekLabel.text = avgWeekFormatter.string(from: date2, to: date)
        
        // 今日の利用時間を計算
        let toDayActivityTimeHour = toDayActivityTime / 60
        if toDayActivityTimeHour == 0 {
            let avgString = String(toDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let toDayActivityTimeHourString = String(toDayActivityTimeHour)
            let toDayActivityTimeMinute = toDayActivityTime - (toDayActivityTimeHour * 60)
            let toDayActivityTimeMinuteString = String(toDayActivityTimeMinute)
            selectActivityTimeLabel.text = toDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + toDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        let toDayActivityDateFormatter = DateFormatter()
        toDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = toDayActivityDateFormatter.string(from: Date())
        
        // 最大値
        let activityMax = weekActivityTime.max()
        
        let avgLine = Double(avg) / Double(activityMax!) * 100
        let toDayChart = Double(toDayActivityTime) / Double(activityMax!) * 100
        let oneDayChart = Double(oneDayActivityTime) / Double(activityMax!) * 100
        let twoDayChart = Double(twoDayActivityTime) / Double(activityMax!) * 100
        let threeDayChart = Double(threeDayActivityTime) / Double(activityMax!) * 100
        let fourDayChart = Double(fourDayActivityTime) / Double(activityMax!) * 100
        let fiveDayChart = Double(fiveDayActivityTime) / Double(activityMax!) * 100
        let sixDayChart = Double(sixDayActivityTime) / Double(activityMax!) * 100
        
        let maxHeight = chartView.bounds.height
        
        avgLineViewBottom.constant = maxHeight * CGFloat(avgLine) / 100
        toDayChartViewHeight.constant = maxHeight * CGFloat(toDayChart) / 100
        oneDayChartViewHeight.constant = maxHeight * CGFloat(oneDayChart) / 100
        twoDayChartViewHeight.constant = maxHeight * CGFloat(twoDayChart) / 100
        threeDayChartViewHeight.constant = maxHeight * CGFloat(threeDayChart) / 100
        fourDayChartViewHeight.constant = maxHeight * CGFloat(fourDayChart) / 100
        fiveDayChartViewHeight.constant = maxHeight * CGFloat(fiveDayChart) / 100
        sixDayChartViewHeight.constant = maxHeight * CGFloat(sixDayChart) / 100
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE"
        
        let toDay = Date()
        let oneDay = toDay.addingTimeInterval(60 * 60 * -24)
        let twoDay = toDay.addingTimeInterval(60 * 60 * -48)
        let threeDay = toDay.addingTimeInterval(60 * 60 * -72)
        let fourDay = toDay.addingTimeInterval(60 * 60 * -96)
        let fiveDay = toDay.addingTimeInterval(60 * 60 * -120)
        let sixDay = toDay.addingTimeInterval(60 * 60 * -144)
         
        let oneDayString = dateFormatter.string(from: oneDay)
        let twoDayString = dateFormatter.string(from: twoDay)
        let threeDayString = dateFormatter.string(from: threeDay)
        let fourDayString = dateFormatter.string(from: fourDay)
        let fiveDayString = dateFormatter.string(from: fiveDay)
        let sixDayString = dateFormatter.string(from: sixDay)
        
        toDayLabel.text = NSLocalizedString("kyou", comment: "")
        oneDayLabel.text = oneDayString
        twoDayLabel.text = twoDayString
        threeDayLabel.text = threeDayString
        fourDayLabel.text = fourDayString
        fiveDayLabel.text = fiveDayString
        sixDayLabel.text = sixDayString
        
        backButton.image = UIImage(named: "back")
    }
    
    @IBAction func toDayChartButtonTouchUpInside(_ sender: Any) {
        // 今日の利用時間を計算
        let toDayActivityTimeHour = toDayActivityTime / 60
        if toDayActivityTimeHour == 0 {
            let avgString = String(toDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let toDayActivityTimeHourString = String(toDayActivityTimeHour)
            let toDayActivityTimeMinute = toDayActivityTime - (toDayActivityTimeHour * 60)
            let toDayActivityTimeMinuteString = String(toDayActivityTimeMinute)
            selectActivityTimeLabel.text = toDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + toDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        let toDayActivityDateFormatter = DateFormatter()
        toDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = toDayActivityDateFormatter.string(from: Date())
    }
    
    @IBAction func oneDayChartButton(_ sender: Any) {
        // 1日前の利用時間を計算
        let oneDayActivityTimeHour = oneDayActivityTime / 60
        if oneDayActivityTimeHour == 0 {
            let avgString = String(oneDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let oneDayActivityTimeHourString = String(oneDayActivityTimeHour)
            let oneDayActivityTimeMinute = oneDayActivityTime - (oneDayActivityTimeHour * 60)
            let oneDayActivityTimeMinuteString = String(oneDayActivityTimeMinute)
            selectActivityTimeLabel.text = oneDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + oneDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 1日前のdateを取得
        let oneDay = Calendar.current.date(byAdding: .day, value: -1, to: Date())!
        let oneDayActivityDateFormatter = DateFormatter()
        oneDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = oneDayActivityDateFormatter.string(from: oneDay)
    }
    
    @IBAction func twoDayChartButton(_ sender: Any) {
        // 2日前の利用時間を計算
        let twoDayActivityTimeHour = twoDayActivityTime / 60
        if twoDayActivityTimeHour == 0 {
            let avgString = String(twoDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let twoDayActivityTimeHourString = String(twoDayActivityTimeHour)
            let twoDayActivityTimeMinute = twoDayActivityTime - (twoDayActivityTimeHour * 60)
            let twoDayActivityTimeMinuteString = String(twoDayActivityTimeMinute)
            selectActivityTimeLabel.text = twoDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + twoDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 2日前のdateを取得
        let twoDay = Calendar.current.date(byAdding: .day, value: -2, to: Date())!
        let twoDayActivityDateFormatter = DateFormatter()
        twoDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = twoDayActivityDateFormatter.string(from: twoDay)
    }
    
    @IBAction func threeDayChartButton(_ sender: Any) {
        // 3日前の利用時間を計算
        let threeDayActivityTimeHour = threeDayActivityTime / 60
        if threeDayActivityTimeHour == 0 {
            let avgString = String(threeDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let threeDayActivityTimeHourString = String(threeDayActivityTimeHour)
            let threeDayActivityTimeMinute = threeDayActivityTime - (threeDayActivityTimeHour * 60)
            let threeDayActivityTimeMinuteString = String(threeDayActivityTimeMinute)
            selectActivityTimeLabel.text = threeDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + threeDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 3日前のdateを取得
        let threeDay = Calendar.current.date(byAdding: .day, value: -3, to: Date())!
        let threeDayActivityDateFormatter = DateFormatter()
        threeDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = threeDayActivityDateFormatter.string(from: threeDay)
    }
    
    @IBAction func fourDayChartButton(_ sender: Any) {
        // 4日前の利用時間を計算
        let fourDayActivityTimeHour = fourDayActivityTime / 60
        if fourDayActivityTimeHour == 0 {
            let avgString = String(fourDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let fourDayActivityTimeHourString = String(fourDayActivityTimeHour)
            let fourDayActivityTimeMinute = fourDayActivityTime - (fourDayActivityTimeHour * 60)
            let fourDayActivityTimeMinuteString = String(fourDayActivityTimeMinute)
            selectActivityTimeLabel.text = fourDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + fourDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 4日前のdateを取得
        let fourDay = Calendar.current.date(byAdding: .day, value: -4, to: Date())!
        let fourDayActivityDateFormatter = DateFormatter()
        fourDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = fourDayActivityDateFormatter.string(from: fourDay)
    }
    
    @IBAction func fiveDayChartButton(_ sender: Any) {
        // 5日前の利用時間を計算
        let fiveDayActivityTimeHour = fiveDayActivityTime / 60
        if fiveDayActivityTimeHour == 0 {
            let avgString = String(fiveDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let fiveDayActivityTimeHourString = String(fiveDayActivityTimeHour)
            let fiveDayActivityTimeMinute = fiveDayActivityTime - (fiveDayActivityTimeHour * 60)
            let fiveDayActivityTimeMinuteString = String(fiveDayActivityTimeMinute)
            selectActivityTimeLabel.text = fiveDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + fiveDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 5日前のdateを取得
        let fiveDay = Calendar.current.date(byAdding: .day, value: -5, to: Date())!
        let fiveDayActivityDateFormatter = DateFormatter()
        fiveDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = fiveDayActivityDateFormatter.string(from: fiveDay)
    }
    
    @IBAction func sixDayChartButton(_ sender: Any) {
        // 6日前の利用時間を計算
        let sixDayActivityTimeHour = sixDayActivityTime / 60
        if sixDayActivityTimeHour == 0 {
            let avgString = String(sixDayActivityTime)
            selectActivityTimeLabel.text = avgString + NSLocalizedString("funn", comment: "")
        } else {
            let sixDayActivityTimeHourString = String(sixDayActivityTimeHour)
            let sixDayActivityTimeMinute = sixDayActivityTime - (sixDayActivityTimeHour * 60)
            let sixDayActivityTimeMinuteString = String(sixDayActivityTimeMinute)
            selectActivityTimeLabel.text = sixDayActivityTimeHourString + NSLocalizedString("jikann", comment: "") + " " + sixDayActivityTimeMinuteString + NSLocalizedString("funn", comment: "")
        }
        
        // 6日前のdateを取得
        let sixDay = Calendar.current.date(byAdding: .day, value: -6, to: Date())!
        let sixDayActivityDateFormatter = DateFormatter()
        sixDayActivityDateFormatter.dateStyle = .long
        selectActivityDayLabel.text = sixDayActivityDateFormatter.string(from: sixDay)
    }
    
    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
