//
//  LottieAnimation.swift
//  YoutubeAPILessonApp
//
//  Created by UrataHiroki on 2021/11/07.
//


import UIKit
import Lottie

extension UIViewController{
    
    func showAnimation(showContent:String?,animationTime:Double?,targetView:UIView,completion: @escaping (Bool) -> Void){
        
        guard let content = showContent else { completion(false); return }
        guard let time = animationTime else { completion(false); return }
        
        let underView = UIView(frame: CGRect(x: targetView.frame.maxX / 4, y: targetView.frame.maxY * 0.25, width: targetView.frame.width / 2, height: targetView.frame.width / 2))
        underView.layer.cornerRadius = 15.0
        underView.backgroundColor = .darkGray
        underView.alpha = 0.7
        targetView.addSubview(underView)
        
        let animationView = AnimationView()
        animationView.frame = CGRect(x: targetView.frame.maxX / 4, y: targetView.frame.maxY * 0.25, width: targetView.frame.width / 2, height: targetView.frame.width / 2)
        animationView.layer.cornerRadius = 15.0
        animationView.backgroundColor = .clear
        animationView.animation = Animation.named(content)
        animationView.contentMode = .scaleAspectFit
        animationView.loopMode = .loop
        animationView.play(completion: nil)
        targetView.addSubview(animationView)
    
        
        DispatchQueue.main.asyncAfter(deadline: .now() + time) {
            
            completion(true)
            animationView.stop()
            animationView.removeFromSuperview()
            underView.removeFromSuperview()
        }
    }
}

