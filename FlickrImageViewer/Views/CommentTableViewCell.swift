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
        self.selectionStyle = .none
        avatarImgView.contentMode = .scaleAspectFit
        avatarImgView.clipsToBounds = true
        avatarImgView.layer.cornerRadius = (UIScreen.main.bounds.size.width * 0.1)/2
        avatarImgView.layer.borderColor = UIColor.lightGray.cgColor
        avatarImgView.layer.borderWidth = 0.5
        avatarImgView.backgroundColor = UIColor.black
        avatarImgView.sd_setShowActivityIndicatorView(true)
        avatarImgView.sd_setIndicatorStyle(.white)
        
        userNameLbl.textColor = UIColor.blue
        userNameLbl.numberOfLines = 0
        commentLbl.delegate = self
        commentLbl.shouldDrawImages = false
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @objc fileprivate func linkButtonClicked(sender:DTLinkButton) {
        UIApplication.shared.open(sender.url, options: [:], completionHandler: nil)
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
    
    func attributedTextContentView(_ attributedTextContentView: DTAttributedTextContentView!, viewForLink url: URL!, identifier: String!, frame: CGRect) -> UIView! {
        let linkButton = DTLinkButton(frame: frame)
        linkButton.url = url
        linkButton.addTarget(self, action: #selector(CommentTableViewCell.linkButtonClicked(sender:)), for: .touchUpInside)
        return linkButton
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
