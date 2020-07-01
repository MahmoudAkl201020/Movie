//
//  ViewController.swift
//  Movie
//
//  Created by Mahmoud Akl on 7/10/18.
//  Copyright © 2018 Mahmoud Akl. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import Haneke




class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    @IBOutlet weak var movieCV: UICollectionView!
    
    var myIndex = 0
    var resultaRR = [Results]()
    
    var counter = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //The icons that will be displayed on the tabs that are not currently selected
        var icons = [String]()
        icons.append("phone-book@0,5x")
        icons.append("poster@0,5x")
        icons.append("settings@0,5x")
        icons.append("SmartPhone@0,5x")
        
        //The icons that will be displayed for each tab once they are selected.
        var selectedIcons = [String]()
        selectedIcons.append("phone-bookActive@0,5x")
        selectedIcons.append("posterActive@0,5x")
        selectedIcons.append("settingsActive@0,5x")
        selectedIcons.append("smartphoneActive@0,5x")
        
//        getResults()
        getResultsByAlamofire()
        
        
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if resultaRR.count == 0 {
            return 0
        }else{
            return resultaRR.count
        }
        //               return letteraRR.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        let letter = resultaRR[indexPath.row]
        //        cell.movieImage.image = UIImage(named: letter.backdrop_path!)
        cell.movieLabel.text = letter.title
        
        let imageurl = URL(string: "https://image.tmdb.org/t/p/w500" + letter.poster_path!)
        cell.movieImage.hnk_setImageFromURL(imageurl!)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let table = indexPath.row
//        print("table: ", table)
        
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MovieDetailsViewController") as! MovieDetailsViewController
        vc.orderaRRs = self.resultaRR[indexPath.row]
        self.present(vc, animated: true, completion: nil)
        
        movieCV.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView,layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize{
        return CGSize(width: 0.48 * collectionView.frame.width,height: 0.3 * collectionView.frame.height)
    }
    
    
    func getResultsByAlamofire() {
        Alamofire.request("https://api.themoviedb.org/3/movie/popular?api_key=90b29a16adf0d3f819e9f2a88ae669d9",  encoding: JSONEncoding.default).responseJSON { (response) in
            switch response.result{
            case .success(let value):
                let json = JSON(value)
                
                
                let results = json["results"].arrayValue
                for item in results{
                    let results = Results()
                    results.title = item["title"].stringValue
                    results.poster_path = item["poster_path"].stringValue
                    results.backdrop_path = item["backdrop_path"].stringValue
                    results.overview = item["overview"].stringValue
                    results.release_date = item["release_date"].stringValue
                    
                    
                    self.resultaRR.append (results)
                }
                
                self.movieCV.reloadData()
                
            case .failure(let error):
                print("Error :\(error.localizedDescription)")
            }
        }
        
    }
    
    
//    func getResults() {
//        guard let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=90b29a16adf0d3f819e9f2a88ae669d9") else { return }
//
//        let task = URLSession.shared.dataTask(with: url) { (data, response, err) in
//
//            guard let data = data else{ return }
//
//            do{
//                let results = try JSONDecoder().decode(Json4Swift_Base.self, from: data)
//
//                print("Result: ", results)
//            }catch let jsonErr {
//                print("Error serializing JSON: ", jsonErr)
//            }
//
//        }
//        task.resume()
//
//        self.movieCV.reloadData()
//    }
    
    
    
}


// MARK: - IBActions
extension ViewController {
    
    @IBAction func cancelToViewController(_ segue: UIStoryboardSegue) {
        dismiss(animated: true)
    }
}

