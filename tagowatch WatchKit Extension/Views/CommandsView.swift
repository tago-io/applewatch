//
//  CommandsView.swift
//  tagowatch WatchKit Extension
//
//  Created by Felipe Lima on 12/20/19.
//  Copyright © 2019 TagoIO. All rights reserved.
//

import SwiftUI
import Alamofire

struct TagoDataPost: Encodable {
    let variable: String
    let value: String
}

struct DataPostResponse: Decodable {
    let result: String!
    let status: Bool
    let message: String!
}

struct CommandsView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @FetchRequest(fetchRequest: Command.getAllCommand()) var commands:FetchedResults<Command>
    
    @State var loadingAt : Command! = nil
    @State var showsAlert = false
    @State var errorMessage = ""
    
    @State var deleteAlert = false
    @State var commandToDel : Command! = nil
    
    let headers: HTTPHeaders = [
        "Token": getFirstToken(),
        "Accept": "application/json"
    ]
    
    func sendData(variable: String, value: String) {       
        let data = TagoDataPost(variable: variable, value: value)
        AF.request("https://api.tago.io/data", method: .post, parameters: data, encoder: JSONParameterEncoder.default, headers: headers).responseDecodable(of: DataPostResponse.self) { response in
            self.loadingAt = nil
            if response.value?.status == false && response.value?.message != nil {
                self.errorMessage = response.value!.message
                self.showsAlert = true
            }
        }
    }
    
    var body: some View {
        VStack {
            ScrollView {
                ForEach(self.commands) { commandItem in
                    HStack {
                        Button(action: {
                            self.loadingAt = commandItem
                            self.sendData(variable: commandItem.variable, value: commandItem.value)
                        }, label: {
                            if self.loadingAt == commandItem {
                                ActivityIndicatorByHand().frame(width: 20, height: 20)
                            } else {
                                Text(commandItem.name).lineLimit(1)
                            }
                        })
                        Button(action: {
                            self.commandToDel = commandItem
                            self.deleteAlert = true
                        }, label: {
                            Image(systemName: "trash")
                        }).frame(width: 30).accentColor(Color.red)
                    }
                }.alert(isPresented: self.$deleteAlert) {
                    Alert(title: Text("Are you sure?"), message: Text(self.commandToDel.name), primaryButton: Alert.Button.default(Text("Cancel"), action: {
                        self.deleteAlert = false
                    }), secondaryButton: Alert.Button.default(Text("Delete it"), action: {
                        self.managedObjectContext.delete(self.commandToDel)
                        do {
                            try self.managedObjectContext.save()
                        } catch {
                            print(error)
                        }
                        self.deleteAlert = false
                    }))
                }
                Divider().alert(isPresented: self.$showsAlert) {
                    Alert(title: Text("Server error"), message: Text("\(self.errorMessage)"), dismissButton: .default(Text("Close")))
                }
                NavigationLink("Add new command", destination: SetupNewCommandView()).foregroundColor(.white).accentColor(.blue)
            }
        }.navigationBarTitle(Text("Commands"))
    }
}

struct SetupNewCommandView: View {
    @Environment(\.managedObjectContext) var managedObjectContext
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @State var commandName : String = ""
    @State var commandVariableName : String = ""
    @State var commandValue : String = ""
    @State var commandType : String = "string"
    
    @State var showsAlert = false
    @State var errorMessage = ""
    
    func checkField(fieldValue: String, fieldName: String) -> Bool {
        if fieldValue == "" {
            self.errorMessage = fieldName
            self.showsAlert = true
            return false
        }
        return true
    }
    
    var body: some View {
        VStack {
            Form {
                TextField("Command name", text: $commandName)
                TextField("Variable name", text: $commandVariableName)
                TextField("Variable value", text: $commandValue)
//                Picker(selection: $commandType, label: Text("Value type")) {
//                    Text("String").tag("string")
//                    Text("Number").tag("number")
//                    Text("Boolean").tag("bool")
//                }
                Button(action: {
                    if !self.checkField(fieldValue: self.commandName, fieldName: "Name") || !self.checkField(fieldValue: self.commandValue, fieldName: "Value") || !self.checkField(fieldValue: self.commandVariableName, fieldName: "Variable") { return }

                    let commandItem = Command(context: self.managedObjectContext)
                    commandItem.name = self.commandName
                    commandItem.variable = self.commandVariableName
                    commandItem.value = self.commandValue
                    commandItem.type = self.commandType

                    do {
                        try self.managedObjectContext.save()
                    } catch {
                        print(error)
                    }

                    self.presentationMode.wrappedValue.dismiss()
                    
                }, label: { Text("Add Command") }).alert(isPresented: self.$showsAlert) {
                    Alert(title: Text("Invalid field"), message: Text("\(self.errorMessage)"), dismissButton: .default(Text("Got it!")))
                }
            }
        }.navigationBarTitle(Text("New Command"))
    }
}

struct CommandsView_Previews: PreviewProvider {
    static var previews: some View {
        //        CommandsView()
        SetupNewCommandView()
    }
}
