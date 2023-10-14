//
//  ViewController.swift
//  RockPaperScissors
//
//  Created by Сергей Киселев on 14.10.2023.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let labelScore = UILabel()
    let robotButton = UIButton()
    let statusLabel = UILabel()
    let rockButton = UIButton(type: .system)
    let paperButton = UIButton(type: .system)
    let scissorsButton = UIButton(type: .system)
    let resetButton = UIButton(type: .system)
    let ratingButton = UIButton(type: .system)
    
    let defaults = UserDefaults.standard
    
    var scoreUser = 0
    var scoreRobot = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
    }
    
    private func initialize() {
        view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 230/255, alpha: 1)
        
        labelScore.text = "\(scoreRobot):\(scoreUser)"
        labelScore.textColor = UIColor.black
        labelScore.font = UIFont.systemFont(ofSize: 30)
        
        robotButton.setTitle("🤖", for: .normal)
        robotButton.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        
        statusLabel.text = "Rock, Paper, Scissors?"
        statusLabel.textColor = UIColor.black
        statusLabel.font = UIFont.systemFont(ofSize: 21)
        
        rockButton.setTitle("🪨", for: .normal)
        rockButton.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        
        paperButton.setTitle("📜", for: .normal)
        paperButton.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        
        scissorsButton.setTitle("✂️", for: .normal)
        scissorsButton.titleLabel?.font = UIFont.systemFont(ofSize: 70)
        
        resetButton.setTitle("Play again", for: .normal)
        resetButton.setTitleColor(UIColor.black, for: .normal)
        resetButton.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        resetButton.isHidden = true
        
        ratingButton.setImage(UIImage(systemName: "trophy.fill"), for: .normal)
        ratingButton.tintColor = UIColor.black
        ratingButton.addTarget(self, action: #selector(ratingButtonTapped), for: .touchUpInside)
        
        view.addSubview(labelScore)
        labelScore.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(150)
        }
        
        view.addSubview(robotButton)
        robotButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelScore).inset(100)
        }
        
        view.addSubview(statusLabel)
        statusLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(robotButton).inset(120)
        }
        
        view.addSubview(rockButton)
        rockButton.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(1.0 / 3.0)
            make.leading.equalToSuperview()
            make.top.equalTo(statusLabel).inset(100)
            make.height.equalTo(50)
        }
        
        rockButton.addTarget(self, action: #selector(rockButtonTapped), for: .touchUpInside)

        view.addSubview(paperButton)
        paperButton.snp.makeConstraints { make in
           make.width.top.height.equalTo(rockButton)
           make.leading.equalTo(rockButton.snp.trailing)
        }

        paperButton.addTarget(self, action: #selector(paperButtonTapped), for: .touchUpInside)
        
        view.addSubview(scissorsButton)
        scissorsButton.snp.makeConstraints { make in
           make.width.top.height.equalTo(rockButton)
           make.leading.equalTo(paperButton.snp.trailing)
           make.trailing.equalToSuperview()
        }
        
        scissorsButton.addTarget(self, action: #selector(scissorsButtonTapped), for: .touchUpInside)
        
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rockButton).inset(100)
        }
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
        view.addSubview(ratingButton)
        ratingButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(100)
        }
    }
    
    @objc func resetButtonTapped() {
        
        labelScore.text = "\(scoreRobot):\(scoreUser)"
        robotButton.setTitle("🤖", for: .normal)
        
        statusLabel.text = "Rock, Paper, Scissors?"
        self.view.backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 230/255, alpha: 1)
        
        rockButton.isHidden = false
        paperButton.isHidden = false
        scissorsButton.isHidden = false
        resetButton.isHidden = false
        
        rockButton.isUserInteractionEnabled = true
        paperButton.isUserInteractionEnabled = true
        scissorsButton.isUserInteractionEnabled = true
        
        resetButton.isHidden = true
     }
    
    @objc private func rockButtonTapped() {
        play(.rock)
    }
    
    @objc private func paperButtonTapped() {
        play(.paper)
    }
    
    @objc private func scissorsButtonTapped() {
        play(.scissors)
    }
    
    
    private func play(_ sign: Sign) {
        let computerSign = randomSign()
        robotButton.setTitle(computerSign.emoji, for: .normal)
        
        switch sign {
        case .rock:
            rockButton.isHidden = false
            rockButton.isUserInteractionEnabled = false
            paperButton.isHidden = true
            scissorsButton.isHidden = true
        case .paper:
            rockButton.isHidden = true
            paperButton.isHidden = false
            paperButton.isUserInteractionEnabled = false
            scissorsButton.isHidden = true
        case .scissors:
            rockButton.isHidden = true
            paperButton.isHidden = true
            scissorsButton.isHidden = false
            scissorsButton.isUserInteractionEnabled = false
        }
        
        resetButton.isHidden = false
        
        let result = sign.takeTurn(computerSign)
        
        switch result {
        case .win:
            scoreUser += 1
            statusLabel.text = "It's a win!"
            checkScore()
        case .lose:
            scoreRobot += 1
            statusLabel.text = "You lose!"
            checkScore()
        case .start:
            resetButtonTapped()
        case .draw:
            statusLabel.text = "It's a draw!"
            self.view.backgroundColor = UIColor.gray
        }
        labelScore.text = "\(scoreRobot):\(scoreUser)"
    }
    
    private func checkScore(){
        if (scoreUser >= 3 || scoreRobot >= 3) {
            
            if (scoreUser >= 3){
                defaults.set("user", forKey: "winner")
            } else {
                defaults.set("robot", forKey: "winner")
            }
            let vc = ResultViewController()
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true)
        }
    }
    
    @objc private func ratingButtonTapped() {
        let vc = RatingViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
     }
}

