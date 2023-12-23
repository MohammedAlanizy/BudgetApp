//
//  TransactionModel.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import SwiftUI

struct TransactionModel: Identifiable, Equatable {
    var id: UUID = UUID()
    var itemId: Int = 0
    var name: String = ""
    var price: String = ""
    var icon: String = ""
    init(dict: NSDictionary) {
        self.itemId  = dict.value(forKey: "id") as? Int ?? 0
        self.name = dict.value(forKey: "name") as? String ?? ""
        self.price = dict.value(forKey: "price") as? String ?? ""
        self.icon = dict.value(forKey: "icon") as? String ?? ""
    }
}
