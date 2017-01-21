//
//  TableViewController.swift
//  RBRefresh
//
//  Created by 夏敏 on 30/12/2016.
//  Copyright © 2016 夏敏. All rights reserved.
//

import UIKit


enum Type {
    case Normal
    case Gif
    
    func typeName() -> String{
        switch self {
        case .Normal:
            return "普通刷新"
        case .Gif:
            return "Gif"
        }
    }
}

class TableViewController: UITableViewController {

    var datasoucre:[Type] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = []
        self.datasoucre = [Type.Normal,Type.Gif]
        
    }
    
    func randNumber() -> Int {
        return Int(arc4random_uniform(100))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return datasoucre.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell.init(style: .default, reuseIdentifier: "cell")
        cell.textLabel?.text = datasoucre[indexPath.row].typeName()
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = TestViewController()
        vc.type = datasoucre[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    func addMehtod(number:Int) -> ((Int) -> (Int)) {
        return { (addNumber:Int) ->(Int) in
            return number + addNumber
        }
    }
    
}
