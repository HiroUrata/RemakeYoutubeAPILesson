//
//  RealmCRUD.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/11.
//

import RealmSwift

class RealmCRUD{
    
    private let alert = Alert()
    
    private var realmFavoriteVideoDetailArray:[[String:String?]] = []
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


extension RealmCRUD{
    
    public func readFavoriteVideoData(targetView:UIViewController,completion: ([[String:String?]]?,Error?) -> Void){
        
        do{
            
            let realm = try Realm()
            
            realmFavoriteVideoDetailArray = []
            
            realm.objects(RealmFavoriteVideoDatas.self).forEach { response in
                
                realmFavoriteVideoDetailArray.append(["realmThumbnailImageURL":response.realmThumbnailImageURL,
                                                      "realmTitle":response.realmTitle,
                                                      "realmChannelTitle":response.realmChannelTitle,
                                                      "realmVideoPlayerContents":response.realmVideoPlayerContents,
                                                      "realmDescription":response.realmDescription])
            }
            completion(realmFavoriteVideoDetailArray, nil)
            
        }catch{
            completion(nil, error)
            alert.warningAlert(alertContent: "データの取得に失敗しました。", targetView: targetView)
        }
    }
}

