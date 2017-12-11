//
//  Models.swift
//  FlickrImageViewer
//
//  Created by Tran Le Phu on 12/6/17.
//  Copyright © 2017 Tran Le Phu. All rights reserved.
//

import UIKit

class ImageModel:NSObject {
    var id:String!
    var owner:String!
    var secret:String!
    var server:String!
    var farm:Int!
    var title:String!
    var isPublic:Int!
    var isFriend:Int!
    var isFamily:Int!
    
    init(json:Dictionary<String,Any>) {
        self.id = json["id"] as? String ?? ""
        self.owner = json["owner"] as? String ?? ""
        self.secret = json["secret"] as? String ?? ""
        self.server = json["server"] as? String ?? ""
        self.farm = json["farm"] as? Int ?? -1
        self.title = json["title"] as? String ?? ""
        self.isPublic = json["isPublic"] as? Int ?? -1
        self.isFamily = json["isFamily"] as? Int ?? -1
        super.init()
    }
    
    func returnImageURL()->String {
        return String(format: "https://farm%d.staticflickr.com/%@/%@_%@.jpg", arguments: [self.farm, self.server, self.id, self.secret])
    }
}

class CommentModel:NSObject {
    var id:String!
    var author:String!
    var authorIsDeleted:String!
    var authorName:String!
    var iconServer:String!
    var iconFarm:Int!
    var dateCreate:String!
    var permalink:String!
    var pathAlias:String!
    var realname:String!
    var content:String!
    
    init(json:Dictionary<String,Any>) {
        self.id = json["id"] as? String ?? ""
        self.author = json["author"] as? String ?? ""
        self.authorIsDeleted = json["author_is_deleted"] as? String ?? ""
        self.authorName = json["authorname"] as? String ?? ""
        self.iconServer = json["iconserver"] as? String ?? ""
        self.iconFarm = json["iconfarm"] as? Int ?? -1
        self.dateCreate = json["datecreate"] as? String ?? ""
        self.permalink = json["permalink"] as? String ?? ""
        self.pathAlias = json["path_alias"] as? String ?? ""
        self.realname = json["realname"] as? String ?? ""
        self.content = json["_content"] as? String ?? ""
        super.init()
    }
    
    func returnImageURL()->String {
//        return String(format: "https://farm%d.staticflickr.com/%@/%@.jpg", arguments: [self.iconFarm, self.iconServer, self.id])
        return String(format: "https://farm%d.staticflickr.com/%@/buddyicons/%@.jpg", arguments: [self.iconFarm, self.iconServer, self.author])
    }
}
