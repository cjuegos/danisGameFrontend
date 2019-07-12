//
//  questionsGlobal.swift
//  danisGame
//
//  Created by Maurilio Greggio Trujillo on 7/12/19.
//  Copyright © 2019 cJuegos. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class questionsGlobal{
    static let instance = questionsGlobal()
    
    var index: Int = 0
    var indexPlayer: Int = 0
    var currentQuestion : NormalQuestion = NormalQuestion()
    var questions: [NormalQuestion] = [NormalQuestion]()
    
    var currentPlayer : Player = Player()
    var players: [Player] = [Player]()
    
    func getAllQuestions(){
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else{
            return
        }
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "NormalQuestion")
        
        do{
            questionsGlobal.instance.questions = try managedContext.fetch(fetchRequest) as! [NormalQuestion]
            
        }catch let error as NSError{
            print("ERROR: \(error)")
        }
        
        print(questionsGlobal.instance.questions.count)
    }
    
    func randomQuestion(){
        index = Int.random(in: 0 ..< questionsGlobal.instance.questions.count)
        
        questionsGlobal.instance.currentQuestion = questionsGlobal.instance.questions[index]
    }
    
    func randomPlayer(){
        index = Int.random(in: 0 ..< questionsGlobal.instance.players.count)
        
        questionsGlobal.instance.currentPlayer = questionsGlobal.instance.players[index]
    }
    
    func popQuestion()
    {
        questionsGlobal.instance.questions.remove(at: index)
    }
}
