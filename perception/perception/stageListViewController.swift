//
//  stageListViewController.swift
//  perception
//
//  Created by Hanzhang Song on 6/20/21.
//  Copyright © 2021 Hanzhang Song. All rights reserved.
//

import UIKit

class stageCell: UITableViewCell {
    class func identifier() -> String {
        return "stageCell"
    }
}

class stageListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let stageList = UITableView()
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = stageList.dequeueReusableCell(withIdentifier: stageCell.identifier())
        switch indexPath.row % 3 {
        case 0:
            cell?.backgroundColor = .red
        case 1:
            cell?.backgroundColor = .green
        case 2:
            cell?.backgroundColor = .blue
        default:
            cell?.backgroundColor = .black
        }
        return cell ?? UITableViewCell();
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .gray
        
//        self.setupCloseBtn()
        self.setupStageList()
    }
    
    func setupCloseBtn() {
        let closeBtn = UIButton()
        self.view.addSubview(closeBtn)
        closeBtn.frame = CGRect(x: 0, y: 0, width: 50, height: 100)
        closeBtn.setTitle("close", for: .normal)
    }
    
    func setupStageList() {
        stageList.frame = self.view.bounds
        stageList.register(stageCell.self, forCellReuseIdentifier: stageCell.identifier())
        stageList.delegate = self
        stageList.dataSource = self
        self.view.addSubview(stageList)
    }

}
