//
//  CountryCellTableViewCell.swift
//  
//
//  Created by JUNE on 2019/12/27.
//

import UIKit
import Kingfisher
class CountryCellTableViewCell: UITableViewCell {
    @IBOutlet weak var countryImage: UIImageView!
    @IBOutlet weak var countryTitle: UILabel!
    var regionCode = "-1"
    var viewModel: CountryModel! {
        willSet {
            self.countryTitle.text = newValue.regionName
            self.regionCode = newValue.regionCode
            do {
                guard let imageURL = URL(string: newValue.regionImg) else { return }
                self.countryImage.kf.setImage(with: imageURL,
                                              options: [
                                                .transition(.fade(1)),
                                                .cacheOriginalImage])
                
//                let imgData = try Data(contentsOf: imageURL)
//                self.countryImage.image = UIImage(data: imgData)
            }catch(let err) {
                print(err.localizedDescription)
            }
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        self.countryImage.layer.cornerRadius = self.countryImage.frame.width/2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
