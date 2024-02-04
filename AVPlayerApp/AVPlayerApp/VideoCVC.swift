//
//  VideoCVC.swift
//  AVPlayerApp
//
//  Created by Asadbek Muzaffarov on 04/02/24.
//

import UIKit

class VideoCVC: UICollectionViewCell {

    
    static func nib() -> UINib {
        UINib(nibName: "VideoCVC", bundle: nil)
    }
    static let identifier: String = "VideoCVC"
    
    @IBOutlet weak var imageView: UIImageView! {
        didSet {
            imageView.layer.cornerRadius = 20
            
            
        }
    }
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }

}
