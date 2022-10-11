//  Typography.swift
//  CandleStick
//
//  Created by Adel Aref on 09/10/2022.
//
import Foundation
import UIKit

enum Font: String {
    case regular = "AvenirNextCondensed-Regular"
    case demiBold = "AvenirNextCondensed-DemiBold"
    case medium = "AvenirNextCondensed-Medium"
    case heavy = "AvenirNextCondensed-Bold"

    var name: String {
        return self.rawValue
    }
}
//
struct FontDescription {
    let font: Font
    let size: CGFloat
    let style: UIFont.TextStyle
}
enum TextStyle {
    case largeTitle //34pt, Demibold
    case smallTitle //28pt, Demibold
    case display3 //20pt, Demibold
    case headline //16pt, Demibold
    case subheadline //14pt, Demibold

    case input //14pt, Demibold

    case paragraph //16pt, Regular
    case paragraphSmall //14pt, Regular

    case link //16pt, Demibold
    case secondaryButton //16pt, Medium
    case primaryButton //14pt, Medium
}
extension TextStyle {
    private var fontDescription: FontDescription {
        switch self {
        case .largeTitle:
            return FontDescription(font: .medium, size: 34, style: .largeTitle)
        case .smallTitle:
            return FontDescription(font: .demiBold, size: 17, style: .title1)
        case .display3:
            return FontDescription(font: .demiBold, size: 20, style: .title2)
        case .headline:
            return FontDescription(font: .demiBold, size: 15, style: .headline)
        case .subheadline:
            return FontDescription(font: .demiBold, size: 14, style: .subheadline)
        case .input:
            return FontDescription(font: .demiBold, size: 15, style: .subheadline)
        case .paragraph:
            return FontDescription(font: .regular, size: 16, style: .body)
        case .paragraphSmall:
            return FontDescription(font: .regular, size: 14, style: .caption1)
        case .link:
            return FontDescription(font: .demiBold, size: 16, style: .callout)
        case .primaryButton:
            return FontDescription(font: .medium, size: 17, style: .callout)
        case .secondaryButton:
            return FontDescription(font: .medium, size: 14, style: .callout)
        }
    }
}
extension TextStyle {
    var font: UIFont {
        guard let font = UIFont(name: fontDescription.font.name, size: fontDescription.size) else {
            return UIFont.preferredFont(forTextStyle: fontDescription.style)
        }

        let fontMetrics = UIFontMetrics(forTextStyle: fontDescription.style)
        return fontMetrics.scaledFont(for: font)
    }
}
