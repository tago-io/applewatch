//
//  HostingController.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/19/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import WatchKit
import Foundation
import SwiftUI

class HostingController: WKHostingController<AnyView> {
    override var body: AnyView {
        let managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistenContainer.viewContext
        let initView = InitView().environment(\.managedObjectContext, managedObjectContext)
        
        return AnyView(initView)
    }
}
