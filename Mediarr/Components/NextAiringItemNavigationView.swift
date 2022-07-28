//
//  NextAiringItemNavigationView.swift
//  Mediarr
//
//  Created by David Sudar on 14/7/2022.
//

import SwiftUI

struct NextAiringItemNavigationView: View {
    @Binding var searchText: String
    @State private var isEditing = false
    @Binding var endDate: Date
    
    var body: some View {
        VStack(alignment: .leading){
            HStack{
                Spacer()
                    DatePicker("label", selection: $endDate, in: Date()..., displayedComponents: [.date])
                                            .datePickerStyle(CompactDatePickerStyle())
                                            .labelsHidden()
            }
            .padding()
            .padding(.bottom, 0)
        }
        
    }
}
