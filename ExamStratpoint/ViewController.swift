//
//  ViewController.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {

    @IBOutlet weak var tableView: UITableView
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

// MARK: - UITableViewDataSource
extension ViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cellData = data[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath)
        // cell.textLabel?.text = cellData.label
        return cell
    }
}


// MARK: - UITableViewDelegate
extension ViewController {
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        /*
        let cellData = data[indexPath.row]
        
        guard let color = cellData.color else {
            cell.textLabel?.textColor = .black
            cell.backgroundColor = .white
            return
        }
        
        var red = CGFloat(0.0), green = CGFloat(0.0), blue = CGFloat(0.0), alpha = CGFloat(0.0)
        color.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        let threshold = CGFloat(105)
        let bgDelta = ((red * 0.299) + (green * 0.587) + (blue * 0.114));
        
        let textColor: UIColor = (255 - bgDelta < threshold) ? .black : .white;
        cell.textLabel?.textColor = textColor
        cell.backgroundColor = color
        */
    }
}


