//
//  ViewController.swift
//  WatanabeCallSystem
//
//  Created by Yuta Watanabe on 2016/11/22.
//  Copyright © 2016 渡辺優太. All rights reserved.
//

import UIKit
import SocketIO
import AudioToolbox

class ViewController: UIViewController {
    
    var socket: SocketIOClient! = nil
    var timer = Timer()
    var nowPlaying = false
    
    @IBOutlet weak var NAME: UILabel!
    @IBOutlet weak var Label: UILabel!
    @IBOutlet weak var MESSAGE: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let socket = appDelegete.socket
        
        socket?.on("toiPhone") {
            data, emitter in
            //            print("watayuz-iphone on -> \(data[0])")
            //            if let message = data[0] as? [String] {
            ////                print("on iphone -> \(message)")
            //                let name = message.index(of: "name")
            //                let msg = message.index(of: "message")
            //
            //                print("name -> \(name)   :::::  msg -> \(msg)")
            //            }
            if let message = data as? [String] {
                let jsonData: Data = message[0].data(using: String.Encoding.utf8)!
                do {
                    let parse = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSDictionary
                    self.NAME.text = parse.object(forKey: "name") as! String?
                    self.MESSAGE.text = parse.object(forKey: "message") as! String?
                    
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    
                    
//                    self.timer = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(self.vibrate(timer:)), userInfo: nil, repeats: true)
//                    self.timer.fire()
//                    
//                    
//                    self.nowPlaying = true
                    
                    //add Cell
                }catch let error as NSError {
                    print(error)
                }
            }
            
        }
    }
    
    func vibrate(timer: Timer) {
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

