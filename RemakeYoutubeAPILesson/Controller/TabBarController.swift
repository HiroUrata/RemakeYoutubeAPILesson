//
//  TabBarController.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/06.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()


        navigationItem.searchController = UISearchController()
        navigationItem.hidesSearchBarWhenScrolling = false
        
        tabBar.barTintColor = .systemRed
        tabBar.unselectedItemTintColor = .white
        tabBar.tintColor = .black
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
