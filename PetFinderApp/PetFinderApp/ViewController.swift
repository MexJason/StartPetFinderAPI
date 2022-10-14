//
//  ViewController.swift
//  PetFinderApp
//
//  Created by YouTube on 9/23/22.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Task {
            let token = try await APIService.shared.getAccessToken()
            
            let accToken = token.accessToken
            let res = try await APIService.shared.search(token: accToken)
            print(res.map({$0.name}))
        }
    }


}

