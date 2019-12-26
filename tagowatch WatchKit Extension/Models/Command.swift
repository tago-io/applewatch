//
//  Commands.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/23/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import CoreData

@objc(Command)
class Command: NSManagedObject, Identifiable {
    @NSManaged var name: String
    @NSManaged var variable: String
    @NSManaged var value: String
    @NSManaged var type: String
}

extension Command {
    static func getAllCommand() -> NSFetchRequest<Command> {
        let request:NSFetchRequest<Command> = Command.fetchRequest() as! NSFetchRequest<Command>
        
        let sortDescription = NSSortDescriptor(key: "name", ascending: true)
        
        request.sortDescriptors = [sortDescription]
        
        return request
    }
}
