//
//  ViewController.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit
import SDWebImage

class TopVideosViewController: UIViewController {

    @IBOutlet weak var currentSituationLabel: UILabel!
    @IBOutlet weak var defaltSearchWordSettingButton: UIButton!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var topVideoTableView: UITableView!
    
    
    private let alamofireProess = AlamofireProcess()
    
    private var cellContentsArray = [VideoDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        topVideoTableView.register(UINib(nibName: "TableViewCustomCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCell")
        topVideoTableView.delegate = self
        topVideoTableView.dataSource = self
        //画面を開いた時に表示したい内容
        alamofireProess.getYoutubeDatas(searchKeyword: "五等分の花嫁") {[self] results, error, string in
            
            if error != nil || string != nil{
                
                return
            }
            
            showAnimation(showContent: "5", animationTime: 5, targetView: view) { judgeBool in
                
                if judgeBool == false{
                    
                    return
                }
                cellContentsArray = results!
                topVideoTableView.reloadData()
                
            }
        }
    }
    
}


extension TopVideosViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return tableView.frame.height / 2.3
    }
}


extension TopVideosViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellContentsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailCell", for: indexPath) as! TableViewCustomCell
        
        if cellContentsArray[indexPath.row].thumbnailImageURL == "nosign"{
            
            cell.thumbnailImageView.image = UIImage(systemName: "nosign")
        }else{
            
            cell.thumbnailImageView.sd_setImage(with: URL(string: cellContentsArray[indexPath.row].thumbnailImageURL!), completed: nil)
        }
        cell.videoTitleLabel.text = cellContentsArray[indexPath.row].title
        cell.channelNameLabel.text = cellContentsArray[indexPath.row].channelTitle
        
        return cell
    }
    
    
    
}
