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
    
    public let videoPlayer = YTPlayerView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        print("~~~~~~~~~~~カウントは\(videoPlayerView.subviews.count)~~~~~~~~~~~~")
        
        videoTitleLabel.text = videoTitle
        channelNameLabel.text = channelName
        descriptionTextView.text = descriptionText
        
        videoPlayer.frame = videoPlayerView.frame
        videoPlayer.load(withVideoId: playVideoID!, playerVars: ["playersinline":1])
        videoPlayerView.addSubview(videoPlayer)
        print("~~~~~~~~~~~カウントは\(videoPlayerView.subviews.count)~~~~~~~~~~~~")
        videoPlayer.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
}


extension VideoPlayerViewController:YTPlayerViewDelegate{
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        
        videoPlayer.playVideo()
    }
}


extension VideoPlayerViewController{
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        super.dismiss(animated: flag, completion: completion)
        
        guard let presentationController = presentationController else { return }
        
        presentationController.delegate?.presentationControllerDidDismiss?(presentationController)
    }
}
