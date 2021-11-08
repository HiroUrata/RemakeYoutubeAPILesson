//
//  MyFavoriteViewController.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit
import SDWebImage

class MyFavoriteViewController: UIViewController {

    
    @IBOutlet weak var myFavoriteTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        myFavoriteTableView.register(UINib(nibName: "TableViewCustomCell", bundle: nil), forCellReuseIdentifier: "VideoDetailCell")
        myFavoriteTableView.delegate = self
        myFavoriteTableView.dataSource = self
        
    }

}


extension MyFavoriteViewController:UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        tableView.frame.height / 2.7
    }
}

extension MyFavoriteViewController:UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 30
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoDetailCell", for: indexPath) as! TableViewCustomCell
        
        cell.thumbnailImageView.image = UIImage(named: "youtubeImage") //あとで変更
        cell.videoTitleLabel.text = "タイトルが入る" //あとで変更
        cell.channelNameLabel.text = "チャンネル名が入る"
        
        return cell
    }
}
