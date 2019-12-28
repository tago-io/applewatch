//
//  AboutView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI

struct AboutView: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @Binding var token : String
    @State var showsAlert = false
    
    func resetToken() {
        self.token = ""
        self.presentationMode.wrappedValue.dismiss()
        deleteAllTokens()
    }

    var body: some View {
        VStack {
            Text("Using token:")
            Text("\(self.token)")
                .font(.footnote)
                .fontWeight(.thin)
                .lineLimit(3)
            Button(action: {
                self.showsAlert = true
            }, label: { Text("Reset Token") }).accentColor(.red)
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
                
        }.alert(isPresented: self.$showsAlert) {
            Alert(title: Text("Are you sure?"), primaryButton: Alert.Button.default(Text("No"), action: {
                self.showsAlert = false
            }), secondaryButton: Alert.Button.default(Text("Yes"), action: {
                self.showsAlert = false
                self.resetToken()
            }))
        }
    }
}

struct AboutView_Previews: PreviewProvider {
    static var previews: some View {
        AboutView(token: .constant("XXX-QQQ-WWW"))
    }
}
