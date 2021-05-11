//
//  DetailViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 01/05/21.
//

import UIKit
import RxSwift
import RxCocoa
import JGProgressHUD
import SafariServices

class DetailViewController: UIViewController {
    
    private var viewModel = DetailViewModel(detailUseCase: Injection.init().provideDetail())
    private let bag = DisposeBag()
    let idMovie: Int
    
    init(idMovie: Int) {
        self.idMovie = idMovie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let scrollView = configure(UIScrollView()) {
        $0.isScrollEnabled = true
        $0.isUserInteractionEnabled = true
        $0.contentInsetAdjustmentBehavior = .never
    }
    
    private let progress = JGProgressHUD(style: .dark)
    
    private let contentView = configure(UIView()) {
        $0.isUserInteractionEnabled = true
    }
    
    private let movieImage = configure(UIImageView()) {
        $0.contentMode = .scaleAspectFill
        $0.clipsToBounds = true
    }
    
    private let gradientView = configure(Gradient()) {
        $0.startColor = .clear
        $0.endColor = UIColor(named: "BackgroundColor") ?? .black
        $0.contentMode = .scaleToFill
        $0.startLocation = 0.25
        $0.endLocation = 0.98
    }
    
    private let movieTitle = configure(UILabel()) {
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 30, weight: .bold)
    }
    
    private let backButton = configure(UIButton()) {
        $0.setImage(UIImage(named: "BackIcon"), for: .normal)
        $0.tintColor = UIColor(named: "AccentColor")
    }
    
    private let moviePlaytime = configure(UILabel()) {
        $0.textColor = .lightGray
    }
    
    private let movieGenre = configure(UILabel()) {
        $0.textColor = .lightGray
    }
        
    private let buttonPlay = configure(UIButton()) {
        $0.setTitle("Watch Trailer", for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setTitleColor(UIColor(named: "BackgroundColor"), for: .normal)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.setImage(UIImage(named: "PlayIcon"), for: .normal)
        // $0.layer.borderColor = CGColor(s)
        $0.backgroundColor = UIColor(named: "AccentColor")
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private let buttonFavorite = configure(UIButton()) {
        $0.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        $0.setImage(UIImage(named: "AddIcon"), for: .normal)
        $0.layer.cornerRadius = 4
        $0.layer.borderWidth = 1
        $0.setTitle("Add to Favorite", for: .normal)
        $0.backgroundColor = .clear
        $0.titleEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
    
    private let movieOverview = configure(UILabel()) {
        $0.textColor = .lightGray
        $0.numberOfLines = 100
    }
    
    private let castLabel = configure(UILabel()) {
        $0.text = "Cast"
        $0.textColor = .white
        $0.font = .systemFont(ofSize: 20, weight: .bold)
    }
    
    private let castList: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(CastCell.self, forCellWithReuseIdentifier: "castCell")
        collectionView.backgroundColor = UIColor(named: "BackgroundColor")
        return collectionView
    }()
    
    // imageHD (optional)
    // buttonFavorite
    // movieOverview
    // castLabel
    // castList (UITableView)
    // castCell (UIImage with circle, castName: 15)

    override func viewDidLoad() {
        super.viewDidLoad()
        addLayoutAndSubViews()
        bindCastList()
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)

        viewModel.getDetailMovie(idMovie: idMovie)
        viewModel.getMovieCast(idMovie: idMovie)
        viewModel.getMovieTrailer(idMovie: idMovie)
        castList.rx.setDelegate(self).disposed(by: bag)
        
        viewModel.trailers.subscribe(onNext: { [self] result in
            result.forEach {
                print("trailers \($0.key)")
                let tapGesture = CustomTapGesture(target: self, action: #selector(openTrailer(_:)))
                tapGesture.customValue = $0.key
                buttonPlay.addGestureRecognizer(tapGesture)
            }
        }).disposed(by: bag)
        
        viewModel.movie.subscribe(onNext: { result in
            self.movieTitle.text = result.title
            self.moviePlaytime.text = result.release_date
            self.movieGenre.text = String(result.popularity)
            self.movieOverview.text = result.overview
            self.movieImage.sd_setImage(with: URL(string: "\(Constants.urlImage)\(result.poster_path ?? "/oBgWY00bEFeZ9N25wWVyuQddbAo.jpg")"))
        }).disposed(by: bag)
        
        viewModel.loadingState.observe { result in
            result == true ? self.progress.show(in: self.view) : self.progress.dismiss()
        }
        
        viewModel.errorMessage.observe { result in
            !result.isEmpty ? print("ERROR: \(result)") : print("cool")
        }
    }
    
    @objc private func backButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func openTrailer(_ sender: CustomTapGesture) {
        guard let key = sender.customValue else { return }
        
        guard let url = URL(string: "\(Constants.youtubeUrl + key)") else { return }
        present(SFSafariViewController(url: url), animated: true, completion: nil)

    }

}

extension DetailViewController: UICollectionViewDelegateFlowLayout {
    
    func bindCastList() {
        viewModel.casts.bind(to: castList.rx.items(cellIdentifier: "castCell", cellType: CastCell.self)) { (row, item, cell) in
            cell.set(cast: item)
        }.disposed(by: bag)
        
        castList.rx.modelSelected(Cast.self).subscribe(onNext: { item in
            print("selected cast: \(item)")
        }).disposed(by: bag)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.width/2.5, height: collectionView.width/2)
    }
    
    
    func addLayoutAndSubViews() {
        view.backgroundColor = UIColor(named: "BackgroundColor")
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        scrollView.frame = view.bounds
        contentView.frame = scrollView.bounds
        scrollView.contentSize = CGSize(width: self.view.bounds.width, height: self.view.bounds.height + 800)
                
        [movieImage, gradientView, movieTitle, movieGenre, moviePlaytime, buttonPlay, buttonFavorite, movieOverview, backButton, castLabel, castList].forEach { contentView.addSubview($0) }
                
        backButton.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 10, left: 20, bottom: 0, right: 0))
        
        gradientView.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: view.width, height: 563))
        
        movieImage.anchor(top: contentView.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, size: .init(width: view.width, height: 563))
        
        movieTitle.anchor(top: contentView.safeAreaLayoutGuide.topAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 439, left: 20, bottom: 0, right: 0), size: .init(width: contentView.width, height: 0))
        
        moviePlaytime.anchor(top: movieTitle.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 9, left: 20, bottom: 0, right: 0))
        
        movieGenre.anchor(top: moviePlaytime.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 9, left: 20, bottom: 0, right: 0))
        
        buttonPlay.anchor(top: movieGenre.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: nil, padding: .init(top: 24, left: 20, bottom: 0, right: 0),size: .init(width: 180, height: 38))
        
        buttonFavorite.anchor(top: movieGenre.bottomAnchor, leading: nil, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 24, left: 0, bottom: 0, right: 20), size: .init(width: 180, height: 38))
        
        movieOverview.anchor(top: buttonPlay.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 0, right: 20))
        
        castLabel.anchor(top: movieOverview.bottomAnchor, leading: contentView.leadingAnchor, bottom: castList.topAnchor, trailing: contentView.trailingAnchor, padding: .init(top: 20, left: 20, bottom: 20, right: 20))
        
        castList.anchor(top: castLabel.bottomAnchor, leading: contentView.leadingAnchor, bottom: nil, trailing: contentView.trailingAnchor, padding: .init(top: 0, left: 20, bottom: 20, right: 20), size: .init(width: contentView.width, height: 200))
        
    }
}
