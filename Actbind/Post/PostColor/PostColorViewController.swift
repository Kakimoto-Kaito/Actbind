//
//  PostColorViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import UIKit
import Vision

final class PostColorViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")

    // 撮影画面で撮影した画像またはカメラロールから選ばれた画像
    var postimage: UIImage?

    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var nextButton: UIBarButtonItem!
    @IBOutlet weak var backButton: UIBarButtonItem!
    @IBOutlet weak var selectColorLabel: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var redButton: UIButton!
    @IBOutlet weak var redSpaceView: UIView!
    @IBOutlet weak var redBorderView: UIView!
    @IBOutlet weak var orangeButton: UIButton!
    @IBOutlet weak var orangeSpaceView: UIView!
    @IBOutlet weak var orangeBorderView: UIView!
    @IBOutlet weak var yellowButton: UIButton!
    @IBOutlet weak var yellowSpaceView: UIView!
    @IBOutlet weak var yellowBorderView: UIView!
    @IBOutlet weak var greenButton: UIButton!
    @IBOutlet weak var greenSpaceView: UIView!
    @IBOutlet weak var greenBorderView: UIView!
    @IBOutlet weak var blueButton: UIButton!
    @IBOutlet weak var blueSpaceView: UIView!
    @IBOutlet weak var blueBorderView: UIView!
    @IBOutlet weak var purpleButton: UIButton!
    @IBOutlet weak var purpleSpaceView: UIView!
    @IBOutlet weak var purpleBorderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("kara-wosenntaku", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                backButton.tintColor = UIColor(named: "BlackWhite")
                nextButton.tintColor = UIColor(named: "Blue")
            } else {
                backButton.tintColor = UIColor(named: appColor!)
                nextButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        let attributes: [NSAttributedString.Key: Any] = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18.0)]
        nextButton.setTitleTextAttributes(attributes, for: UIControl.State.normal)
        nextButton.title = NSLocalizedString("tugihe", comment: "")
        
        backButton.image = UIImage(named: "back")
        
        postImage.image = postimage
        postImage.layer.cornerRadius = 16
        
        redButton.layer.cornerRadius = redButton.layer.bounds.width / 2
        redSpaceView.layer.cornerRadius = redSpaceView.layer.bounds.width / 2
        redBorderView.layer.cornerRadius = redBorderView
            .layer.bounds.width / 2
        
        orangeButton.layer.cornerRadius = orangeButton.layer.bounds.width / 2
        orangeSpaceView.layer.cornerRadius = orangeSpaceView.layer.bounds.width / 2
        orangeBorderView.layer.cornerRadius = orangeBorderView
            .layer.bounds.width / 2
        
        yellowButton.layer.cornerRadius = yellowButton.layer.bounds.width / 2
        yellowSpaceView.layer.cornerRadius = yellowSpaceView.layer.bounds.width / 2
        yellowBorderView.layer.cornerRadius = yellowBorderView.layer.bounds.width / 2
        
        greenButton.layer.cornerRadius = greenButton.layer.bounds.width / 2
        greenSpaceView.layer.cornerRadius = greenSpaceView.layer.bounds.width / 2
        greenBorderView.layer.cornerRadius = greenBorderView.layer.bounds.width / 2
        
        blueButton.layer.cornerRadius = blueButton.layer.bounds.width / 2
        blueSpaceView.layer.cornerRadius = blueSpaceView.layer.bounds.width / 2
        blueBorderView.layer.cornerRadius = blueBorderView.layer.bounds.width / 2
        
        purpleButton.layer.cornerRadius = purpleButton.layer.bounds.width / 2
        purpleSpaceView.layer.cornerRadius = purpleSpaceView.layer.bounds.width / 2
        purpleBorderView.layer.cornerRadius = purpleBorderView.layer.bounds.width / 2
        
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        
        guard let model = try? VNCoreMLModel(for: PostColorClassifier().model) else {
            fatalError("Loading Core ML Model Failed.")
        }
        let request = VNCoreMLRequest(model: model) { request, _ in
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image")
            }
            print(results)
            if let firstResult = results.first {
                if firstResult.identifier.contains("Red") {
                    self.redBorderView.backgroundColor = UIColor(named: "Border")
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = NSLocalizedString("red", comment: "")
                } else if firstResult.identifier.contains("Orange") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor(named: "Border")
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = NSLocalizedString("orange", comment: "")
                } else if firstResult.identifier.contains("Yellow") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor(named: "Border")
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = NSLocalizedString("yellow", comment: "")
                } else if firstResult.identifier.contains("Green") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor(named: "Border")
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = NSLocalizedString("green", comment: "")
                } else if firstResult.identifier.contains("Blue") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor(named: "Border")
                    self.purpleBorderView.backgroundColor = UIColor.clear
                    self.selectColorLabel.text = NSLocalizedString("blue", comment: "")
                } else if firstResult.identifier.contains("Purple") {
                    self.redBorderView.backgroundColor = UIColor.clear
                    self.orangeBorderView.backgroundColor = UIColor.clear
                    self.yellowBorderView.backgroundColor = UIColor.clear
                    self.greenBorderView.backgroundColor = UIColor.clear
                    self.blueBorderView.backgroundColor = UIColor.clear
                    self.purpleBorderView.backgroundColor = UIColor(named: "Border")
                    self.selectColorLabel.text = NSLocalizedString("purple", comment: "")
                } else {
                    self.selectColorLabel.text = "Error"
                }
            }
        }
        let ciImage = CIImage(image: postimage!)
        let handler = VNImageRequestHandler(ciImage: ciImage!)
        do {
            try! handler.perform([request])
        } catch {
            print(error)
        }
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
    }
    
    @IBAction func tapGesture(_ sender: Any) {
        performSegue(withIdentifier: "toImageSpotlightViewController", sender: nil)
    }
    
    @IBAction func redButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor(named: "Border")
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = NSLocalizedString("red", comment: "")
    }
    
    @IBAction func orangeButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor(named: "Border")
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = NSLocalizedString("orange", comment: "")
    }
    
    @IBAction func yellowButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor(named: "Border")
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = NSLocalizedString("yellow", comment: "")
    }
    
    @IBAction func greenButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor(named: "Border")
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = NSLocalizedString("green", comment: "")
    }
    
    @IBAction func blueButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor(named: "Border")
        purpleBorderView.backgroundColor = UIColor.clear
        selectColorLabel.text = NSLocalizedString("blue", comment: "")
    }
    
    @IBAction func purpleButtonTouchUpInside(_ sender: Any) {
        redBorderView.backgroundColor = UIColor.clear
        orangeBorderView.backgroundColor = UIColor.clear
        yellowBorderView.backgroundColor = UIColor.clear
        greenBorderView.backgroundColor = UIColor.clear
        blueBorderView.backgroundColor = UIColor.clear
        purpleBorderView.backgroundColor = UIColor(named: "Border")
        selectColorLabel.text = NSLocalizedString("purple", comment: "")
    }
    
    @IBAction func nextButtonAction(_ sender: Any) {
        performSegue(withIdentifier: "toPostViewController", sender: self)
    }

    @IBAction func screenEdgePanGestureAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func backBottonAction(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }

    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toImageSpotlightViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! ImageSpotlightViewController
            
            nextView.spotlightimage = postimage
        }
        
        // Segueの識別子確認
        if segue.identifier == "toPostViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! PostViewController
     
            // 値の設定
            if selectColorLabel.text == NSLocalizedString("red", comment: "") {
                nextView.postcolor = "red"
            } else if selectColorLabel.text == NSLocalizedString("orange", comment: "") {
                nextView.postcolor = "orange"
            } else if selectColorLabel.text == NSLocalizedString("yellow", comment: "") {
                nextView.postcolor = "yellow"
            } else if selectColorLabel.text == NSLocalizedString("green", comment: "") {
                nextView.postcolor = "green"
            } else if selectColorLabel.text == NSLocalizedString("blue", comment: "") {
                nextView.postcolor = "blue"
            } else {
                nextView.postcolor = "purple"
            }
            nextView.postimage = postimage
        }
    }
}
