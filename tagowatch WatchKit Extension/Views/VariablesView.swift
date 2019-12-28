//
//  VariablesView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import Alamofire
import SwiftyJSON

let URLTAGO = "https://api.tago.io"

struct TagoVariable {
    let _id: String
    let variable: String
    let value: String
    let unit: String
}

struct VariablesView: View {
    @State var variablesTago : Array<TagoVariable>! = nil
    @State var loading : Bool = true
    
    let headers: HTTPHeaders = [
        "Token": getFirstToken(),
        "Accept": "application/json"
    ]
    
    func getLastValues() {
        self.loading = true
        self.variablesTago = nil
        AF.request("\(URLTAGO)/data?query=last_value", headers: headers).responseJSON { response in
            let json = try? JSON(data: response.data!)
            
            if json != nil && json?["result"] != nil {
                var data : Array<TagoVariable> = []
                for (key, item):(String, JSON) in json!["result"] {
                    let i = TagoVariable(_id: key, variable: item["variable"].stringValue, value: item["value"].stringValue, unit: item["unit"].stringValue)
                    data.append(i)
                }
                self.variablesTago = data
            }
            self.loading = false
        }
    }
    
    var body: some View {
        ScrollView(showsIndicators: true) {
            if self.loading {
                HStack {
                    ActivityIndicatorByHand().frame(width: 20, height: 20).padding(.top, 2)
                }
            }
            if self.variablesTago != nil && self.variablesTago.count == 0 {
                Text("Empty").font(.footnote).padding(.top, 5)
            }
            ForEach(self.variablesTago ?? [], id: \._id) { item in
                VStack {
                    Divider()
                    HStack(alignment: .center) {
                        Text("\(item.variable)")
                        Spacer()
                        Text("\(String(item.value)) \(item.unit)")
                    }
                }
            }
            Divider()
        }.navigationBarTitle(Text("Variables")).onAppear(perform: {
            self.getLastValues()
        }).padding(.horizontal, 5.0)
            .contextMenu(menuItems: {
                Button(action: {
                    self.getLastValues()
                }, label: {
                    VStack {
                        Image(systemName: "icloud.and.arrow.down.fill")
                        Text("Refresh")
                    }
                })
            })
    }
}

struct VariablesView_Previews: PreviewProvider {
    static var previews: some View {
        VariablesView()
    }
}
