//
//  Alert.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/08.
//

import UIKit

class Alert{
    
    private let defaultSearchKeyWord = UITextField()
}


extension Alert{
    
    public func warningAlert(alertContent:String,targetView:UIViewController){
        
        let alert = UIAlertController(title: "Error", message: alertContent, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        targetView.present(alert, animated: true, completion: nil)
    }
}


