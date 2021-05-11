//
//  CastCell.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/05/21.
//

import UIKit

class CastCell: UICollectionViewCell {
    
    private let castImage = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
        $0.layer.cornerRadius = $0.frame.size.height / 2
        $0.layer.masksToBounds = false
        $0.clipsToBounds = true
    }
    
    private let castName = configure(UILabel()) {
        $0.textColor = .lightGray
        $0.numberOfLines = 2
    }
    
    func set(cast: Cast) {
        castImage.sd_setImage(with: URL(string: "\(Constants.urlImage)\(cast.profile_path)"))
        castName.text = cast.original_name
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        [castName, castImage].forEach{addSubview($0)}
                
        castImage.anchor(top: topAnchor, leading: leadingAnchor, bottom: castName.topAnchor, trailing: trailingAnchor, padding: .init(top: 0, left: 10, bottom: 0, right: 10), size: .init(width: 130, height: 130))
        
        castName.anchor(top: castImage.bottomAnchor, leading: leadingAnchor, bottom: bottomAnchor, trailing: trailingAnchor, padding: .init(top: 10, left: 20, bottom: 20, right: 20))
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
