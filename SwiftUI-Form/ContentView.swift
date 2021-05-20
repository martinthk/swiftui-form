//
//  ContentView.swift
//  SwiftUI-Form
//
//  Created by Martin Tom on 12/5/2021.
//

import SwiftUI

struct ContentView: View {
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var birthdate = Date()
    @State private var time = Date()
    @State private var shouldSendNewsletter = false
    @State private var numberOfLikes = 1
    @State private var selectedFlavor = ""
    
    let flavours = ["chocolate", "vanilla", "strawberry"]
    
    var body: some View {
        
        NavigationView{
            
            Form{
                
                Section (header: Text("Personal Information")){
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    DatePicker("Birthday", selection: $birthdate, displayedComponents: .date)
                    DatePicker("Time", selection: $time, displayedComponents: .hourAndMinute)
                }
                
                Section (header: Text("Action")){
                    Toggle("Send Newsletter", isOn: $shouldSendNewsletter)
                        .toggleStyle(SwitchToggleStyle(tint: .red))
                }
                
                Section(){
                    Stepper("Numberof Likes", value: $numberOfLikes, in: 1...100)
                    Text("This vide has \(numberOfLikes) likes")
                }
                
                Section(){
                    Text("Please choose a flavor")
                    Picker("Please choose a flavor", selection: $selectedFlavor ){
                        ForEach(flavours, id: \.self){
                            Text($0)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                Text("The chosen flavor is \(selectedFlavor)")
                Picker(selection: $selectedFlavor, label: Text("Please choose a flavor")){
                    ForEach(flavours, id: \.self){
                        Text($0)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                
                
                Section(){
                    Link("Terms of Service", destination: URL(string: "http://google.com")!)
                }
            }
            
            .navigationTitle("Account")
            
            //            Explation: onTapGesture will block other action items
            //            .onTapGesture {
            //                hideKeyboard()
            //            }
            
            .toolbar{
                ToolbarItemGroup(placement: .navigationBarTrailing){
                    Button {
                        hideKeyboard()
                    }label: {
                        Image(systemName:"keyboard.chevron.compact.down")
                    }
                    
                    Button("Save", action: saveUser)
                }
            }
        }
        .accentColor(.red)
    }
    
    func saveUser() {
        print("User Saved")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// Hide the keyboard
#if canImport(UIKit)
extension View{
    func hideKeyboard(){
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
