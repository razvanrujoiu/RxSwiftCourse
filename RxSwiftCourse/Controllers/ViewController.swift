//
//  ViewController.swift
//  RxSwiftCourse
//
//  Created by Razvan Rujoiu on 19/12/2018.
//  Copyright © 2018 Rujoiu Razvan. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import Alamofire
import SwiftyJSON
import Firebase

class ViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var movieSearch: UISearchBar!
    
    var movies = [String]() {
        didSet {
            self.tableView.reloadData()
        }
    }
    var ref: DatabaseReference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()
        
        movieSearch.rx.text
            .orEmpty
            .distinctUntilChanged()
            .filter{ !$0.isEmpty }
            .throttle(0.5, scheduler: MainScheduler.instance)
            .subscribe(onNext: { query  in
                let url = "https://www.omdbapi.com/?apikey=e396a9fc&s=" + query
                
                Alamofire.request(url).responseJSON(completionHandler: { URLResponse in
                    if let value = URLResponse.result.value {
                        let json = JSON(value)
                        
                        self.movies.removeAll()
                        
                        for movie in json["Search"] {
                            if let title = movie.1["Title"].string {
                                self.movies.append(title)
                            }
                        }
                    }
                })
            })
    }
}

extension ViewController: UITableViewDataSource,  UITableViewDelegate  {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        
        cell?.textLabel?.text = movies[indexPath.row]
        
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedMovie = movies[indexPath.row]
        
        ref.child("favourites").childByAutoId().setValue(["movie-title":selectedMovie])
    }
}

