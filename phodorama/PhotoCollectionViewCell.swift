//
//  PhotoCollectionViewCell.swift
//  phodorama
//
//  Created by eli nathan on 6/15/17.
//  Copyright © 2017 eli nathan. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    
    @IBOutlet var imageView: UIImageView!
   
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = imageToDisplay
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        print("from nib")
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        print("from reuse")
        
        update(with: nil)
    }

    
    
    
    
    
}



