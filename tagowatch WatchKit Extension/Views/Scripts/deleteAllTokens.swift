//
//  deleteAllTokens.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/27/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import CoreData

func deleteAllTokens() -> Void {
    let managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistenContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TSystem")
    
    let result = try! managedObjectContext.fetch(request) as! [TSystem]
    
   for item in result {
        managedObjectContext.delete(item)
    }
    
    do {
        try managedObjectContext.save()
    } catch {
        print(error)
    }
}
