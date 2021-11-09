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
    private let alert = Alert()
    
    private var cellContentsArray = [VideoDetailDatas]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        searchResultTableView.register(UINib(nibName: "TableViewCustomCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCell")
        searchResultTableView.delegate = self
        searchResultTableView.dataSource = self
        
        //画面を開いた時に表示したい内容
        alamofireProess.getYoutubeDatas(searchKeyword: "五等分の花嫁") {[self] results, error, string in
            
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
