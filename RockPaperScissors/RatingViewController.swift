//
//  RatingViewController.swift
//  RockPaperScissors
//
//  Created by Сергей Киселев on 14.10.2023.
//

import UIKit
import SnapKit

class RatingViewController: UIViewController {
    
    let labelWin = UILabel()
    let labelLose = UILabel()
    let backButton = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        initialize()
        
        let defaults = UserDefaults.standard
        //ratingRobot
       
        let ratingWin = defaults.object(forKey: "ratingUser")
        let ratingLose = defaults.object(forKey: "ratingRobot")

        labelWin.text = "Количество побед: \(ratingWin ?? "0")"
        labelLose.text = "Количество поражений: \(ratingLose ?? "0")"
       
        
    }
    
    private func initialize() {
        labelWin.textColor = UIColor.black
        labelWin.font = UIFont.systemFont(ofSize: 20)
        
        labelLose.textColor = UIColor.black
        labelLose.font = UIFont.systemFont(ofSize: 20)

        backButton.setImage(UIImage(systemName: "arrowshape.left.fill"), for: .normal)
        backButton.tintColor = UIColor.black
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        
        view.addSubview(labelWin)
        labelWin.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().inset(200)
        }
        
        view.addSubview(labelLose)
        labelLose.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(labelWin).inset(50)
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

