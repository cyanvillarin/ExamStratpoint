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
    @IBOutlet var yearLabel: UILabel!
    @IBOutlet var ratingLabel: UILabel!
    @IBOutlet var overviewLabel: UILabel!
    
    var titleValue: String = "test"
    var yearValue: Int = 0
    var ratingValue: Float = 0.0
    var overviewValue: String = "test"
    var slugValue: String = "test"
    
    override func viewDidLoad() {
        
        self.titleLabel.text = self.titleValue
        // self.headerLabel.text = self.titleValue
        self.yearLabel.text = String(self.yearValue)
        self.ratingLabel.text = String(self.ratingValue)
        self.overviewLabel.text = self.overviewValue
        self.overviewLabel.sizeToFit()
        
        let urlString = "https://aacayaco.github.io/movielist/images/" + self.slugValue + "-backdrop.jpg"
        let url = URL(string: urlString)
        self.backdropView.contentMode = .scaleAspectFit
        
        /*
        let h1 = CGFloat(439.0)
        let w1 = CGFloat(780.0)
        let w2 = CGFloat(self.view0.frame.width)
        let h2 = (h1 * w2) / w1
        
        self.view1.frame = CGRect(x: 0, y: 0, width: w2, height: h2)
        self.view2.frame = CGRect(x: 0, y: h2, width: w2, height: self.view0.frame.height - h2)
        */
        
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
