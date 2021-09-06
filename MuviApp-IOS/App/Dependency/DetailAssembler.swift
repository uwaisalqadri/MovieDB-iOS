//
//  DetailAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 22/08/21.
//

import UIKit

protocol DetailAssembler {
  func resolve(with id: Int) -> DetailViewController
  func resolve() -> DetailNavigator

  func resolve(with id: Int) -> DetailViewModel
  func resolve() -> DetailUseCase
}

extension DetailAssembler where Self: Assembler {
  func resolve(with id: Int) -> DetailViewController {
    return DetailViewController(navigator: resolve(), viewModel: resolve(with: id))
  }

  func resolve() -> DetailNavigator {
    return DefaultDetailNavigator(assembler: self)
  }

  func resolve(with id: Int) -> DetailViewModel {
    return DetailViewModel(detailUseCase: resolve(), idMovie: id)
  }

  func resolve() -> DetailUseCase {
    return Detail(repository: resolve())
  }

}
