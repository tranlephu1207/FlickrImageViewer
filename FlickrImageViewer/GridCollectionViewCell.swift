//
//  GridCollectionViewCell.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/6/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

//class GridCollectionViewCell: UICollectionViewCell {
//
//    @IBOutlet weak var imgView: UIImageView!
//    var photoObj:ImageModel!
//
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//        self.backgroundColor = UIColor.black
//        self.imgView.contentMode = .scaleAspectFill
//        self.imgView.sd_setShowActivityIndicatorView(true)
//        self.imgView.sd_setIndicatorStyle(.white)
//    }
//
//    func loadImage(photoObj:ImageModel, image:UIImage?, callback: @escaping (_ tuple: (image:UIImage?, id:String)?)->Void) {
//        if image == nil {
//            if let url = URL(string: photoObj.returnImageURL()) {
////                CommonUtils().downloadImage(url: url, callback: { [weak self] (aImage) in
////                    guard let strongSelf = self else { return }
////                    if aImage != nil {
////                        strongSelf.imgView.image = aImage
////                        callback((aImage, photoObj.id))
////                    }
////                })
//                    self.imgView.downloadImage(url: url, callback: { [weak self] (aImage) in
//                    guard let strongSelf = self else { return }
//                    if aImage != nil {
//                        strongSelf.imgView.image = aImage
//                        callback((aImage, photoObj.id))
//                    }
//                })
//            } else {
//                callback((nil, photoObj.id))
//            }
//        } else {
//            self.imgView.image = image
//            callback(nil)
//        }
//    }
//
//    override func prepareForReuse() {
//        self.imgView.image = nil
//    }
//
//}

class GridCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imgView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.backgroundColor = UIColor.black
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.sd_setShowActivityIndicatorView(true)
        self.imgView.sd_setIndicatorStyle(.white)
    }

    override func prepareForReuse() {
        self.imgView.image = nil
    }

}

