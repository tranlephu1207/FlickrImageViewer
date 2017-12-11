//
//  CommentTableViewCell.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/10/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit
import DTCoreText

class CommentTableViewCell: UITableViewCell, DTAttributedTextContentViewDelegate, DTLazyImageViewDelegate {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var commentLbl: DTAttributedTextContentView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImgView.contentMode = .scaleAspectFit
        avatarImgView.clipsToBounds = true
        
        userNameLbl.textColor = UIColor.blue
        userNameLbl.numberOfLines = 0
        commentLbl.delegate = self
        commentLbl.shouldDrawImages = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewFor attachment: DTTextAttachment!, frame: CGRect) -> UIView! {
        if attachment is DTImageTextAttachment {
            let imageView = DTLazyImageView(frame: frame)
            imageView.delegate = self
            //url for deferred loading
            imageView.url = attachment.contentURL
            imageView.shouldShowProgressiveDownload = true
            return imageView
        }
        return nil
    }
    
    func lazyImageView(_ lazyImageView: DTLazyImageView!, didChangeImageSize size: CGSize) {
        let url = lazyImageView.url
        let pred = NSPredicate(format: "contentURL == %@",url! as CVarArg)
        
        let array = self.commentLbl.layoutFrame.textAttachments(with: pred)
        
        for _ in (array?.enumerated())! {
            let element = DTTextAttachment()
            element.originalSize = size
            element.displaySize = size
        }
        DispatchQueue.main.async {
            self.commentLbl.layouter = nil
            self.commentLbl.relayoutText()
        }
    }
}
