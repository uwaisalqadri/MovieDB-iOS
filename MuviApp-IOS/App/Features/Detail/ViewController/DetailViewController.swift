//
//  DetailViewController.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import UIKit

class DetailViewController: UIViewController {

  @IBOutlet weak var imgPoster: UIImageView!
  @IBOutlet weak var clCast: UICollectionView!
  @IBOutlet weak var lblTitle: UILabel!
  @IBOutlet weak var lblDate: UILabel!
  @IBOutlet weak var lblGenre: UILabel!
  @IBOutlet weak var btnFavorite: UIButton!

  private let navigator: DetailNavigator

  init(navigator: DetailNavigator) {
    self.navigator = navigator
    super.init(nibName: "DetailViewController", bundle: nil)
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  override func viewWillAppear(_ animated: Bool) {
    setNavigationBar(type: .backTransparent)
  }

  override func leftNavigationBarButtonTapped(sender: UIBarButtonItem?) {
    navigationController?.popViewController(animated: true)
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    configureViews()
  }

  private func configureViews() {
    clCast.delegate = self
    clCast.dataSource = self
    clCast.register(cellType: CastCell.self)

    btnFavorite.layer.borderColor = UIColor.lightGray.cgColor
  }

  @IBAction func didTapWatchTrailer(_ sender: Any) {
    print("watch")
  }

  @IBAction func didTapFavorite(_ sender: Any) {
    print("favorite")
  }
}


extension DetailViewController: UICollectionViewDataSource {
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return 7
  }

  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell: CastCell = collectionView.dequeueReusableCell(for: indexPath)
    return cell
  }
}

extension DetailViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    return CGSize(width: 200, height: 200)
  }

}
