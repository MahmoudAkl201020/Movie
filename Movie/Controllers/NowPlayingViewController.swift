//
//  NowPlayingViewController.swift
//  Movie
//
//  Created by Mahmoud Akl on 8/16/18.
//  Copyright © 2018 Mahmoud Akl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NowPlayingViewController: UIViewController {

    var nowPlayaRR = [Results]()
    let urlString = "https://api.themoviedb.org/3/movie/now_playing?api_key=90b29a16adf0d3f819e9f2a88ae669d9"
    
    @IBOutlet weak var nowPlayinCV: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        getNowPlayingAPI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getNowPlayingAPI() {
        Alamofire.request(urlString, encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let swiftyJson = JSON(value)
                print(value)
                
                let upMovieaRR = swiftyJson["results"].arrayValue
                for item in upMovieaRR{
                    let movieaRR = Results()
                    movieaRR.title = item["title"].stringValue
                    movieaRR.poster_path = item["poster_path"].stringValue
                    movieaRR.backdrop_path = item["backdrop_path"].stringValue
                    movieaRR.overview = item["overview"].stringValue
                    movieaRR.release_date = item["release_date"].stringValue
                    
                    self.nowPlayaRR.append(movieaRR)
                }
                self.nowPlayinCV.reloadData()
                
                
                
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }

   
}



extension NowPlayingViewController: UICollectionViewDataSource, UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowPlayaRR.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowPlayingCollectionViewCell", for: indexPath) as! NowPlayingCollectionViewCell
        
        let arrayIndex = nowPlayaRR[indexPath.row]
        cell.nowPlayingLabel.text = arrayIndex.title
        
        let imageurl = URL(string: "https://image.tmdb.org/t/p/w500" + arrayIndex.poster_path!)
        cell.nowPlayingImage.hnk_setImageFromURL(imageurl!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.orderaRRs = nowPlayaRR[indexPath.row]
        present(vc, animated: true, completion: nil)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0.48 * collectionView.frame.width, height: 0.3 * collectionView.frame.height)
    }
}
