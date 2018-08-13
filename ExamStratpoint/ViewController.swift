//
//  ViewController.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet var tableView: UITableView!
    
    var movies: Array<Movie> = []
    var pageNumber: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        getJSONData()
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
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    // MARK: - UITableViewDataSource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.movies.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 211
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell", for: indexPath as IndexPath) as! ViewControllerCell
        let movie = self.movies[indexPath.row]
        cell.titleLabel.text = movie.title
        cell.yearLabel.text = String(movie.year)
        
        let urlString = "https://aacayaco.github.io/movielist/images/" + movie.slug + "-backdrop.jpg"
        let url = URL(string: urlString)
        cell.backdropView.contentMode = .scaleAspectFit
        getDataFromUrl(url: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                cell.backdropView.image = UIImage(data: data)
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "masterToDetail", sender: indexPath)
    }
    
    // source vc
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
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
    }
    
    // MARK: - UITableViewDelegate
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
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
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}


