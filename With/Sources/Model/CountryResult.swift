//
//  Country.swift
//  With
//
//  Created by JUNE on 2019/12/27.
//  Copyright © 2019 ns. All rights reserved.
//

import UIKit
struct CountryResult {
    var countryImage: UIImage?
    var countryTitle: String
    init(title: String, image: String) {
        self.countryImage = UIImage(named: image)
        self.countryTitle = title
    }
}
