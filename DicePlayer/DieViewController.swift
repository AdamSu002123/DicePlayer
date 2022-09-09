//
//  ViewController.swift
//  DicePlayer
//
//  Created by gih96984 on 2022/8/25.
//

import UIKit

class DieViewController: UIViewController {

    @IBOutlet var playerDiceImageView: [UIImageView]!
    @IBOutlet var computerDiceImageView: [UIImageView]!
    @IBOutlet weak var playerSumLabel: UILabel!
    @IBOutlet weak var computerSumLabel: UILabel!
    @IBOutlet weak var cashLabel: UILabel!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!
    
    var playerSum = 2
    var computerSum = 2
    var money = 200
   
    let gradient = CAGradientLayer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cashLabel.text = "餘額:\(money)"
        
        gradient.frame = imageView.bounds
        
        gradient.colors = [UIColor.white.cgColor, UIColor.clear.cgColor,  UIColor.clear.cgColor, CGColor(srgbRed: 0.33, green: 0.29, blue: 0.19, alpha: 1.0)]
                
                gradient.locations = [0, 0.5, 0.8, 1]
                
                imageView.layer.addSublayer(gradient)
                
    }
    
    func set()
    {
        let title: String
        let notice: String
        
        if money > 0
        {
            
            title = "還要繼續嗎?"
            notice = "愛拚才會贏喔👇(沒錢或欠債只能QQ)"
            if playerSum > computerSum
            {
                resultLabel.text = "贏你啦"
                money += 50
                
            }else if playerSum == computerSum{
                
                resultLabel.text = "很遺憾，既生瑜，何生亮"
                money -= 150
            }else{
                
                resultLabel.text = "小朋友你這100元已經輸囉"
                money -= 100
            }
            cashLabel.text = "餘額:\(money)"
        }else{
            resultLabel.text = "Game Over"
            title = "It's over"
            notice = "破產了"
            playButton.setTitle("重新開始", for: .normal)
        }
        
    
        let controller = UIAlertController(title: title, message: notice, preferredStyle: .alert)
        
        if money <= 0{
        let qqAction = UIAlertAction(title: "QQ", style: .default)
            controller.addAction(qqAction)
            }else if money > 0 {
        let okAction = UIAlertAction(title: "好了", style:.default)
            controller.addAction(okAction)
        let replayAction = UIAlertAction(title: "再來", style: .default) { _ in
            self.set()
            }
            controller.addAction(replayAction)
        }
        present(controller, animated: true)
        
        playerSum = 0
        for i in 0..<playerDiceImageView.count{
            let number = Int.random(in: 1...6)
            playerSum += number
            playerDiceImageView[i].image = UIImage(systemName: "die.face.\(number).fill")
        }
            playerSumLabel.text = "\(playerSum)"
        
        computerSum = 0
        for i in 0..<computerDiceImageView.count{
            let number = Int.random(in: 1...6)
            computerSum += number
            computerDiceImageView[i].image = UIImage(systemName: "die.face.\(number).fill")
        }
            computerSumLabel.text = "\(computerSum)"
    }
    
    func restart()
    {
        playButton.setTitle("開始", for: .normal)
        money = 200
        cashLabel.text = "餘額:\(money)"
        resultLabel.text = ""
        for playerDiceImageView in playerDiceImageView
        {
            playerDiceImageView.image = UIImage(systemName: "die.face.1.fill")
        }
        for computerDiceImageView in computerDiceImageView
        {
            computerDiceImageView.image = UIImage(systemName: "die.face.1")
        }
        playerSumLabel.text = "點數總和"
        computerSumLabel.text = "點數總和"
    }

    
    @IBAction func play(_ sender: Any)
    {
        if playButton.currentTitle == "開始" {
            set()
        } else {
            restart()
        }
      //  set()
    }
    
}
    
    
    
    
    
