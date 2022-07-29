//
//  Settings.swift
//  Mediarr
//
//  Created by David Sudar on 11/7/2022.
//

import SwiftUI
import Combine

struct Settings: View {
    @EnvironmentObject var settings: SettingsStore
    
//    init(){
//        UITableViewCell.appearance().backgroundColor = UIColor.clear
//    }
    
    var body: some View {
        ZStack{
            Color("Primary").ignoresSafeArea()
        List {
            Section(header: Text("Sonarr Settings")) {
                HStack() {
                    Text("Host:")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("192.168.1.2", text: $settings.sonarrHost)
                }
                HStack {
                    Text("Port:")
                        .font(.callout)
                        .bold()
                    TextField("8989", value: $settings.sonarrPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("Api Key:")
                        .font(.callout)
                        .bold()
                    TextField("192.168.1.2", text: $settings.sonarrApiKey)
                }
            }.listRowBackground(Color("Secondary"))
            
            Section(header: Text("Radarr Settings")) {
                HStack() {
                    Text("Host:")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("192.168.1.2", text: $settings.radarrHost)
                }
                HStack {
                    Text("Port:")
                        .font(.callout)
                        .bold()
                    TextField("7878", value: $settings.radarrPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("Api Key:")
                        .font(.callout)
                        .bold()
                    TextField("192.168.1.2", text: $settings.radarrApiKey)
                }
            }.listRowBackground(Color("Secondary"))
            
            Section(header: Text("SABnzbd Settings")) {
                HStack() {
                    Text("Host:")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("192.168.1.2", text: $settings.sabnzbdHost)
                }
                HStack {
                    Text("Port:")
                        .font(.callout)
                        .bold()
                    TextField("8080", value: $settings.sabnzbdPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("API Key:")
                        .font(.callout)
                        .bold()
                    TextField("API Key", text: $settings.sabnzbdApiKey)
                }
            }.listRowBackground(Color("Secondary"))
            
            Section(header: Text("Transmission Settings")) {
                HStack() {
                    Text("Host:")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("192.168.1.2", text: $settings.transmissionHost)
                }
                HStack {
                    Text("Port:")
                        .font(.callout)
                        .bold()
                    TextField("9091", value: $settings.transmissionPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("Username:")
                        .font(.callout)
                        .bold()
                    TextField("username", text: $settings.transmissionUsername)
                }
                HStack {
                    Text("Password:")
                        .font(.callout)
                        .bold()
                    SecureInputView("password", text: $settings.transmissionPassword)
                }

            }.listRowBackground(Color("Secondary"))
            
            Section(header: Text("Synology Settings")) {
                HStack() {
                    Text("Host:")
                        .font(.callout)
                        .bold()
                    Spacer()
                    TextField("192.168.1.2", text: $settings.nasHost)
                }
                HStack {
                    Text("Port:")
                        .font(.callout)
                        .bold()
                    TextField("8080", value: $settings.nasPort, formatter: NumberFormatter())
                        .keyboardType(.numberPad)
                }
                HStack {
                    Text("Username:")
                        .font(.callout)
                        .bold()
                    TextField("API Key", text: $settings.nasUsername)
                }
                HStack {
                    Text("Password:")
                        .font(.callout)
                        .bold()
                    SecureInputView("password", text: $settings.nasPassword)
                }
            }.listRowBackground(Color("Secondary"))

        }
        .scrollContentBackground(.hidden)
        .navigationBarTitle("Settings")
    }
            
        //            Form {
        //                Section(header: Text("Sonarr Settings")) {
        //                    TextField("Host", text: $settings.sonarrHost)
        //                    TextField("Port", text: $settings.sonarrPort)
        //                    TextField("Api Key", text: $settings.sonarrApiKey)
        //                }
        //                Section(header: Text("Radarr Settings")) {
        //                    TextField("Host", text: $settings.radarrHost)
        //                    TextField("Port", text: $settings.radarrPort)
        //                    TextField("Api Key", text: $settings.radarrApiKey)
        //                }
        //                Section(header: Text("Transmission Settings")) {
        //                    HStack{
        //                        Text("Host")
        //                        Spacer()
        //                        TextField("Host", text: $settings.transmissionHost)
        //                    }
        //                    VStack(alignment: .leading) {
        //                        Text("Port")
        //                        TextField("Port", value: $settings.transmissionPort, formatter: NumberFormatter())
        //                            .keyboardType(.numberPad)
        //                    }
        //                    TextField("Username", text: $settings.transmissionUsername).textInputAutocapitalization(.never)
        //                    SecureInputView("Password", text: $settings.transmissionPassword)
        //                }
        //                Section(header: Text("sabnzbd Settings")) {
        //                    TextField("Host", text: $settings.sabnzbdHost)
        //                    TextField("Port", value: $settings.sabnzbdPort, formatter: NumberFormatter())
        //                        .keyboardType(.numberPad)
        //                    TextField("Username", text: $settings.sabnzbdUsername).textInputAutocapitalization(.never)
        //                    SecureInputView("Password", text: $settings.sabnzbdPassword)
        //                }
        //            }
        //
        //        }
    }
    
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        let settings = SettingsStore()
        NavigationView{
            Settings().environmentObject(settings)
        }
    }
}
