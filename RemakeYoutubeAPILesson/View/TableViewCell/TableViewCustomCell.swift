//
//  TableViewCustomCell.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit

class TableViewCustomCell: UITableViewCell {

    
    @IBOutlet weak var thumbnailImageView: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    @IBOutlet weak var channelNameLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        thumbnailImageView.image = UIImage(named: "")
        videoTitleLabel.text = ""
        channelNameLabel.text = ""
    }
    
}
