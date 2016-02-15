//
//  InfoViewController.swift
//  Quotey
//
//  Created by Trevor Steele on 2/14/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import UIKit

class InfoViewController : UIViewController {
    
    @IBOutlet var infoView: UIView!
    @IBOutlet weak var creditView: UIView!
    @IBOutlet weak var hannah: UILabel!
    @IBOutlet weak var andrux: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        creditView.layer.cornerRadius = 10
        creditView.clipsToBounds = true
    }
    
    @IBAction func closeView(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
