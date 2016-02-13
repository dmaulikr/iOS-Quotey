//
//  ViewController.swift
//  Quotey
//
//  Created by Steele, Trevor on 2/12/16.
//  Copyright © 2016 Trevor Steele. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TwitterKit



class ViewController: UIViewController {
    
    @IBOutlet weak var quoteLabel: UILabel!
    @IBOutlet weak var authorLabel: UILabel!
    @IBOutlet weak var newQuote: UIButton!
    @IBOutlet weak var tweetQuote: UIButton!
    @IBOutlet weak var quoteView: UIView!
    
    @IBAction func tweetButton(sender: AnyObject) {
        createTweet()
    }
    
    @IBAction func newQuoteButton(sender: AnyObject) {
        getNewQuote()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getNewQuote()
        designView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // colorize function takes HEX and Alpha converts then returns aUIColor object
    func colorize (hex: Int, alpha: Double = 1.0) -> UIColor {
        let red = Double((hex & 0xFF0000) >> 16) / 255.0
        let green = Double((hex & 0xFF00) >> 8) / 255.0
        let blue = Double((hex & 0xFF)) / 255.0
        let color: UIColor = UIColor( red: CGFloat(red), green: CGFloat(green), blue: CGFloat(blue), alpha:CGFloat(alpha) )
        return color
    }
    
    func getNewQuote() {
         // Add Headers
        let headers = [
            "X-Mashape-Key":"Dfb72avbP1mshDb1heHDhWbWTmXmp1G2Q01jsnhOgZXVfMKh68",
            "Accept":"application/json",
            "Content-Type":"application/x-www-form-urlencoded",
        ]
        // Fetch Request
        Alamofire.request(.GET, "https://andruxnet-random-famous-quotes.p.mashape.com/", headers: headers, encoding: .URL)
            .responseJSON { response in
                if (response.result.error == nil) {
                    debugPrint("HTTP Response Body: \(response.result.value)")
                }
                else {
                    debugPrint("HTTP Request failed: \(response.result.error)")
                }
                //Access JSON as Data
                let json = JSON(data: response.data!)
                if let
                    author = json["author"].string,
                    // Extract quote
                    quote = json["quote"].string {
                        self.authorLabel.text = "-" + author
                        self.quoteLabel.text = quote
                }
        }
        let colors = [0x6124f0, 0x6cce46, 0xce4c46, 0x1b81bb, 0xba0306]
        let randomColor = Int(arc4random_uniform(UInt32(colors.count)))
        
        self.view.backgroundColor = colorize(colors[randomColor], alpha: 1.0)
        quoteLabel.textColor = colorize(colors[randomColor], alpha: 1.0)
        authorLabel.textColor = colorize(colors[randomColor], alpha: 1.0)
        newQuote.backgroundColor = colorize(colors[randomColor], alpha: 1.0)
        tweetQuote.backgroundColor = colorize(colors[randomColor], alpha: 1.0)
    }
    
    func designView() {
        // Button Shaping
        quoteView.layer.cornerRadius = 10
        quoteView.clipsToBounds = true
        newQuote.layer.cornerRadius = 5
        newQuote.clipsToBounds = true
        tweetQuote.layer.cornerRadius = 5
        tweetQuote.clipsToBounds = true
    }
    
    func createTweet() {
        let composer = TWTRComposer()
        
        composer.setText(quoteLabel.text! + " " + authorLabel.text! + " #Quotey")
        
        // Called from a UIViewController
        composer.showFromViewController(self) { result in
            if (result == TWTRComposerResult.Cancelled) {
                print("Tweet composition cancelled")
            }
            else {
                print("Sending tweet!")
            }
        }
    }
}

