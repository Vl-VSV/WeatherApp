//
//  LocalizationManager.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

protocol ILocalizationManager {
    static func preferredLanguage() -> Languages
}

final class LocalizationManager: ILocalizationManager {
    static func preferredLanguage() -> Languages {
        guard let preferredLang = Locale.preferredLanguages.first else {
            return .en
        }

        let locale = Locale(identifier: preferredLang)
        let regionCode = locale.regionCode

        if regionCode == "RU" {
            return .ru
        } else {
            return .en
        }
    }
}
