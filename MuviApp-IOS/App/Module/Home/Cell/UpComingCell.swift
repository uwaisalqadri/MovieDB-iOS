//
//  UpComingTableViewCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit

class UpComingCell: UICollectionViewCell {

    private let posterImage = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
        $0.image = #imageLiteral(resourceName: "Poster")
    }

    func set(movie: Movie) {
        posterImage.sd_setImage(with: URL(string: "\(Constants.urlImage)\(movie.poster_path ?? "/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg")"))
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(posterImage)
        
        posterImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
