//
//  ImageDetailViewController.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/7/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit
import DTCoreText

class ImageDetailViewController: UIViewController {

    @IBAction func exitBtn(_ sender: Any) {
    }
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var noCommentLbl: UILabel!
    
    var photoObj:ImageModel!
    var usernameString:String = "" {
        didSet {
            if userNameLbl != nil {
                userNameLbl.text = usernameString
            }
        }
    }
    var attrContent:[Int:NSAttributedString] = [:]
    var commentObjs:[CommentModel] = []
    
    var image:UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let nib = UINib(nibName: "CommentTableViewCell", bundle: nil)
        self.tblView.register(nib, forCellReuseIdentifier: "commentCell")
        self.tblView.delegate = self
        self.tblView.dataSource = self
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(ImageDetailViewController.imageViewDidTapped(sender:)))
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(tapGesture)
        
        userNameLbl.text = "Comments"
        if photoObj != nil {

            imageView.downloadImage(url: URL(string: photoObj.returnImageURL())!, callback: { [weak self] (aImage) in
                self?.image = aImage
            })
            self.callUsernameAPI()
            self.callCommentsAPI()
        }
        
        self.noCommentLbl.textAlignment = .center
        self.noCommentLbl.font = UIFont(name: "Helvetica", size: 17)
        self.noCommentLbl.text = "NO COMMENT"
        self.noCommentLbl.isHidden = true
    }
    
    @objc fileprivate func imageViewDidTapped(sender:Any) {
        if image != nil {
            let VC = storyboard?.instantiateViewController(withIdentifier: "ImageVC") as! ImageViewController
            VC.image = self.image
            VC.modalTransitionStyle = .crossDissolve
            self.navigationController?.present(VC, animated: true, completion: nil)
        }
    }
    
    fileprivate func callUsernameAPI() {
        let urlString = String(format: "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&format=json&user_id=%@&method=flickr.people.getinfo&nojsoncallback=1", arguments: [self.photoObj.owner])
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    self.showAlertVC()
                }
                if let data = data, let json = try! JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) as? Dictionary<String, Any> {
                    print(json)
                    if (json["stat"] as? String) == "ok" {
                        if let photosJSON = json["person"] as? Dictionary<String,Any> {
                            if let usernameJSON = photosJSON["username"] as? Dictionary<String,Any> {
                                DispatchQueue.main.async {
                                    self.title = usernameJSON["_content"] as? String ?? ""
                                }
                            }
                        }
                    } else {
                        self.showAlertVC()
                    }
                }
            }).resume()
        }
    }
    
    fileprivate func callCommentsAPI() {
        let urlString = String(format: "https://api.flickr.com/services/rest/?api_key=9e74634ccde37b17af042f0aa48a886d&format=json&photo_id=%@&method=flickr.photos.comments.getlist&nojsoncallback=1", arguments: [self.photoObj.id])
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            URLSession.shared.dataTask(with: request, completionHandler: { (data, response, error) in
                if error != nil {
                    self.showAlertVC()
                }
                if let data = data, let json = try! JSONSerialization.jsonObject(with: data, options: [JSONSerialization.ReadingOptions.allowFragments]) as? Dictionary<String, Any> {
                    print(json)
                    if (json["stat"] as? String) == "ok" {
                        if let commentsJSON = json["comments"] as? Dictionary<String,Any> {
                            if let commentJSON = commentsJSON["comment"] as? [Dictionary<String,Any>] {
                                for aComment in commentJSON {
                                    let commentObj = CommentModel(json: aComment)
                                    self.commentObjs.append(commentObj)
                                }
                                DispatchQueue.main.async {
                                    if self.commentObjs.isEmpty {
                                        self.noCommentLbl.isHidden = false
                                       self.tblView.isHidden = true
                                    } else {
                                        self.tblView.reloadData()
                                    }
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.tblView.isHidden = true
                                    self.noCommentLbl.isHidden = false
                                }
                            }
                        }
                    } else {
                        self.showAlertVC()
                    }
                }
            }).resume()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
//        tblView.estimatedRowHeight = 35
        tblView.rowHeight = UITableViewAutomaticDimension
        tblView.backgroundColor = UIColor.clear
        tblView.setNeedsLayout()
        tblView.layoutIfNeeded()
    }
    
    fileprivate func showAlertVC() {
        let alertView = UIAlertController(title: "Flickr Image Viewer", message: "Could not load images", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: { (action) in
            alertView.dismiss(animated: true, completion: nil)
        })
        alertView.addAction(action)
        self.navigationController?.present(alertView, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ImageDetailViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.commentObjs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "commentCell", for: indexPath) as! CommentTableViewCell
        cell.tag = indexPath.row
        if cell.tag == indexPath.row {
            let commentObj = self.commentObjs[indexPath.row]
            if let attrContent = self.attrContent[indexPath.row] {
                cell.commentLbl.attributedString = attrContent
                cell.commentLbl.relayoutText()
            } else {
                DispatchQueue.global().async {
                    let builderOptions = [DTDefaultFontFamily:"Helvetica", NSAttributedString.DocumentAttributeKey.documentType: NSAttributedString.DocumentType.html,
                                          NSAttributedString.DocumentAttributeKey.characterEncoding: String.Encoding.utf8, DTDefaultFontSize: 13] as [AnyHashable : Any]
                    let dataStr = commentObj.content.replacingOccurrences(of: "\n", with: "<br/>")
                    let data = dataStr.data(using: String.Encoding.utf8, allowLossyConversion: true)!
                    let stringbuilder = DTHTMLAttributedStringBuilder(html: data, options: builderOptions, documentAttributes: nil)
                    let attrStr = stringbuilder?.generatedAttributedString()
                    DispatchQueue.main.async {
                        if cell.tag == indexPath.row {
                            self.attrContent[indexPath.row] = attrStr
                            cell.commentLbl.attributedString = attrStr
                            cell.commentLbl.layouter = nil
                            cell.commentLbl.relayoutText()
                            tableView.reloadData()
                        }
                    }
                }
            }
            cell.userNameLbl.text = commentObj.authorName
            if let url = URL(string: commentObj.returnImageURL()) {
                cell.avatarImgView.downloadImage(url: url, callback: { (image) in
                    
                })
            }
        }
        return cell
    }
}
