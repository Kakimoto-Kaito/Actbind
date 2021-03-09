//
//  PostInCameraViewController.swift
//  Actbind
//
//  Created by 柿本海斗 on 2021/03/02.
//

import AVFoundation
import UIKit

final class PostInCameraViewController: UIViewController {
    let userDefaults = UserDefaults(suiteName: "group.com.actbind")
    let flashOnOff = UserDefaults.standard.string(forKey: "flashonoff")
    
    @IBOutlet weak var navigationBarTitle: UINavigationItem!
    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var gridImage: UIImageView!
    @IBOutlet weak var gridButton: UIButton!
    @IBOutlet weak var cameraButton: UIButton!
    @IBOutlet weak var flashButton: UIButton!
    @IBOutlet weak var changeButton: UIButton!

    // デバイスからの入力と出力を管理するオブジェクトの作成
    var captureSession = AVCaptureSession()
    // カメラデバイスそのものを管理するオブジェクトの作成
    // メインカメラの管理オブジェクトの作成
    var mainCamera: AVCaptureDevice?
    // インカメの管理オブジェクトの作成
    var innerCamera: AVCaptureDevice?
    // 現在使用しているカメラデバイスの管理オブジェクトの作成
    var currentDevice: AVCaptureDevice?
    // キャプチャーの出力データを受け付けるオブジェクト
    var photoOutput: AVCapturePhotoOutput?
    // プレビュー表示用のレイヤ
    var cameraPreviewLayer: AVCaptureVideoPreviewLayer?
    // 撮影結果
    var resultImage: UIImage?

    var gridcount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBarTitle.title = NSLocalizedString("syasinn", comment: "")

        if let userDefaults = userDefaults {
            let appColor = userDefaults.string(forKey: "appcolor")

            if appColor == "Original" {
                cancelButton.tintColor = UIColor(named: "BlackWhite")
            } else {
                cancelButton.tintColor = UIColor(named: appColor!)
            }
        }
        
        cancelButton.image = UIImage(named: "cancel")

        gridImage.isHidden = true

        gridButton.layer.cornerRadius = gridButton.layer.bounds.width / 2
        cameraButton.layer.cornerRadius = cameraButton.layer.bounds.width / 2
        flashButton.layer.cornerRadius = flashButton.layer.bounds.width / 2
        changeButton.layer.cornerRadius = changeButton.layer.bounds.width / 2

        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)

        gridButton.setImage(UIImage(systemName: "grid", withConfiguration: cameraViewSystemButtonConfig), for: .normal)

        changeButton.setImage(UIImage(systemName: "arrow.triangle.2.circlepath", withConfiguration: cameraViewSystemButtonConfig), for: .normal)

        setupCaptureSession()
        setupDevice()
        setupInputOutput()
        setupPreviewLayer()
        captureSession.startRunning()
    }
    
    // 画面に表示される直前に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)]
        
        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        
        if flashOnOff == "Off" {
            flashButton.setImage(UIImage(systemName: "bolt.slash.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
        } else {
            flashButton.setImage(UIImage(systemName: "bolt.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
        }
    }
    
    // 画面から非表示になる直後に呼ばれます。
    // viewDidLoadとは異なり毎回呼び出されます。
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        captureSession.stopRunning()
    }

    @IBAction func gridButtonTouchDown(_ sender: Any) {
        gridButton.backgroundColor = UIColor(named: "LightGray")
    }

    @IBAction func gridButtonTouchDragOutside(_ sender: Any) {
        gridButton.backgroundColor = UIColor.clear
    }

    @IBAction func gridButtonTouchUpInside(_ sender: Any) {
        gridButton.backgroundColor = UIColor.clear

        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        gridButton.setImage(UIImage(systemName: "grid", withConfiguration: cameraViewSystemButtonConfig), for: .normal)

        gridcount += 1

        if gridcount % 2 == 0 {
            gridImage.isHidden = true
        } else {
            gridImage.isHidden = false
        }
    }

    @IBAction func flashButtonTouchDown(_ sender: Any) {
        flashButton.backgroundColor = UIColor(named: "LightGray")
    }
    
    @IBAction func flashButtonTouchDragOutside(_ sender: Any) {
        flashButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func flashButtonTouchUpInside(_ sender: Any) {
        flashButton.backgroundColor = UIColor.clear
        
        let cameraViewSystemButtonConfig = UIImage.SymbolConfiguration(pointSize: 30, weight: .bold, scale: .default)
        if flashOnOff == "Off" {
            UserDefaults.standard.set("On", forKey: "flashonoff")
            flashButton.setImage(UIImage(systemName: "bolt.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
        } else {
            UserDefaults.standard.set("Off", forKey: "flashonoff")
            flashButton.setImage(UIImage(systemName: "bolt.slash.fill", withConfiguration: cameraViewSystemButtonConfig), for: .normal)
        }
    }
    
    @IBAction func toOutCameraButtonTouchDown(_ sender: Any) {
        changeButton.backgroundColor = UIColor(named: "LightGray")
    }
    
    @IBAction func toOutCameraButtonTouchDragOutside(_ sender: Any) {
        changeButton.backgroundColor = UIColor.clear
    }
    
    @IBAction func toOutCameraButtonTouchUpInside(_ sender: Any) {
        changeButton.backgroundColor = UIColor.clear
        
        performSegue(withIdentifier: "toBackCameraViewController", sender: nil)
    }

    @IBAction func cameraButtonTouchDown(_ sender: Any) {
        cameraButton.alpha = 0.5
    }

    @IBAction func cameraButtonTouchDragOutside(_ sender: Any) {
        cameraButton.alpha = 1.0
    }

    @IBAction func cameraButtonTouchUpInside(_ sender: Any) {
        let settings = AVCapturePhotoSettings()
        cameraButton.alpha = 1.0

        // フラッシュの設定
        if flashOnOff == "Off" {
            settings.flashMode = .off
        } else {
            settings.flashMode = .on
        }
        
        // カメラの手ぶれ補正
        settings.isAutoStillImageStabilizationEnabled = true
        // 撮影された画像をdelegateメソッドで処理
        photoOutput?.capturePhoto(with: settings, delegate: self as AVCapturePhotoCaptureDelegate)
    }

    @IBAction func cancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    // 画面遷移の実行前処理
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Segueの識別子確認
        if segue.identifier == "toPostColorViewController" {
            // 遷移先ViewCntrollerの取得
            let nextView = segue.destination as! PostColorViewController
            
            // 値の設定
            nextView.postimage = resultImage
        }
    }
}

extension PostInCameraViewController: AVCapturePhotoCaptureDelegate {
    // 撮影した画像データが生成されたときに呼び出されるデリゲートメソッド
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        if let imageData = photo.fileDataRepresentation() {
            // Data型をUIImageオブジェクトに変換
            let uiImage = UIImage(data: imageData)
            // 撮影結果を保持
            resultImage = uiImage
            
            if let userDefaults = userDefaults {
                let savePhoto = userDefaults.string(forKey: "savephoto")
                
                if savePhoto == "On" {
                    // 写真ライブラリに画像を保存
                    UIImageWriteToSavedPhotosAlbum(uiImage!, nil, nil, nil)
                }
            }
            
            // 撮影結果画面へ遷移
            performSegue(withIdentifier: "toPostColorViewController", sender: nil)
        }
    }
}

// MARK: カメラ設定メソッド

extension PostInCameraViewController {
    // カメラの画質の設定
    func setupCaptureSession() {
        captureSession.sessionPreset = AVCaptureSession.Preset.photo
    }
    
    // デバイスの設定
    func setupDevice() {
        // カメラデバイスのプロパティ設定
        let deviceDiscoverySession = AVCaptureDevice.DiscoverySession(deviceTypes: [AVCaptureDevice.DeviceType.builtInWideAngleCamera], mediaType: AVMediaType.video, position: AVCaptureDevice.Position.unspecified)
        // プロパティの条件を満たしたカメラデバイスの取得
        let devices = deviceDiscoverySession.devices

        for device in devices {
            if device.position == AVCaptureDevice.Position.back {
                mainCamera = device
            } else if device.position == AVCaptureDevice.Position.front {
                innerCamera = device
            }
        }
        // 起動時のカメラを設定
        currentDevice = innerCamera
    }
    
    // 入出力データの設定
    func setupInputOutput() {
        do {
            // 指定したデバイスを使用するために入力を初期化
            let captureDeviceInput = try AVCaptureDeviceInput(device: currentDevice!)
            // 指定した入力をセッションに追加
            captureSession.addInput(captureDeviceInput)
            // 出力データを受け取るオブジェクトの作成
            photoOutput = AVCapturePhotoOutput()
            // 出力ファイルのフォーマットを指定
            photoOutput!.setPreparedPhotoSettingsArray([AVCapturePhotoSettings(format: [AVVideoCodecKey: AVVideoCodecType.jpeg])], completionHandler: nil)
            captureSession.addOutput(photoOutput!)
        } catch {
            print(error)
        }
    }
    
    // カメラのプレビューを表示するレイヤの設定
    func setupPreviewLayer() {
        // 指定したAVCaptureSessionでプレビューレイヤを初期化
        cameraPreviewLayer = AVCaptureVideoPreviewLayer(session: captureSession)
        // プレビューレイヤが、カメラのキャプチャーを縦横比を維持した状態で、表示するように設定
        cameraPreviewLayer?.videoGravity = AVLayerVideoGravity.resizeAspectFill
        // プレビューレイヤの表示の向きを設定
        cameraPreviewLayer?.connection?.videoOrientation = AVCaptureVideoOrientation.portrait
        // 画面サイズ
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        cameraPreviewLayer?.frame = CGRect(x: 0, y: 92, width: Int(myBoundSize.width), height: Int(myBoundSize.width))
        view.layer.insertSublayer(cameraPreviewLayer!, at: 0)
    }
}
