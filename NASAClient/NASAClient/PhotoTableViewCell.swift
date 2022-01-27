//
//  PhotoTableViewCell.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 26.12.2021.
//

import UIKit
import Kingfisher

class PhotoTableViewCell: UITableViewCell {

    @IBOutlet weak var roverLabel: UILabel!
    @IBOutlet weak var cameraLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    
//    private var photoModel: Photo?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
//    public func setModelToUI(model: Photo) {
//        self.roverLabel.text = "Rover: \(model.rover.name )"
//        self.cameraLabel.text = "Camera: \(model.camera.full_name)"
//        self.dateLabel.text = "Date: \(model.earth_date)"
//
//        if let photoURL = URL(string: model.img_src){
//            self.photoImage.kf.setImage(with: photoURL)
//        }
//    }

    
}
