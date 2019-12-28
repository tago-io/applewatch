//
//  InitView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import CoreData

struct InitView: View {
    @State var token : String = getFirstToken()
    
    @ViewBuilder
    var body: some View {
        if token == "" {
            SetupView(token: $token)
        } else {
            NavigationHorizontalView(token: $token)
        }
    }
}

struct InitView_Previews: PreviewProvider {
    static var previews: some View {
        InitView()
    }
}
