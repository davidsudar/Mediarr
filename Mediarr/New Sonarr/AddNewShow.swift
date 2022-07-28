//
//  AddNewShow.swift
//  Mediarr v2
//
//  Created by David Sudar on 15/6/2022.
//

import SwiftUI

struct AddNewShow: View {
    
    enum FocusField: Hashable {
        case field
      }
    
    @EnvironmentObject var settings: SettingsStore
    @State private var searchText: String = ""
    @State private var isEditing = false
    @State var selectedShow: SearchSeries? = nil
    @FocusState private var focusedField: FocusField?
    @ObservedObject var vm: SonarrViewModel
    
    var body: some View {
        VStack(spacing:0) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color(.tertiaryLabel))
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("Search", text: $searchText)
                        .onSubmit {
                            vm.searchShows(with: settings, searchTerm: searchText)
                            
                        }
                        .submitLabel(.search)
                        .focused($focusedField, equals: .field)
                        .onAppear {
                                DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                                    self.focusedField = .field
                                }
                            }
                    if isEditing && self.searchText != "" {
                        Button(action: {
                            self.searchText = ""
                            UIApplication.shared.endEditing()
//                            isEditing = false
                        }, label:
                                {
                            Image(systemName: "multiply.circle.fill")
                                .foregroundColor(.gray)
                                .padding(.trailing, 8)
                        })
                    }
                }
                .foregroundColor(.gray)
                .padding(.leading, 13)
                
            }.onTapGesture {
                self.isEditing = true
            }
            
            .frame(height: 40)
            .cornerRadius(13)
            .padding()
            .background(Color("Secondary"))
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle("Add New Show")
            .onAppear(perform: {
                vm.searchResults = [SearchSeries]()
            })
            ScrollView {
                    LazyVGrid(columns: [GridItem()], alignment: .leading, spacing: 8, content: {
                            ForEach(vm.searchResults, id: \.self) { show in
                                SearchShowView(show: show)
                                    .onTapGesture {                                    self.selectedShow = show
                                    }
                        
                            
                        }
                    }).padding(.horizontal, 12)
                    .sheet(item: $selectedShow) {
                        AddNewShowDetailed(vm: vm, newShow: $0 as SearchSeries, seasonFolders: true).environmentObject(settings)
                            
                    }
            }
            .background(Color("Primary"))
        }
    }
}

struct AddNewShow_Previews: PreviewProvider {
    static var previews: some View {
        AddNewShow(vm: SonarrViewModel())
    }
}
