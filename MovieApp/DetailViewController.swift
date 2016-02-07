//
//  DetailViewController.swift
//  MovieApp
//
//  Created by Alex  Oser on 2/1/16.
//  Copyright © 2016 Alex Oser. All rights reserved.
//

import UIKit
import AFNetworking

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var infoView: UIView!

    var movie: NSDictionary!
    var imageTapped = false
    
    override func viewDidLoad() {
        super.viewDidLoad()        
        
        UITabBar.appearance().barTintColor = UIColor.blackColor()
        
//        scrollView.contentSize = CGSize(width: scrollView.frame.size.width, height: infoView.frame.origin.y + infoView.frame.size.height)
        
        let tapGestureRecognizer = UITapGestureRecognizer(target:self, action:Selector("imageTapped:"))
        posterImageView.userInteractionEnabled = true
        posterImageView.addGestureRecognizer(tapGestureRecognizer)
        
        let title = movie["title"] as! String
        titleLabel.text = title
        self.title = "\(title)"

        
        let overview = movie["overview"] as! String
        overviewLabel.text = overview
        overviewLabel.sizeToFit()
        
        if let posterPath = movie["poster_path"] as? String {
            let posterBaseUrl = "http://image.tmdb.org/t/p/w500"
            let posterUrl = NSURL(string: posterBaseUrl + posterPath)
            posterImageView.setImageWithURL(posterUrl!)
        }
        else {
            // No poster image. Can either set to nil (no image) or a default movie poster image
            // that you include as an asset
            posterImageView.image = nil
        }
        
    }
    
    func imageTapped(img: AnyObject)
    {
        if (imageTapped == false) {
        let selectedFrame = CGRectOffset(infoView.frame, 0, -230)
        UIView.animateKeyframesWithDuration(1, delay: 0, options: .CalculationModeCubic, animations: {
            
            UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
                self.infoView.frame = selectedFrame
            }
            
            }, completion: nil)
            imageTapped = true
        }
        else {
            let deselectedFrame = CGRectOffset(infoView.frame, 0, 230)
            UIView.animateKeyframesWithDuration(1, delay: 0, options: .CalculationModeCubic, animations: {
                
                UIView.addKeyframeWithRelativeStartTime(0.0, relativeDuration: 0.5) {
                    self.infoView.frame = deselectedFrame
                }
                
                }, completion: nil)
            imageTapped = false
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
