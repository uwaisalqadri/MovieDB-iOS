//
//  AppAssembler.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/06/21.
//

import Foundation

protocol Assembler: HomeAssembler,
                    DetailAssembler,
                    FavoriteAssembler,
                    SearchAssembler {}

class AppAssembler: Assembler {}
