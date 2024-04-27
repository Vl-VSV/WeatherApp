//
//  String+localized.swift
//  Weather
//
//  Created by Vlad V on 27.04.2024.
//

import Foundation

extension String {
    func localized(comment: String = "") -> String {
        return NSLocalizedString(self, comment: comment)
    }
}
