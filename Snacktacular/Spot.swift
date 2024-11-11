//
//  Spot.swift
//  Snacktacular
//
//  Created by Aimee Hong on 11/10/24.
//

import Foundation
import FirebaseFirestore

struct Spot: Identifiable, Codable {
    @DocumentID var id: String?
    var name = ""
    var address = ""
}


