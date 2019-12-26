//
//  TSystem.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/19/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import CoreData

@objc(TSystem)
class TSystem: NSManagedObject {
    @NSManaged var token: String
}
