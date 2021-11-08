//
//  AlamofireProcess.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/07.
//

import Alamofire
import SwiftyJSON

class AlamofireProcess{
    
    private var privateThumbnailImageURL:String?
    private var privateTitle:String?
    private var privateChannelTitle:String?
    
    private var privateVideoDetailArray = [VideoDetailDatas]()
}


extension AlamofireProcess{
    
    public func getYoutubeDatas(searchKeyword:String?,completion: @escaping ([VideoDetailDatas]?,Error?,String?) -> Void){
        
        guard let keyword = searchKeyword else {completion(nil, nil,"検索したい事を入力して下さい"); return }
        
        let apikey = "APIKey"
        
        AF.request(apikey, method: .get, parameters: nil, encoding: JSONEncoding.default).responseJSON {[self] response in
            
            switch response.result{
            
            case .success:
                
                privateVideoDetailArray = []
                
                let detailDatas = JSON(response.data as Any)
                print(detailDatas)
                
                for dataCount in 0..<detailDatas["items"].count{
                    
                    getDatasNilCheck(getImageURL: detailDatas["items"][dataCount]["snippet"]["thumbnails"]["medium"]["url"].string,
                                     getTitle: detailDatas["items"][dataCount]["snippet"]["title"].string,
                                     getChannelTitle: detailDatas["items"][dataCount]["snippet"]["channelTitle"].string)
                    
                    if detailDatas["items"][dataCount]["id"]["channelId"].string != privateChannelTitle{
                        
                        privateVideoDetailArray.append(VideoDetailDatas(thumbnailImageURL:privateThumbnailImageURL,
                                                                        title: privateTitle,
                                                                        channelTitle: privateChannelTitle))
                        print(privateThumbnailImageURL as Any) //テスト
                        print(privateTitle as Any)//テスト
                        print(privateChannelTitle as Any)//テスト
                    }
                }
                completion(privateVideoDetailArray, nil, nil)
                
            case .failure(let error):
                
                completion(nil, error, "データが取得出来ませんでした")
            }
        }
    }
}


extension AlamofireProcess{
    
    private func getDatasNilCheck(getImageURL:String?,getTitle:String?,getChannelTitle:String?){
        
        if getImageURL != nil{
            
            privateThumbnailImageURL = getImageURL
        }else{
            
            privateThumbnailImageURL = "nosign" //systemName
        }
        
        if getTitle != nil{
            
            privateTitle = getTitle
        }else{
            
            privateTitle = "読み込みエラー"
        }
        
        if getChannelTitle != nil{
            
            privateChannelTitle = getChannelTitle
        }else{
            
            privateChannelTitle = "読み込みエラー"
        }
    }
}

extension String{
    
    var urlEncoded:String{
        
        let charset = CharacterSet.alphanumerics.union(.init(charactersIn: "/?-._~"))
        let remove = removingPercentEncoding ?? self
        
        return remove.addingPercentEncoding(withAllowedCharacters: charset) ?? remove
    }
}
