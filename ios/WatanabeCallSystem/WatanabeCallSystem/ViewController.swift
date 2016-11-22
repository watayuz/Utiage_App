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
        
        let appDelegete = UIApplication.shared.delegate as! AppDelegate
        let socket = appDelegete.socket
        
        socket?.on("toiPhone") {
            data, emitter in
            
            if let message = data as? [String] {
                let jsonData: Data = message[0].data(using: String.Encoding.utf8)!
                do {
                    let parse = try JSONSerialization.jsonObject(with: jsonData as Data, options: .mutableContainers) as! NSDictionary
                    self.NAME.text = parse.object(forKey: "name") as! String?
                    self.MESSAGE.text = parse.object(forKey: "message") as! String?
                    
                    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate)
                    
                    // pop up
                    let alert = UIAlertController(title: self.NAME.text, message: self.MESSAGE.text, preferredStyle: .alert)
                    let OKAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil)
                    alert.addAction(OKAction)
                    self.present(alert, animated: true, completion: nil)
                    
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

