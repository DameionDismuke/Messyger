//
//  HomeViewController.swift
//  DaWordUp
//
//  Created by Dameion on 1/24/23.
//

import UIKit


class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var homeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        homeTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        homeTableView.delegate = self
        homeTableView.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Sun Wukong, Sage-Equaling Heaven"
        cell.accessoryType = .disclosureIndicator
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated: true)
        
        
        //Showing Mock Messages
        let vc = NewConversationViewController()
        //vc.title = "Final Battle"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    
    
}
