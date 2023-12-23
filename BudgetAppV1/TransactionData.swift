//
//  TransactionData.swift
//  BudgetAppV1
//
//  Created by 𝙼 . on 10/19/23.
//

import CoreData
import Foundation

class DataManager: NSObject, ObservableObject {
    @Published var TransactionsItems: [Transactions] = [Transactions]()
    @Published var ThreeDataItems: [ThreeData] = [ThreeData]()
    let container: NSPersistentContainer = NSPersistentContainer(name: "DataModel")
    override init() {
        super.init()
        container.loadPersistentStores { _, _ in }
    }
}
