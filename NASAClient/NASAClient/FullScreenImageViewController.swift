//
//  FullScreenImageViewController.swift
//  NASAClient
//
//  Created by Dmitry Tkachenko on 05.01.2022.
//

import UIKit

class FullScreenImageViewController: UIViewController {

    @IBOutlet weak var fullScreenImageView: UIImageView!
    var selectedImage: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageURL = NSURL(string: self.selectedImage)
        let imageData = NSData(contentsOf: imageURL! as URL)

        
        if (imageData != nil){
            self.fullScreenImageView.image = UIImage(data: imageData! as Data)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        
        
    }

}
