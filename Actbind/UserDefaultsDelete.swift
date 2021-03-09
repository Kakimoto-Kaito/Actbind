//
//  UserDefaultsDelete.swift
//  Actbind
//
//  Created by 柿本　海斗 on 2020/12/05.
//

import Foundation

extension UserDefaults {
    func removeAll() {
        dictionaryRepresentation().forEach { removeObject(forKey: $0.key) }
    }
}
