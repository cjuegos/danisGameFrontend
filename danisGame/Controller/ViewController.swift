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

    let alert = UIAlertController(title: "Player", message: nil, preferredStyle: .alert)
    
    var downloadedQUestions : [NormalQuestionAPI] = [NormalQuestionAPI]()
    var players : [Player] = [Player]()
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self

        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: {[weak alert]
            (_) in
            alert?.dismiss(animated: true, completion: nil)
        }))

        alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { [weak alert] (_) in
            
            guard let appDelegate =
                UIApplication.shared.delegate as? AppDelegate else {
                    return
            }
            // 1
            let managedContext =
                appDelegate.persistentContainer.viewContext
            
            let entity =
                NSEntityDescription.entity(forEntityName: "Player",
                                           in: managedContext)!
            
            let player = Player(entity: entity, insertInto: managedContext)
            
            player.name = alert?.textFields![0].text
            player.questions = 0
            player.sesion = 0
            self.players.append(player)
            self.tableView.reloadData()
            print(33)
            print(self.players.count)
        }))
        
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
    
    @IBAction func addPlayer(_ sender: UIBarButtonItem) {
        self.present(alert, animated: true, completion: nil)
    }
    
    func savePlayers(){
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
                return
        }
        // 1
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        for i in players{
        let entity =
            NSEntityDescription.entity(forEntityName: "Player",
                                       in: managedContext)!
        
        let player = Player(entity: entity,
                            insertInto: managedContext)
        
            player.name = i.name
            player.questions = i.questions
            player.sesion = i.sesion
            appDelegate.saveContext()
            

        appDelegate.saveContext()
        }
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        
        cell.accessoryType = .none
        
        let player = players[indexPath.row]
        
        cell.textLabel?.text = player.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let player = players[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){
            (action, indexPath) in
        }
        
        deleteAction.backgroundColor = .red
        
        return [deleteAction]
    }
    
}
