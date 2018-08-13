//
//  ViewController.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

import UIKit

class MasterController: UITableViewController, UISplitViewControllerDelegate {

    // @IBOutlet var tableView: UITableView!
    private var collapseDetailViewController = true
    
    var movies: Array<Movie> = []
    var pageNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getJSONData()
        
        splitViewController?.delegate = self
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem
        navigationItem.leftItemsSupplementBackButton = true
        splitViewController?.preferredDisplayMode = .allVisible
        
    }

    func getJSONData() {
        print("getJSONData")
        
        if ReachabilityTest.isConnectedToNetwork() {
            print("Internet connection available")
            
            let urlstring = "https://aacayaco.github.io/movielist/list_movies_page" + String(self.pageNumber) + ".json"
            guard let url = URL(string: urlstring) else { return }
            
            let task = URLSession.shared.dataTask(with: url) { data, _, error in
                guard let data = data, error == nil else {
                    print(error ?? "Unknown error")
                    return
                }
                
                let decoder = JSONDecoder()
                do {
                    let json = try decoder.decode(Response.self, from: data)
                    
                    print(json.data.movies)
                    self.movies.append(contentsOf: json.data.movies)
                    
                } catch {
                    print(error)
                }
                
                // reload tableview when the app finishes getting data from the API
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            task.resume()
        }
        else{
            print("No internet connection available")
        }
    }
    
    
    
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let h1 = CGFloat(439.0)
        let w1 = CGFloat(780.0)
        let w2 = CGFloat(self.view.frame.width)
        let h2 = (h1 * w2) / w1
        return h2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! MasterControllerCell
        let movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = String(movie.year)
        
        let urlString = "https://aacayaco.github.io/movielist/images/" + movie.slug + "-backdrop.jpg"
        cell.backdropImage.loadImageUsingUrlString(urlString: urlString)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        collapseDetailViewController = false
        self.performSegue(withIdentifier: "masterToDetail", sender: indexPath)
    }
    
    // source vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        
        
        // identifier if required, if you have more then one segue
        // it could be set via IB, i did ...
        if segue.identifier == "masterToDetail" {
            //
            
            // colorViewController should never be assigned to nil !!!
            var dvc: DetailController!
            
            // with help of adaptive segue we can support all devices
            if let movieNavigationController = segue.destination as? UINavigationController {
                
                // works on devices where UISplitViewController is implemented
                dvc = movieNavigationController.topViewController as! DetailController
                dvc.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                dvc.navigationItem.leftItemsSupplementBackButton = true
            } else {
                
                // works for iPhone on ios7, where UISplitViewController is not implemented
                dvc = segue.destination as! DetailController
            }
            // this is common part, where one can configure detail view
            // segue provides a new instance of detail view everytime
            let selectedIndexPath = sender as! NSIndexPath
            let movie = self.movies[selectedIndexPath.row]
                
            dvc.titleValue = movie.title
            dvc.yearValue = movie.year
            dvc.ratingValue = movie.rating
            dvc.overviewValue = movie.overview
            dvc.slugValue = movie.slug
            
        }
        
        
        
        
        
        
        /*
        if segue.identifier == "masterToDetail"{
            let selectedIndexPath = sender as! NSIndexPath
            
            let dvc = segue.destination as! DetailController
            let movie = self.movies[selectedIndexPath.row]
            
            dvc.titleValue = movie.title
            dvc.yearValue = movie.year
            dvc.ratingValue = movie.rating
            dvc.overviewValue = movie.overview
            dvc.slugValue = movie.slug
        }
        */
        
    }
    
    // MARK: - UITableViewDelegate
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(activityIndicatorStyle: .gray)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            
            if (self.pageNumber <= 5){
                self.pageNumber = self.pageNumber + 1
                print("Batch: " + String(self.pageNumber))
                getJSONData()
            }
        }
    }
    
    // MARK: - UISplitViewControllerDelegate
    
    func splitViewController(_ splitViewController: UISplitViewController, collapseSecondary secondaryViewController: UIViewController, onto primaryViewController: UIViewController) -> Bool {
        return true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


