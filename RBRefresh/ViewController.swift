//
//  ViewController.swift
//  RBRefresh
//
//  Created by 夏敏 on 30/12/2016.
//  Copyright © 2016 夏敏. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func normalRefresh(_ sender: UIButton) {
        if let pullToRefreshViewControler = self.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController {
            navigationController?.pushViewController(pullToRefreshViewControler, animated: true)
        }
    }

}

