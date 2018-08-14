//
//  DetailController.swift
//  ExamStratpoint
//
//  Created by Cyan Villarin on 13/08/2018.
//  Copyright © 2018 Cyan Villarin. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    @IBOutlet var view0: UIView!
    @IBOutlet var view1: UIView!
    @IBOutlet var view2: UIView!
    
    @IBOutlet var coverView: UIImageView!
    @IBOutlet var backdropView: UIImageView!
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var mpaRatingLabel: UILabel!
    @IBOutlet var languageLabel: UILabel!
    @IBOutlet var runtimeLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    var titleValue: String = ""
    var yearValue: Int = 0
    var languageValue: String = ""
    var runtimeValue: Int = 0
    var ratingValue: Float = 0.0
    var mpaRatingValue: String = ""
    var overviewValue: String = ""
    var slugValue: String = ""
    
    override func viewDidLoad() {
        
        self.titleLabel.text = self.titleValue
        self.ratingLabel.text = String(self.ratingValue)
        self.mpaRatingLabel.text = self.mpaRatingValue
        self.languageLabel.text = self.languageValue
        self.runtimeLabel.text = String(self.runtimeValue) + " mins"
        self.overviewLabel.text = self.overviewValue
        self.overviewLabel.sizeToFit()
        
        let urlString = "https://aacayaco.github.io/movielist/images/" + self.slugValue + "-backdrop.jpg"
        let url = URL(string: urlString)
        self.backdropView.contentMode = .scaleAspectFill
        
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
                
                self.coverView.layer.masksToBounds = true
                self.coverView.layer.cornerRadius = 5
                self.coverView.layer.borderWidth = 1
                self.coverView.layer.borderColor = UIColor.white.cgColor
            }
        }
        super.viewDidLoad()
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            completion(data, response, error)
            }.resume()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
