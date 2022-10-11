//
//  UserDefaults+States.swift
//  CandleStick
//
//  Created by Adel Aref on 08/10/2022.
//

import Foundation

extension UserDefaults {
    struct Keys {
        static let apiKey: String = "apiKey"
        static let page: String = "page"
        static let isShowInstruction: String = "page"

    }
    public var apiKey: String? {
        get {
            guard let apiKey = value(forKey: Keys.apiKey) as? String else { return nil }
            return apiKey
        }
        set {
            set(newValue, forKey: Keys.apiKey)
        }
    }
    public var page: String? {
        get {
            guard let page = value(forKey: Keys.page) as? String else { return nil }
            return page
        }
        set {
            set(newValue, forKey: Keys.page)
        }
    }
    public var isShowInstruction: Bool {
        get {
            guard let isInstructionShown = value(forKey: Keys.isShowInstruction) as? Bool else { return false }
            return isInstructionShown
        }
        set {
            set(newValue, forKey: Keys.isShowInstruction)
        }
    }
}
