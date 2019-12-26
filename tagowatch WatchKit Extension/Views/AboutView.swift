//
//  AboutView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    var token = getFirstToken()

    var body: some View {
        VStack {
            Text("Using token:")
            Text("\(self.token)")
                .font(.footnote)
                .fontWeight(.thin)
                .lineLimit(3)
            Divider()
//            Text("Last sync was:")
//            Text("4PM 2019-12-29")
//                .font(.footnote)
//                .fontWeight(.thin)
//            Divider()
            Text("TagoIO")
                .font(.caption)
                .foregroundColor(Color.blue)
                .padding(.top, 5.0)
                
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView()
    }
}
