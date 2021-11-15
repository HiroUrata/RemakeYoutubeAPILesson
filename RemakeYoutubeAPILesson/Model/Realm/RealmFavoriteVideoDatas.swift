//
//  RealmFavoriteVideoDatas.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/11.
//

import RealmSwift

class RealmFavoriteVideoDatas:Object{
    
    @objc dynamic var realmThumbnailImageURL:String?
    @objc dynamic var realmTitle:String?
    @objc dynamic var realmChannelTitle:String?
    @objc dynamic var realmVideoPlayerContents:String?
    @objc dynamic var realmDescription:String?
}



