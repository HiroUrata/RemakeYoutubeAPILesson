//
//  Alert.swift
//  RemakeYoutubeAPILesson
//
//  Created by UrataHiroki on 2021/11/08.
//

import UIKit

class Alert{
    
    private let defaultSearchKeyWordInputTextField = UITextField()
}


extension Alert{
    
    public func warningAlert(alertContent:String,targetView:UIViewController){
        
        let alert = UIAlertController(title: "Error", message: alertContent, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        
        targetView.present(alert, animated: true, completion: nil)
    }
}

extension Alert{
    
    public func defaultSearchKeyWordChangeAlert(targetView:UIViewController){
        
        let alert = UIAlertController(title: "設定アラート", message: "アプリを起動した時に一覧に表示させる動画の検索キーワードを設定して下さい", preferredStyle: .alert)
        alert.addTextField { (searchKeywordInputTextField:UITextField) in
            
            searchKeywordInputTextField.placeholder = "検索キーワードを入力してください"
            self.defaultSearchKeyWordInputTextField.text = searchKeywordInputTextField.text
        }
        alert.addAction(UIAlertAction(title: "設定", style: .default, handler: { _ in
            
            if self.defaultSearchKeyWordInputTextField.text?.isEmpty != true{
                
                UserDefaults.standard.setValue(self.defaultSearchKeyWordInputTextField.text, forKey: "SearchKey")
            }
            
        }))
        
        alert.addAction(UIAlertAction(title: "キャンセル", style: .cancel, handler: nil))
        
        targetView.present(alert, animated: true, completion: nil)
    }
}

