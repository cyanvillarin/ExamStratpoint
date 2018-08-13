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
        self.yearLabel.text = String(self.yearValue)
        self.ratingLabel.text = String(self.ratingValue)
        self.overviewLabel.text = self.overviewValue
        
        super.viewDidLoad()
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
