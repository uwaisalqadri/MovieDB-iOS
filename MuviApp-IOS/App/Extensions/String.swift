//
//  String.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 05/10/21.
//

import Foundation

extension String {
  func formatDate(withFormat format: String = "dd MM yyyy", sourceFormat: String = "dd-MM-yyyy") -> String {
     let dateFormatter = DateFormatter()
     dateFormatter.dateFormat = sourceFormat

     let formatter = DateFormatter()
     formatter.dateFormat = format
     formatter.locale = Locale.init(identifier: "id_ID")


     return formatter.string(from: dateFormatter.date(from: self) ?? Date())
   }

}
