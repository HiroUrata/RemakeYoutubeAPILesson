//
//  TopVideosViewController.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/09.
//

import UIKit
import SDWebImage

class TopVideosViewController: UIViewController {

    @IBOutlet weak var nowSituationLabel: UILabel!
    @IBOutlet weak var searchKeyTextfield: UITextField!
    @IBOutlet weak var videoSearchButton: UIButton!
    @IBOutlet weak var searchResultTableView: UITableView!
    
    private let alamofireProess = AlamofireProcess()
    private let realmCRUD = RealmCRUD()
    private let alert = Alert()
    
    private var cellContentsArray = [VideoDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.register(UINib(nibName: "TableViewCustomCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCell")
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
            
            //画面を開いた時に表示したい内容
        alamofireProess.getYoutubeDatas(searchKeyword: realmCRUD.readSearchDefaultKey()) {[self] results, error, string in
                
                if error != nil || string != nil{
                    
                    alert.warningAlert(alertContent: string!, targetView: self)
                    return
                }
                
                showAnimation(showContent: "5", animationTime: 5, targetView: view) { judgeBool in
                    
                    if judgeBool == false{
                        
                        return
                    }
                    
                    cellContentsArray = results!
                    searchResultTableView.reloadData()
                }
            }
        }
        
    

    @IBAction func defaultSearchKeySetting(_ sender: UIButton) {
        
        alert.defaultSearchKeyWordChangeAlert(targetView: self)
    }
    
    
    @IBAction func videoSearch(_ sender: UIButton) {
        
        if searchKeyTextfield.text?.isEmpty != true{
            
            alamofireProess.getYoutubeDatas(searchKeyword: searchKeyTextfield.text) {[self] results, error, string in
                
                if error != nil || string != nil{
                    
                    alert.warningAlert(alertContent: string!, targetView: self)
                    return
                }
                
                showAnimation(showContent: "5", animationTime: 5, targetView: view) { judgeBool in
                    
                    if judgeBool == false{
                        
                        return
                    }
                    cellContentsArray = results!
                    searchResultTableView.reloadData()
                    
                }
            }
        }
        
    }
    
}


extension TopVideosViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 2.3
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        sendVideoDetailData(detailDatas: cellContentsArray, detailCount: indexPath.row, selectCell: tableView.cellForRow(at: indexPath) as! TableViewCustomCell)
    }
}


extension TopVideosViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailCell", for: indexPath) as! TableViewCustomCell
        
        if cellContentsArray[indexPath.row].thumbnailImageURL != "nosign"{
            
            cell.thumbnailImageView.sd_setImage(with: URL(string: cellContentsArray[indexPath.row].thumbnailImageURL!), completed: nil)
        }else{
            
            cell.thumbnailImageView.image = UIImage(systemName: "nosign")
        }
        cell.videoTitleLabel.text = cellContentsArray[indexPath.row].title
        cell.channelNameLabel.text = cellContentsArray[indexPath.row].channelTitle
        
        return cell
    }
}


extension TopVideosViewController:UIAdaptivePresentationControllerDelegate{
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.videoPlayer.removeFromSuperview()
        
        
        
    }
    
}


extension TopVideosViewController{
    
    func sendVideoDetailData(detailDatas:[VideoDetailDatas],detailCount:Int,selectCell:TableViewCustomCell){
        
        let videoPlayerVC = VideoPlayerViewController()
        videoPlayerVC.modalPresentationStyle = .automatic
        videoPlayerVC.presentationController?.delegate = self
        videoPlayerVC.playVideoID = detailDatas[detailCount].videoPlayerContents?.videoId
        videoPlayerVC.videoTitle = selectCell.videoTitleLabel.text
        videoPlayerVC.channelName = selectCell.channelNameLabel.text
        videoPlayerVC.descriptionText = detailDatas[detailCount].videoPlayerContents?.description
        self.present(videoPlayerVC, animated: true, completion: nil)
    }
}



