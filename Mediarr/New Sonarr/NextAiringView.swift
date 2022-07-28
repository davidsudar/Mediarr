//
//  NextAiringView.swift
//  Mediarr
//
//  Created by David Sudar on 13/7/2022.
//

import SwiftUI

struct NextAiringView: View {
    @ObservedObject var vm: SonarrViewModel
    @EnvironmentObject var settings: SettingsStore
    @State var searchText: String = ""
    @State var endDate: Date = Date().endOfMonth()
    @State var scrollviewOffset: CGFloat = 0
    
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 0) {
            NextAiringItemNavigationView(searchText: $searchText, endDate: $endDate)
                .onChange(of: endDate) { newValue in
                    withAnimation(.easeInOut(duration: 0.8))
                    {
//                        print(newValue)
                        vm.getUpcoming(with: settings, endDate: newValue)
                    }
                }
                .background(Color("Secondary"))
            ZStack {
                RefreshableScroll(tintColor: Color.accentColor, content:{
                    VStack{
                        
                        let sortedKeys = vm.upcomingDict.keys.sorted { GetDateFromStringDay(date: $0).compare(GetDateFromStringDay(date: $1)) == .orderedAscending}
                        if sortedKeys.count == 0 {
                            Text("No new shows this week")
                        }
                        else {
                            ForEach(0 ..< sortedKeys.count, id:\.self) {value in
                                HStack {
                                    VStack (alignment: .leading, spacing: 1)
                                    {
                                        Text(sortedKeys[value])
                                            .frame(alignment: .leading)
                                            .font(.system(size: 20, weight: .bold, design: .default))
                                        Rectangle()
                                            .foregroundColor(Color.accentColor)
                                            .frame(width: 200, height: 2)
                                        
                                    }
                                    Spacer()
                                }
                                VStack {
                                    ForEach(0 ..< vm.upcomingDict[sortedKeys[value]]!.count, id:\.self) { valueShow in
                                        NextAiringShowView(show: vm.upcomingDict[sortedKeys[value]]![valueShow])
                                        
                                    }
                                }
                            }
                            Spacer()
                        }
                        
                    }
                })
                {
                    vm.getUpcoming(with: settings, endDate: endDate)
                    do {
                        try await Task.sleep(nanoseconds: 2_000_000_000)
                    }
                    
                    catch{
                        print("error")
                    }
                }
                .padding(.horizontal, 12)
                .padding(.top, 10)
                .modifier(BackgroundColorStyle())
            }
        }
    }
}

struct NextAiringView_Previews: PreviewProvider {
    static var previews: some View {
        let endDate = Date()
        NextAiringView(vm: SonarrViewModel(), endDate: endDate)
    }
}
