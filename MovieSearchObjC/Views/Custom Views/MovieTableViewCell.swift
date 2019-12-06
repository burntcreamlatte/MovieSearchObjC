//
//  MovieTableViewCell.swift
//  MovieSearchObjC
//
//  Created by Aaron Shackelford on 12/6/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import UIKit

class MovieTableViewCell: UITableViewCell {

    // MARK: - Outlets
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieRatingLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    
    
    // MARK: - Properties
    var movie: AARMovie? {
        didSet {
            movieTitleLabel.text = movie?.title
            //adding default value in case of rating = nil
            //REVIEW -- entering "star wars" to search results in a rating of 8.199999999999999, NSNumber is able to change type?
            movieRatingLabel.text = "Rating: \(movie?.rating ?? 0.0)"
            movieOverviewLabel.text = movie?.overview
        }
    }
}
