//
//  API.swift
//  danisGame
//
//  Created by Maurilio Greggio Trujillo on 7/11/19.
//  Copyright © 2019 cJuegos. All rights reserved.
//

import Foundation

import Foundation
import Alamofire
import os

import Foundation
class API
{
    static let instance = API()
    
    var sesion: Sesion?
    var player: Player?
    var normalQuestion: NormalQuestion?
    
    static let baseUrlString = "https://danisgame-backend.herokuapp.com"
    static let questionsUrlString = "\(baseUrlString)/normalquestions"
    
    static func getAllQUestions(result:@escaping (_ questions:[NormalQuestionAPI])-> Void){
        var questions: [NormalQuestionAPI] = [NormalQuestionAPI]()
        AF.request(questionsUrlString).responseJSON(completionHandler: {
            response in
            switch response.result {
            case .success( _):
                do {
                    let decoder = JSONDecoder()
                    if let data = response.data {
                        let gitData = try decoder.decode([NormalQuestionAPI].self, from: data)
                        questions = gitData
                        result(questions)
                    }
                } catch {
                    print(error)
                }
            case .failure(let error):
                print(error)
            }
        })
    }
    
}
