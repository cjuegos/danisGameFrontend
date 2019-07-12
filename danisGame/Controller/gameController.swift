//
//  gameController.swift
//  danisGame
//
//  Created by Maurilio Greggio Trujillo on 7/10/19.
//  Copyright © 2019 cJuegos. All rights reserved.
//

import Foundation
import UIKit

class gameController: UIViewController {
    
    @IBOutlet weak var questionTextLabel: UILabel!
    @IBOutlet weak var typeTextLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        questionsGlobal.instance.getAllQuestions()
        questionsGlobal.instance.randomQuestion()
        setView()
    }
    
    func setView(){
        typeTextLabel.text = questionsGlobal.instance.currentQuestion.type
        
        if questionsGlobal.instance.currentQuestion.type == "Game"
        {
            self.navigationController?.navigationBar.barTintColor = UIColor(red:0.78, green:0.57, blue:0.00, alpha:1.0)
            
            self.view.backgroundColor = UIColor(red:1.00, green:0.76, blue:0.03, alpha:1.0)
            
            questionTextLabel.text = questionsGlobal.instance.currentQuestion.text
        }
        if questionsGlobal.instance.currentQuestion.type == "Dare"
        {
            questionsGlobal.instance.randomPlayer()
            
            self.navigationController?.navigationBar.barTintColor = UIColor(red:0.35, green:0.57, blue:0.09, alpha:1.0)
            
            self.view.backgroundColor = UIColor(red:0.55, green:0.76, blue:0.29, alpha:1.0)
            
            questionTextLabel.text = questionsGlobal.instance.currentPlayer.name! + "," + " " + questionsGlobal.instance.currentQuestion.text!
        }
        if questionsGlobal.instance.currentQuestion.type == "Attribute"
        {
            self.navigationController?.navigationBar.barTintColor = UIColor(red:0.00, green:0.48, blue:0.76, alpha:1.0)
            
            self.view.backgroundColor = UIColor(red:0.01, green:0.66, blue:0.96, alpha:1.0)
            
            questionTextLabel.text = questionsGlobal.instance.currentQuestion.text
        }
        if questionsGlobal.instance.currentQuestion.type == "Vote"
        {
            self.navigationController?.navigationBar.barTintColor = UIColor(red:0.77, green:0.11, blue:0.00, alpha:1.0)
            
            self.view.backgroundColor = UIColor.init(displayP3Red: 1.00, green: 0.34, blue: 0.13, alpha: 1.0)
            
            questionTextLabel.text = questionsGlobal.instance.currentQuestion.text
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        print(questionsGlobal.instance.currentQuestion.id)
        questionsGlobal.instance.popQuestion()
        questionsGlobal.instance.randomQuestion()
        
        questionTextLabel.text = questionsGlobal.instance.currentQuestion.text
        setView()
    }
    
}
