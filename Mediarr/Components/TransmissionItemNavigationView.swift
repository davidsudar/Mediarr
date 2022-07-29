//
//  TransmissionItemNavigationView.swift
//  Mediarr v2
//
//  Created by David Sudar on 21/6/2022.
//

import SwiftUI

struct TransmissionItemNavigationView: View {
    @Binding var searchText: String
    @Binding var sortMode: transmissionSortModeViewModel
    @State private var isEditing = false
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                ZStack {
                    Rectangle()
                        .foregroundColor(Color(.tertiaryLabel))
                    HStack {
                        Image(systemName: "magnifyingglass")
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
            }
            .padding()
        }
    }
}


struct TransmissionItemNavigationView_Previews: PreviewProvider {
    static var previews: some View {
        TransmissionItemNavigationView(searchText: .constant("Search"), sortMode: .constant(.alphabetical))
    }
}
