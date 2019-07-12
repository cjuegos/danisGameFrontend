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
    
    var currentQuestion : NormalQuestion = NormalQuestion()
    var questions: [NormalQuestion] = [NormalQuestion]()
    
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
    }
}
