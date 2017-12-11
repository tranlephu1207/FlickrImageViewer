//
//  CommentTableViewCell.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/10/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

class CommentTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarImgView: UIImageView!
    @IBOutlet weak var userNameLbl: UILabel!
    @IBOutlet weak var commentLbl: UILabel!
//    var textView:D
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        avatarImgView.contentMode = .scaleAspectFit
        avatarImgView.clipsToBounds = true
        
        userNameLbl.textColor = UIColor.blue
        commentLbl.numberOfLines = 0
        commentLbl.lineBreakMode = .byCharWrapping
        
//        DispatchQueue.main.async {
//            let attrStr = try! NSAttributedString(
//                data: (self.tex.data(using: String.Encoding.unicode, allowLossyConversion: true)!)!,
//                options: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
//                documentAttributes: nil)
//            
//            self.detailLabel.attributedText = attrStr
//            self.detailLabel.textAlignment = NSTextAlignment.justified
//            self.detailLabel.contentMode = .scaleToFill
//            self.detailLabel.font = UIFont(name: "PTSans-Narrow", size: 18.0)
//        }
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
