//
//  UILabel+Extension.swift
//  With
//
//  Created by 남수김 on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func labelKern(kerningValue: CGFloat) {
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [NSAttributedString.Key.kern: kerningValue, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: self.textColor!])
    }
    func labelParagraphStyle(paragraphValue: CGFloat) {
        let paragraph = NSMutableParagraphStyle()
        paragraph.lineSpacing = paragraphValue
        self.attributedText = NSAttributedString(string: self.text ?? "", attributes: [
            NSAttributedString.Key.paragraphStyle: paragraph, NSAttributedString.Key.font: font!, NSAttributedString.Key.foregroundColor: self.textColor!
        ])
    }
}
