//
//  MovieTableViewCell.swift
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    var movie: AARMovie? {
        didSet {
            movieTitleLabel.text = movie?.title
            //adding default value in case of rating = nil
            movieRatingLabel.text = "Rating: \(movie?.rating ?? 0.0)"
            movieOverviewLabel.text = movie?.overview
        }
    }
}
