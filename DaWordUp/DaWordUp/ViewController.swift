//
//  ViewController.swift
//  DaWordUp
//
//  Created by Dameion on 1/24/23.
//

import UIKit
import AVKit

class ViewController: UIViewController {

    var videoPlayer: AVQueuePlayer!//add 'Queue' to the AVPlayer made it loop
    var videoPlayerLayer: AVPlayerLayer?
    var videoPlayerLooper: AVPlayerLooper?
    
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpElements()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //video Background
        setUpVideo()
    }
    
    func setUpElements(){
        
        Utilities.styleFilledButton(signUpButton)
        Utilities.styleHollowButton(loginButton)
    }
    
    func setUpVideo(){
        //Create the Path
        let bundlePath = Bundle.main.path(forResource:"video_WebTitle_batch", ofType: "mp4")
        guard bundlePath != nil else { return }
        //Create the URL
        let url = URL(fileURLWithPath: bundlePath!)
        //Create the player item
        let item = AVPlayerItem(url: url)
        //Create the player
        videoPlayer = AVQueuePlayer(playerItem: item) //add 'Queue' to the AVPlayer made it loop
        //Create the layer
        videoPlayerLayer = AVPlayerLayer(player: videoPlayer!)
        //Create the size n frame
        videoPlayerLayer?.frame = CGRect(x: -self.view.frame.size.width*1.5, y: 0, width: self.view.frame.size.width*4, height: self.view.frame.size.height)
        view.layer.insertSublayer(videoPlayerLayer!, at: 0)
        //Create the experience
        videoPlayerLooper = AVPlayerLooper(player: videoPlayer, templateItem: item)
        
        videoPlayer?.playImmediately(atRate: 1.0)
    }
    
    
}

