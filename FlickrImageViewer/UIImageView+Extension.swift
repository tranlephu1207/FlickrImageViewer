//
//  UIImageView+Extension.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/6/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit
import SDWebImage


public extension UIImageView {
    func downloadImage(url:URL, callback:@escaping (_ image:UIImage?)->Void) {
        sd_setImage(with: url, placeholderImage: nil, options: [SDWebImageOptions.scaleDownLargeImages, .retryFailed, .refreshCached, .highPriority, .continueInBackground, .cacheMemoryOnly], progress: { [weak self] (receivedSize, expectedSize, aURL) in
        }) { [weak self] (aImage, error, cacheType, bURL) in
            if error != nil {
                callback(nil)
            }
        }
    }
}
