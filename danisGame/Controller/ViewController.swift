//
//  ViewController.swift
//  danisGame
//
//  Created by Maurilio Greggio Trujillo on 7/10/19.
//  Copyright © 2019 cJuegos. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        applyDesign()
    }
    func applyDesign(){
        playButton.backgroundColor = UIColor.white
        playButton.layer.cornerRadius = playButton.frame.height/2
        playButton.setTitleColor(UIColor.black, for: .normal)
        playButton.layer.shadowColor = UIColor.darkGray.cgColor
        playButton.layer.shadowRadius = 4
        playButton.layer.shadowOpacity = 0.5
        playButton.layer.shadowOffset = CGSize(width: 0, height: 0)
    }
    
}

