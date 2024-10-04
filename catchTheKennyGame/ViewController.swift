//
//  ViewController.swift
//  catchTheKennyGame
//
//  Created by neodiyadin on 10.08.2024.
//

import UIKit

class ViewController: UIViewController {
    
    //veriable
    var score = 0
    var timer = Timer()
    var counter = 0
    var kennyarry = [UIImageView] ()
    var hidetimer = Timer()
    var highscore = 0
    
    
    //views
    @IBOutlet weak var timelabel: UILabel!
    @IBOutlet weak var scorelabel: UILabel!
    @IBOutlet weak var highscorelabel: UILabel!
    
    @IBOutlet weak var kenny1: UIImageView!
    @IBOutlet weak var kenny2: UIImageView!
    @IBOutlet weak var kenny3: UIImageView!
    @IBOutlet weak var kenny4: UIImageView!
    @IBOutlet weak var kenny5: UIImageView!
    @IBOutlet weak var kenny6: UIImageView!
    @IBOutlet weak var kenny7: UIImageView!
    @IBOutlet weak var kenny8: UIImageView!
    @IBOutlet weak var kenny9: UIImageView!
    
    @IBOutlet weak var ramo: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        scorelabel.text = "score: \(score)"
        
        //high scrore check
        let storedHighscore = UserDefaults.standard.object(forKey: "highscore")
        
        if storedHighscore == nil {
            highscore = 0
            highscorelabel.text = "highscore: \(highscore)"
        }
        
        if let newscore = storedHighscore as? Int {
            highscore = newscore
            highscorelabel.text = "highscore: \(highscore)"
        }
        
        //images
        kenny1.isUserInteractionEnabled = true
        kenny2.isUserInteractionEnabled = true
        kenny3.isUserInteractionEnabled = true
        kenny4.isUserInteractionEnabled = true
        kenny5.isUserInteractionEnabled = true
        kenny6.isUserInteractionEnabled = true
        kenny7.isUserInteractionEnabled = true
        kenny8.isUserInteractionEnabled = true
        kenny9.isUserInteractionEnabled = true
        
        
        let recognizer1 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer2 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer3 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer4 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer5 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer6 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer7 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer8 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        let recognizer9 = UITapGestureRecognizer(target: self, action: #selector(increasescore))
        
        kenny1.addGestureRecognizer(recognizer1)
        kenny2.addGestureRecognizer(recognizer2)
        kenny3.addGestureRecognizer(recognizer3)
        kenny4.addGestureRecognizer(recognizer4)
        kenny5.addGestureRecognizer(recognizer5)
        kenny6.addGestureRecognizer(recognizer6)
        kenny7.addGestureRecognizer(recognizer7)
        kenny8.addGestureRecognizer(recognizer8)
        kenny9.addGestureRecognizer(recognizer9)
        
        kennyarry = [kenny1, kenny2, kenny3, kenny4, kenny5, kenny6, kenny7, kenny8, kenny9]
        
        
        //timer
        counter = 16
        timelabel.text = "\(counter)"
        
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(countdown), userInfo: nil, repeats: true)
        hidetimer = Timer.scheduledTimer(timeInterval: 0.9, target: self, selector: #selector(hidekenny), userInfo: nil, repeats: true)
        hidekenny()
        
    }
    
    @objc func hidekenny(){
        for kenny in kennyarry{
            kenny.isHidden = true
        }
        var oldRandom = 0
        var random = Int(arc4random_uniform(UInt32(kennyarry.count - 1)))
        
        
        
        
        if random == oldRandom {
            random += 1
            
        } else {
            oldRandom = random
        }
        
        ramo.text = "\(random)"
        
        kennyarry[random].isHidden = false
        
    }
    
    @objc func increasescore(){
        score += 1
        scorelabel.text = "score: \(score)"
        
    }
    
    @objc func countdown(){
        counter -= 1
        timelabel.text = "\(counter)"
        
        if counter == 0 {
            timer.invalidate()
            hidetimer.invalidate()
            
            for kenny in kennyarry{
                kenny.isHidden = true
            }
            
            if self.score > self.highscore {
                self.highscore = self.score
                highscorelabel.text = "high score: \(self.highscore)"
                UserDefaults.standard.set(self.highscore, forKey: "highscore")
            }
            
            //alert
            let alert = UIAlertController(title: "times up", message: "do you want to play again", preferredStyle: UIAlertController.Style.alert)
            let okbutton = UIAlertAction(title: "OK", style: UIAlertAction.Style.cancel, handler: nil)
            let replaybutton = UIAlertAction(title: "replay", style: UIAlertAction.Style.default) {
                (UIAlertAction) in
                //replay function
                self.score = 0
                self.scorelabel.text = "score: \(self.score)"
                self.counter = 16
                self.timelabel.text = String(self.counter)
                
                self.timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countdown), userInfo: nil, repeats: true)
                self.hidetimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.hidekenny), userInfo: nil, repeats: true)
                
            }
            
            alert.addAction(okbutton)
            alert.addAction(replaybutton)
            self.present(alert, animated: true, completion: nil)
            
            
        }
        
    }

}


