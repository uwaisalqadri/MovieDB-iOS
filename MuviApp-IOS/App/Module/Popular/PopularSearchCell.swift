//
//  PopularSearchCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 03/05/21.
//

import UIKit

class PopularSearchCell: UICollectionViewCell {
    
    let movieImage = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
        $0.image = #imageLiteral(resourceName: "Poster")
        $0.layer.cornerRadius = 4
        $0.clipsToBounds = true
    }
    
    let movieTitle = configure(UILabel()) {
        $0.text = "Astro Boy"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 15)
    }
    
    let movieDesc = configure(UILabel()) {
        $0.text = "Dylan O'Brien, Kaya Scodelario, Will Poulter wididnqisnosq"
        $0.textColor = .gray
        $0.font = .systemFont(ofSize: 12)
        $0.numberOfLines = 2
    }
    
    let movieRelease = configure(PaddingLabel()) {
        $0.text = "22 Jan 2021"
        $0.textColor = .black
        $0.font = .systemFont(ofSize: 12, weight: .bold)
        $0.backgroundColor = UIColor(named: "AccentColor")
        $0.clipsToBounds = true
        $0.layer.cornerRadius = 4
        $0.paddingLeft = 5
        $0.paddingRight = 5
        $0.paddingTop = 5
        $0.paddingBottom = 5
    }
    
    func set(movie: Movie) {
        movieImage.sd_setImage(with: URL(string: "\(Constants.urlImage)\(movie.backdrop_path ?? "/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg")"))
        
        movieTitle.text = movie.title
        movieDesc.text = movie.overview
        movieRelease.text = movie.release_date
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [movieImage, movieTitle, movieDesc, movieRelease].forEach { addSubview($0) }
                
        movieImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: nil, trailing: trailingAnchor)
        
        movieTitle.anchor(top: movieImage.bottomAnchor, leading: leadingAnchor, bottom: movieDesc.topAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 0, bottom: 0, right: 0))
        
        movieDesc.anchor(top: movieTitle.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 5, left: 0, bottom: 10, right: 0))
        
        movieRelease.anchor(top: nil, leading: movieImage.leadingAnchor, bottom: movieImage.bottomAnchor, trailing: nil, padding: .init(top: 0, left: 5, bottom: 5, right: 0))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
