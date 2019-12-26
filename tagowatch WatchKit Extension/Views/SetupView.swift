//
//  SetupView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import Alamofire
import CoreData

let URLMIDDLEWARE = "https://o11uqkkt1i.execute-api.us-east-1.amazonaws.com/prod"

struct CodePost: Encodable {
    let code: String
}

struct MiddlewareResponseForCode: Decodable { let code: String }

struct SetupView: View {
    @Binding var token : String
    
    let CODE = String(UUID.init().uuidString.split(separator: "-")[0]);
    
    func resolveToken() {
        let hasToken = getFirstToken()
        if hasToken != "" {
            return
        }
        
        let managedObjectContext = (WKExtension.shared().delegate as! ExtensionDelegate).persistenContainer.viewContext
        
        AF.request(URLMIDDLEWARE, method: .post, parameters: CodePost(code: self.CODE), encoder: JSONParameterEncoder.default).responseDecodable(of: MiddlewareResponseForCode.self) { response in
            let token = response.value?.code ?? ""
            debugPrint(token)
            
            
            if token == "" {
                self.resolveToken()
            } else {
                let tokenObj = TSystem(context: managedObjectContext)
                tokenObj.token = token
                self.token = token;
                do {
                    try managedObjectContext.save()
                } catch {
                    debugPrint(error)
                }
            }
        }
    }
    
    var body: some View {
        VStack {
            Image("tago_white").resizable().aspectRatio(contentMode: .fit).frame(height: 50)
            Divider()
            Text("Your code:").padding(.bottom)
            Text(self.CODE).bold()
            ActivityIndicatorByHand().frame(width: 20, height: 20).onAppear {
                self.resolveToken()
            }
        }
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView(token: .constant(""))
    }
}
