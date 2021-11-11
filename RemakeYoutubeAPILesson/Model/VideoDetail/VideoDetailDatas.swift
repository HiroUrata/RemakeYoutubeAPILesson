//
//  VideoDetailDatas.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//


struct VideoDetailDatas{
    
    let thumbnailImageURL:String?
    let title:String?
    let channelTitle:String?
    let videoPlayerContents:VideoPlayerContents?
}

struct VideoPlayerContents{
    
    let videoId:String?
    let description:String?
}
