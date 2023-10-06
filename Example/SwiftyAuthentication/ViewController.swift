//
//  ViewController.swift
//  SwiftyAuthentication
//
//  Created by DeveloperZainModr on 10/06/2023.
//  Copyright (c) 2023 DeveloperZainModr. All rights reserved.
//

import UIKit
import SwiftyAuthentication

class ViewController: UIViewController {
    let service = SwiftyAuthentication()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func actionLoginWithApple(_ sender: Any) {
        //Scope is optional. You can use it without any parameter. service.signInWithApple {result in }
        service.signInWithApple([.fullName, .email]) { result in
            switch result {
                case .success(let user):
                    print("User: ", user)
                    
                case .failure(let error):
                    print("Error: ", error.localizedDescription)
            }
        }
    }

}

