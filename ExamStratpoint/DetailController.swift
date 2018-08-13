//
//  DetailController.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet var coverView: UIImageView!
    @IBOutlet var backdropView: UIImageView!
    @IBOutlet var headerLabel: UILabel!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    var titleValue: String = ""
    var yearValue: Int = 0
    var ratingValue: Float = 0.0
    var overviewValue: String = ""
    var slugValue: String = ""
    
    override func viewDidLoad() {
        
        self.titleLabel.text = self.titleValue
        self.headerLabel.text = self.titleValue
        self.yearLabel.text = String(self.yearValue)
        self.ratingLabel.text = String(self.ratingValue)
        self.overviewLabel.text = self.overviewValue
        self.overviewLabel.sizeToFit()
        
        let urlString = "https://aacayaco.github.io/movielist/images/" + self.slugValue + "-backdrop.jpg"
        let url = URL(string: urlString)
        self.backdropView.contentMode = .scaleAspectFit
        getDataFromUrl(url: url!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.backdropView.image = UIImage(data: data)
            }
        }
        
        let urlString2 = "https://aacayaco.github.io/movielist/images/" + self.slugValue + "-cover.jpg"
        let url2 = URL(string: urlString2)
        self.coverView.contentMode = .scaleAspectFit
        getDataFromUrl(url: url2!) { data, response, error in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() {
                self.coverView.image = UIImage(data: data)
            }
        }
        
        
        super.viewDidLoad()
    }

    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    @IBAction func returnToHome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
