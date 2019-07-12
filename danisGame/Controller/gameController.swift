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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        //Do thing here
        self.navigationController?.navigationBar.barTintColor = UIColor(red:0.77, green:0.11, blue:0.00, alpha:1.0)
        
        self.view.backgroundColor = UIColor.init(displayP3Red: 1.00, green: 0.34, blue: 0.13, alpha: 1.0)
        print(33)
    }
    
}
