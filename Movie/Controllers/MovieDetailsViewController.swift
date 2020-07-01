//
//  MovieDetailsViewController.swift
//  Movie
//
//  Created by Mahmoud Akl on 7/29/18.
//  Copyright © 2018 Mahmoud Akl. All rights reserved.
//

import UIKit

class MovieDetailsViewController: UIViewController {
    
    
    var orderaRRs = Results()

    @IBOutlet weak var overviewText: UITextView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var backDropImage: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var watchListBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        print("selectedIndex", selectedIndex)
//        movieTitleLabel.text = orderaRRs[selectedIndex].title
        overviewText.text = orderaRRs.overview
        
        let posterImageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + orderaRRs.poster_path!)
        backDropImage.hnk_setImageFromURL(posterImageUrl!)
        
        let backImageUrl = URL(string: "https://image.tmdb.org/t/p/w500" + orderaRRs.backdrop_path!)
        posterImage.hnk_setImageFromURL(backImageUrl!)
        
        movieTitleLabel.text = orderaRRs.title
        dateLabel.text = orderaRRs.release_date
        
        watchListBtn.layer.cornerRadius = 3
        watchListBtn.layer.shadowColor = UIColor.black.cgColor
        watchListBtn.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        watchListBtn.layer.shadowRadius = 1.7
        watchListBtn.layer.shadowOpacity = 0.3
        
        shareBtn.layer.cornerRadius = 3
        shareBtn.layer.shadowColor = UIColor.black.cgColor
        shareBtn.layer.shadowOffset = CGSize(width: 0, height: 1.75)
        shareBtn.layer.shadowRadius = 1.7
        shareBtn.layer.shadowOpacity = 0.3
        
        
    }

    @IBAction func watchlistBtnPressed(_ sender: Any) {
        
        let alert = UIAlertController(title: "Alert!", message: "Do you want to save \(self.movieTitleLabel.text!) to watch later?" , preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        alert.addAction(okAction)
        
        present(alert, animated: true, completion: nil)
        
    }
    @IBAction func shareBtnPressed(_ sender: Any) {
        
        let activityVC = UIActivityViewController(activityItems: [self.posterImage.image as Any], applicationActivities: nil)
        
        activityVC.popoverPresentationController?.sourceView = self.view
        
        present(activityVC, animated: true, completion: nil)
        
        print("Share btn clicked!")
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
  
}
