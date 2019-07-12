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
    
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.delegate = self
        self.tableView.dataSource = self
        
        alert.addTextField { (textField) in
            textField.placeholder = "Name"
        }
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {[weak alert]
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
            questionsGlobal.instance.players.append(player)
            self.tableView.reloadData()
            alert?.textFields![0].text = ""
        }))

        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: nil, action: nil)
        self.navigationItem.backBarButtonItem?.tintColor = .black
        
        loadQuestions()
        applyDesign()
    }
    
    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.78, green:0.57, blue:0.00, alpha:1.0)
        super.viewWillAppear(animated)
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
    
    func loadQuestions(){
        questionsGlobal.instance.getAllQuestions()
        if questionsGlobal.instance.questions.count <= 0{
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
            questionsGlobal.instance.getAllQuestions()
            questionsGlobal.instance.randomQuestion()
            }
        }
    }
    
    @IBAction func addPlayer(_ sender: UIBarButtonItem) {
        self.present(alert, animated: true, completion: nil)
    }
    
    
    @IBAction func refresh(_ sender: Any) {
        
        let delegate = UIApplication.shared.delegate as! AppDelegate
        let context = delegate.persistentContainer.viewContext
        
        let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "NormalQuestion")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print ("There was an error")
        }

        questionsGlobal.instance.players = [Player]()
        loadQuestions()
        self.tableView.reloadData()
    }

}

extension ViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsGlobal.instance.players.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playerCell", for: indexPath)
        
        cell.accessoryType = .none
        
        let player = questionsGlobal.instance.players[indexPath.row]
        
        cell.textLabel?.text = player.name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let player = questionsGlobal.instance.players[indexPath.row]
        
        let deleteAction = UITableViewRowAction(style: .default, title: "Delete"){
            (action, indexPath) in
            questionsGlobal.instance.players.remove(at: indexPath.row)
            tableView.reloadData()
        }
        
        deleteAction.backgroundColor = UIColor.init(displayP3Red: 1.00, green: 0.34, blue: 0.13, alpha: 1.0)
        
        return [deleteAction]
    }
}
