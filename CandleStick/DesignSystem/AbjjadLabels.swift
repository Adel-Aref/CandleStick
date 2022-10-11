//
//  AbjjadLabels.swift
//  CandleStick
//
//  Created by Adel Aref on 09/10/2022.
//

import Foundation
import UIKit

class AbjjadLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = R.color.titleColor()
        self.font = TextStyle.largeTitle.font
    }
}

class SmallLabel: UILabel {
    override func awakeFromNib() {
        super.awakeFromNib()
        self.textColor = R.color.titleColor()
        self.font = TextStyle.smallTitle.font
    }
}
