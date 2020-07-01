//
//  SeriesViewController.swift
//  Movie
//
//  Created by Mahmoud Akl on 8/9/18.
//  Copyright © 2018 Mahmoud Akl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class UpcomingViewController: UIViewController {

    var upcomingaRR = [Results]()
    let urlString = "https://api.themoviedb.org/3/movie/upcoming?api_key=90b29a16adf0d3f819e9f2a88ae669d9"

    @IBOutlet weak var upcomingCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getUpcomingAPI()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getUpcomingAPI() {
        Alamofire.request(urlString, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let swiftyJson = JSON(value)
               
                let upMovieaRR = swiftyJson["results"].arrayValue
                for item in upMovieaRR{
                    let movieaRR = Results()
                    movieaRR.title = item["title"].stringValue
                    movieaRR.poster_path = item["poster_path"].stringValue
                    movieaRR.backdrop_path = item["backdrop_path"].stringValue
                    movieaRR.overview = item["overview"].stringValue
                    movieaRR.release_date = item["release_date"].stringValue

                    self.upcomingaRR.append(movieaRR)
                }
                self.upcomingCV.reloadData()



            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }



}

extension UpcomingViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return upcomingaRR.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UpcomingCollectionViewCell", for: indexPath) as! UpcomingCollectionViewCell

        let arrayIndex = self.upcomingaRR[indexPath.row]
        cell.upcomingLabel.text = arrayIndex.title

        let imageurl = URL(string: "https://image.tmdb.org/t/p/w500" + arrayIndex.poster_path!)
        cell.upcomingImage.hnk_setImageFromURL(imageurl!)


        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.orderaRRs = upcomingaRR[indexPath.row]
        present(vc, animated: true, completion: nil)
        
    }



    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.48 * collectionView.frame.width, height: 0.3 * collectionView.frame.height)
    }




}
