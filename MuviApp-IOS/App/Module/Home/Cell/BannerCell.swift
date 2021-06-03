//
//  BannerCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 11/05/21.
//

import UIKit

class BannerCell: UICollectionViewCell {
    
    private let imageBanner = configure(UIImageView()) {
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFill
    }
    
    func set(movie: Movie) {
        imageBanner.sd_setImage(with: URL(string: "\(Constants.urlImage)\(movie.backdrop_path ?? "/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg")"))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(imageBanner)
        
        imageBanner.anchor(top: topAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
