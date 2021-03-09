//
//  PlaceHolderTextView.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/11/28.
//

import UIKit

final class PlaceHolderTextView: UITextView {
    // MARK: Stored Instance Properties

    @IBInspectable private var placeHolder: String = "" {
        willSet {
            placeHolderLabel.text = NSLocalizedString("syasinnnituitenosetumei", comment: "") // newValue

            placeHolderLabel.sizeToFit()
        }
    }
    
    private lazy var placeHolderLabel: UILabel = {
        let label = UILabel(frame: CGRect(x: 15.0, y: 10.0, width: 0.0, height: 0.0))
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.font = self.font
        label.textColor = UIColor(named: "TextFieldText") // UIColor(red: 0.0, green: 0.0, blue: 0.0980392, alpha: 0.22)
        label.backgroundColor = .clear
        self.addSubview(label)
        return label
    }()

    // MARK: Initializers

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: View Life-Cycle Methods

    override func awakeFromNib() {
        super.awakeFromNib()
        changeVisiblePlaceHolder()
        NotificationCenter.default.addObserver(self, selector: #selector(textChanged),
                                               name: UITextView.textDidChangeNotification, object: nil)
    }

    // MARK: Other Private Methods

    private func changeVisiblePlaceHolder() {
        placeHolderLabel.alpha = (placeHolder.isEmpty || !text.isEmpty) ? 0.0 : 1.0
    }

    @objc private func textChanged(notification: NSNotification?) {
        changeVisiblePlaceHolder()
    }
}
