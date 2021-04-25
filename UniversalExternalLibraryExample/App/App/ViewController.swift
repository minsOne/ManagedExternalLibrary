//
//  ViewController.swift
//  App
//
//  Created by minsone on 2021/04/25.
//

import UIKit
import Feature

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let vc = Feature.ViewController()
        present(vc, animated: true, completion: nil)
    }
}

