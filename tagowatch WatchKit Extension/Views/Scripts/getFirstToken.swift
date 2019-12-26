//
//  GetFirstToken.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import CoreData

func getFirstToken() -> String {
    let managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistenContainer.viewContext
    let request = NSFetchRequest<NSFetchRequestResult>(entityName: "TSystem")
    request.fetchLimit = 1
    
    let result = try! managedObjectContext.fetch(request) as! [TSystem]
    
    return result.first?.token ?? ""
}
