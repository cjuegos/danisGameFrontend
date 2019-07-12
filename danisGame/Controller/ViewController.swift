//
//  ViewController.swift
//  danisGame
//
//  Created by Maurilio Greggio Trujillo on 7/10/19.
//  Copyright © 2019 cJuegos. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    var downloadedQUestions : [NormalQuestionAPI] = [NormalQuestionAPI]()
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        loadQUestions()
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
    
    func loadQUestions(){
        API.getAllQUestions{ questions in
            self.downloadedQUestions = questions
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            // 2
            for i in questions{
                let entity =
                    NSEntityDescription.entity(forEntityName: "NormalQuestion",
                                               in: managedContext)!
                let question = NormalQuestion(entity: entity,
                                        insertInto: managedContext)
                
                question.id = Int32(i.id)
                question.state = true
                question.type = i.type
                question.text = i.text
                appDelegate.saveContext()
            }

        }
    }
}

