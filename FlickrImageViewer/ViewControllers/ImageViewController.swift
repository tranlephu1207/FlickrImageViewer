//
//  ImageViewController.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/11/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {

    @IBOutlet weak var exitButton: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var image:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.black
        self.imgView.contentMode = .scaleAspectFill
        self.imgView.clipsToBounds = true
        if image != nil {
            self.imgView.image = image
        }
        
//        self.exitButton.imageView?.contentMode = .scaleAspectFill
        self.exitButton.contentMode = .scaleAspectFill
        self.exitButton.contentHorizontalAlignment = .fill
        self.exitButton.contentVerticalAlignment = .fill
    }

    @IBAction func exitBtnDidTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
