//
//  NavigationHorizontalView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI

//struct NavigationHorizontalViewBkp: View {
//    @State var page: Int = 1
//    @State var gestueStarted: Bool = false
//    let views: [Any] = [CommandsView.self, VariablesView.self, AboutView.self]
//    
//    func updatePage(position: String) {
//        if self.gestueStarted == true {
//            return
//        }
//        self.gestueStarted = true
//        
//        switch position {
//        case "next":
//            if self.page < 2 {
//                self.page += 1
//            }
//            break;
//        case "previus":
//            if self.page > 0 {
//                self.page -= 1
//            }
//            break;
//        default:
//            return
//        }
//    }
//    
//    func buildView(types: [Any], index: Int) -> AnyView {
//        switch types[index].self {
//        case is CommandsView.Type: return AnyView( CommandsView() )
//        case is VariablesView.Type: return AnyView( VariablesView() )
//        case is AboutView.Type: return AnyView( AboutView() )
//        default: return AnyView(EmptyView())
//        }
//    }
//    
//    var body: some View {
//        VStack() {
//            self.buildView(types: self.views, index: self.page)
//            Spacer()
//            HStack(alignment: .bottom, spacing: 0.1) {
//                ForEach(0...2, id: \.self) { p in
//                    Circle()
//                        .frame(height: 6.0)
//                        .foregroundColor(self.page == p ? Color.white : Color.gray)
//                }
//            }
//            .padding(.top)
//            .frame(width: 40.0)
//        }
//        .gesture(DragGesture().onEnded({ _ in
//            self.gestueStarted = false
//        }).onChanged({ (value) in
//            print(value.translation.width)
//            if value.translation.width >= 50.0 {
//                self.updatePage(position: "previus")
//            }
//            
//            if value.translation.width <= -50.0 {
//                self.updatePage(position: "next")
//            }
//        }))
//    }
//}

struct NavigationHorizontalView: View {
    @Binding var token : String

    var body: some View {
        VStack {
            Image("tago_white").resizable().aspectRatio(contentMode: .fit).frame(width: 100, height: 30)
            List {
                NavigationLink("Variables", destination: VariablesView())
                NavigationLink("Commands", destination: CommandsView())
                NavigationLink("Info", destination: AboutView(token: $token))
            }
        }.navigationBarHidden(true)
    }
}

struct NavigationHorizontalView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationHorizontalView(token: .constant("XXX-QQQ"))
    }
}
