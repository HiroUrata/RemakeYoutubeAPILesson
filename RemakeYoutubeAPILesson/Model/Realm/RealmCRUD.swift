//
//  RealmCRUD.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/11.
//

import RealmSwift

class RealmCRUD{
    
    private let alert = Alert()
    
    private var realmFavoriteVideoDetailArray:[[String:String]] = []
}

extension RealmCRUD{
    
    public func createFavoriteVideoData(tapCellContents:[VideoDetailDatas],tapCellNumber:Int?,targetView:UIViewController){
        
        guard let number = tapCellNumber else { return }
        
        do{
            
            let realm = try Realm()
            let realmFavoriteVideoDetailDatas = RealmFavoriteVideoDatas()
            
            realmFavoriteVideoDetailDatas.realmThumbnailImageURL = tapCellContents[number].thumbnailImageURL
            realmFavoriteVideoDetailDatas.realmTitle = tapCellContents[number].title
            realmFavoriteVideoDetailDatas.realmChannelTitle = tapCellContents[number].channelTitle
            realmFavoriteVideoDetailDatas.realmVideoPlayerContents = tapCellContents[number].videoPlayerContents?.description
            realmFavoriteVideoDetailDatas.realmDescription = tapCellContents[number].videoPlayerContents?.description
            
            try realm.write({
                
                realm.add(realmFavoriteVideoDetailDatas)
            })
            
        }catch{
            
            alert.warningAlert(alertContent: "データの保存に失敗しました。", targetView: targetView)
        }
    }
}



