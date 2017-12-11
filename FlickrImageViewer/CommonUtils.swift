//
//  CommonUtils.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/6/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

class CommonUtils:NSObject {
    
    //Downloading image
    private func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, callback: @escaping (_ image:UIImage?)->Void) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else {
                callback(nil)
                return
            }
            DispatchQueue.main.async() { () -> Void in
                let image = UIImage(data: data)
                callback(image)
            }
        }
    }
}
