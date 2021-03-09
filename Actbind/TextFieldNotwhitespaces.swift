//
//  TextFieldNotwhitespaces.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/07.
//

import Foundation

extension String {
    /// StringからCharacterSetを取り除く
    func remove(characterSet: CharacterSet) -> String {
        return components(separatedBy: characterSet).joined()
    }

    /// StringからCharacterSetを抽出する
    func extract(characterSet: CharacterSet) -> String {
        return remove(characterSet: characterSet.inverted)
    }
}
