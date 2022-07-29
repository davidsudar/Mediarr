//
//  ContentView.swift
//  Mediarr
//
//  Created by David Sudar on 11/7/2022.
//

import SwiftUI
import Combine
import Charts


struct HomeView: View {
    @StateObject private var settings = SettingsStore()
    @StateObject var vm = SynologyViewModel()
    @State private var timer: AnyCancellable?
    init() {
        UITableView.appearance().sectionHeaderHeight = .zero
    }
    
    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Color("Primary").ignoresSafeArea()
                VStack {
                    LazyVGrid(columns: [GridItem()], alignment: .leading, spacing: 10, content: {
                        NavigationLink(destination: SonarrHomeView().environmentObject(settings)) {
                            ZStack {
                                Color("Secondary").ignoresSafeArea()
                                HStack{
                                    Image(systemName: "tv")
                                    Text("Sonarr")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding()
                            }.tint(.white)
                            
                        }
                        .cornerRadius(8)
                        
                        
                        NavigationLink(destination: Text("Radarr")) {
                            ZStack {
                                Color("Secondary").ignoresSafeArea()
                                HStack{
                                    Image(systemName: "film")
                                    Text("Radarr")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding()
                            }.tint(.white)
                        }
                        .cornerRadius(8)
                        
                        NavigationLink(destination: Text("Bazarr")) {
                            ZStack {
                                Color("Secondary").ignoresSafeArea()
                                HStack{
                                    Image(systemName: "captions.bubble")
                                    Text("Bazarr")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding()
                            }
                            .tint(.white)
                        }
                        .cornerRadius(8)
                        
                        NavigationLink(destination: Text("SABnzbd")) {
                            ZStack {
                                Color("Secondary").ignoresSafeArea()
                                HStack{
                                    Image(systemName: "arrow.down")
                                    Text("SABnzbd")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding()
                            }.tint(.white)
                        }
                        .cornerRadius(8)
                        
                        NavigationLink(destination: Text("Bazarr")) {
                            ZStack {
                                Color("Secondary").ignoresSafeArea()
                                HStack{
                                    Image(systemName: "arrow.down")
                                    Text("Transmission")
                                    Spacer()
                                    Image(systemName: "chevron.right")
                                }.padding()
                            }
                            .tint(.white)
                        }
                        .cornerRadius(8)
                        
                    })
                    .padding()
                    .modifier(BackgroundColorStyle())
                    //                    Spacer()
                    ZStack {
                        Color("Secondary").ignoresSafeArea()
                        VStack(alignment: .leading, spacing: 5) {
                            if vm.utilisation == nil && vm.storage == nil {
                                VStack{
                                    Text("NAS")
                                        .font(.title)
                                        .padding()
                                    LoadingAnimation()
                                }
                                .onReceive(self.vm.$auth, perform: { auth in
                                    if auth != nil {
                                        vm.getStorage(with: settings)
                                        DispatchQueue.global(qos: .background).async {
                                            startTimer()
                                        }
                                        
                                    }
                                })
                            }
                            else {
                                Text("NAS")
                                    .font(.title)
                                    .padding()
                                VStack{
                                    let usedSpace =  (vm.storage?.data.shares.first(where: {$0.name == "Data"})?.additional.volume_status.totalspace ?? 0) - (vm.storage?.data.shares.first(where: {$0.name == "Data"})?.additional.volume_status.freespace ?? 0)
                                    ProgressView("Storage", value: Double(usedSpace), total: Double(vm.storage?.data.shares.first(where: {$0.name == "Data"})?.additional.volume_status.totalspace ?? 100))
                                    
                                    HStack{
                                        Spacer()
                                        
                                        Text(GetShowFileSize(bytes: usedSpace) + "/" + GetShowFileSize(bytes: vm.storage?.data.shares.first(where: {$0.name == "Data"})?.additional.volume_status.totalspace ?? 0)).font(.system(size: 12, weight: .light, design: .default))
                                    }
                                }
                                .padding(.horizontal)
                                
                                
                                VStack{
                                    ProgressView("CPU", value: 1, total: 100)
                                    HStack{
                                        Spacer()
                                        
                                        Text(String((vm.utilisation?.data.cpu.system_load ?? 0) + (vm.utilisation?.data.cpu.user_load ?? 0)) + "%")
                                            .font(.system(size: 12, weight: .light, design: .default))
                                    }
                                }
                                .padding(.horizontal)
                                VStack{
                                    ProgressView("RAM", value: 25, total: 100)
                                    HStack{
                                        Spacer()
                                        
                                        Text(String(vm.utilisation?.data.memory.real_usage ?? 0) + "%")
                                            .font(.system(size: 12, weight: .light, design: .default))
                                    }
                                }
                                .padding(.horizontal)
                                VStack(alignment: .leading) {
                                    Text("Network")
                                    Chart {
                                        ForEach(vm.networkHistory, id: \.type) { series in
                                            ForEach(series.data, id: \.self) { item in
                                                LineMark(
                                                    x: .value("Time", item.date),
                                                    y: .value("Speed", item.speed)
                                                )
                                                
                                            }
                                            .foregroundStyle(by: .value("Type", series.type))
                                            .lineStyle(StrokeStyle(lineWidth: 2))
                                            .interpolationMethod(.catmullRom)
                                        }
                                    }
                                    .chartYAxis {
                                        AxisMarks(position: .trailing, values: .automatic) { value in
                                            AxisGridLine(centered: true, stroke: StrokeStyle(lineWidth: 1))
                                            AxisValueLabel() {
                                                if let intValue = value.as(Int.self) {
                                                    Text(GetShowFileSize(bytes: intValue)+"/s")
                                                    .font(.system(size: 10))
                                                }
                                            }
                                        }
                                    } 
                                    .chartXAxis(.hidden)
                                    
                                    
                                    
                                }.padding()
                            }
                            Spacer()
                        }
                    }
                    .cornerRadius(8)
                    .padding()
                }
                .onAppear(perform: {
                    vm.getSid(with: settings)
                })
            }
            
            .navigationTitle("Dashboard")
            .navigationBarTitleDisplayMode(.inline)
            //latest beta broke this
            //            .toolbarBackground(.visible, in: .navigationBar, .tabBar, .automatic)
            //            .toolbarBackground(Color("Secondary"), in: .navigationBar, .tabBar, .automatic)
            .toolbar(content: {
                NavigationLink(destination: Settings().environmentObject(settings)) {
                    Image(systemName: "gear")
                }
            })
            
        }
    }
    
    func startTimer() {
        //        vm.getUtilisation(with: settings)
        // start timer (tick every 10 seconds)
        timer = Timer.publish(every: 3, on: .main, in: .common)
            .autoconnect()
            .sink { _ in
                vm.getUtilisation(with: settings)                }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
