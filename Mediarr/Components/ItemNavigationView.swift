//
//  ItemNavigationView.swift
//  Mediarr v2
//
//  Created by David Sudar on 9/6/2022.
//

import SwiftUI

struct ItemNavigationView: View {
    @Binding var searchText: String
    @Binding var sortMode: sortModeViewModel
    @Binding var gridView: GridLayoutViewModel
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack {
                    Rectangle()
                        .foregroundColor(Color("Primary"))
                    HStack {
                        Image(systemName: "magnifyingglass").foregroundColor(.accentColor)
                        TextField("Search", text: $searchText){
                            
                        }
                        if isEditing && self.searchText != "" {
                            Button(action: {
                                self.searchText = ""
                                UIApplication.shared.endEditing()
                            }, label:
                                    {
                                Image(systemName: "multiply.circle.fill")
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 8)
                            })
                        }
                    }
                    .foregroundColor(self.searchText == "" ? .gray : .white)
                    .padding(.leading, 13)
                    
                }.onTapGesture {
                    self.isEditing = true
                }
                .frame(height: 40)
                .cornerRadius(13)
                Menu {
                    ForEach(sortModeViewModel.allCases, id: \.self) { option in
                        Button {
                            sortMode = option
                        } label: {
                            Text(option.title)
                            Image(systemName: option.imageName)
                        }
                    }
                } label: {
                    ZStack {

                        Rectangle()
                            .foregroundColor(Color("Primary"))
                            .frame(width: 40, height: 40)
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundColor(.accentColor)
                    }
                    .frame(height: 40)
                    .cornerRadius(13)

                }
//                Menu {
//                    ForEach(filterModeViewModel.allCases, id: \.self) { option in
//                        Button {
//                        } label: {
//                            Text(option.title)
//                            Image(systemName: option.imageName)
//                            if option.subMenus.count > 0
//                            {
//                                Menu {
//                                    ForEach(0 ..< option.subMenus.count, id: \.self) {value in
//                                        Button {
//                                        } label: {
//                                            Text(option.subMenus[value])
//                                        }
//                                    }
//                                } label: {
//                                    ZStack {
//
//                                        Rectangle()
//                                            .foregroundColor(Color(.tertiaryLabel))
//                                            .frame(width: 40, height: 40)
//                                        Image(systemName: "line.3.horizontal.decrease.circle")
//                                            .foregroundColor(.accentColor)
//                                    }
//                                    .frame(height: 40)
//                                    .cornerRadius(13)
//
//                                }
//                            }
//                        }
//                    }
//                } label: {
//                    ZStack {
//
//                        Rectangle()
//                            .foregroundColor(Color("Primary"))
//                            .frame(width: 40, height: 40)
//                        Image(systemName: "line.3.horizontal.decrease.circle")
//                            .foregroundColor(.accentColor)
//                    }
//                    .frame(height: 40)
//                    .cornerRadius(13)
//
//                }
                Button {
                    if gridView == .gridView
                    {
                        gridView = .blockView
                    }
                    else
                    {
                        gridView = .gridView
                    }
                } label: {
                    ZStack {
                        Rectangle()
                            .foregroundColor(Color("Primary"))
                            .frame(width: 40, height: 40)
                        Image(systemName: gridView.imageName)
                    }
                    .frame(height: 40)
                    .cornerRadius(13)
                }
            }
            .padding()
        }
    }
}

struct ItemNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        ItemNavigationView(searchText: .constant("Search"), sortMode: .constant(.alphabetical), gridView: .constant(.blockView))
    }
}
