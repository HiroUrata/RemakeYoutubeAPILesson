//
//  VideoPlayerViewController.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/09.
//

import UIKit
import youtube_ios_player_helper

class VideoPlayerViewController: UIViewController {

    
    @IBOutlet weak var videoPlayerView: UIView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    public var playVideoID:String?
    public var videoTitle:String?
    public var channelName:String?
    public var descriptionText:String?
    
    private let videoPlayer = YTPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        videoTitleLabel.text = videoTitle
        channelNameLabel.text = channelName
        descriptionTextView.text = descriptionText
        
        videoPlayer.frame = videoPlayerView.frame
        videoPlayer.load(withVideoId: playVideoID!, playerVars: ["playersinline":1])
        videoPlayerView.addSubview(videoPlayer)
        
        videoPlayer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    @IBAction func stop(_ sender: Any) {
        
        videoPlayer.stopVideo()
    }
    
}


extension VideoPlayerViewController:YTPlayerViewDelegate{
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        videoPlayer.playVideo()
    }
}
