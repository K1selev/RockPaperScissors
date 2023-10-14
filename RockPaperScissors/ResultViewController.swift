//
//  ResultViewController.swift
//  RockPaperScissors
//
//  Created by Сергей Киселев on 14.10.2023.
//

import UIKit
import SnapKit

class ResultViewController: UIViewController {
    
    let label = UILabel()
    let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initialize()
        
        let defaults = UserDefaults.standard
        let winner = defaults.object(forKey: "winner") as? String
        
        if (winner == "user") {
            view.backgroundColor = UIColor.green
            label.text = "YOU WIN !!!"
            
            var rating = defaults.object(forKey: "ratingUser") as? Int
            if rating == nil {
                rating = 1
            } else {
                rating! += 1
            }
            defaults.set(rating, forKey: "ratingUser")
        } else {
            view.backgroundColor = UIColor.red
            label.text = "You lose"
            
            var rating = defaults.object(forKey: "ratingRobot") as? Int
            if rating == nil {
                rating = 1
            } else {
                rating! += 1
            }
            defaults.set(rating, forKey: "ratingRobot")
        }
    }
    
    private func initialize() {
        label.textColor = UIColor.black
        label.font = UIFont.systemFont(ofSize: 30)

        backButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        backButton.tintColor = UIColor.black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(30)
            make.top.equalToSuperview().inset(100)
        }
    }
    
    @objc private func backButtonTapped() {
        let vc = ViewController()
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: false)
     }
}
