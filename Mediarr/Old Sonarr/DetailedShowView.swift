//
//  DetailedShowView.swift
//  Mediarr v2
//
//  Created by David Sudar on 16/6/2022.
//

import SwiftUI

struct DetailedShowView: View {
    @State var show: Series
    @State var showDetailModal: Bool = false
    
    var body: some View {
        VStack {
//            HStack{
//                Text("Details")
//                Spacer()
//                Button {
//                    self.showDetailModal = true
//                } label: {
//                    Image(systemName: "link").foregroundColor(Color.accentColor)
//                }
//            }.padding()
//                .background(Color("Secondary"))
            DetailShowView(show: show)
                .padding()
            
            Grid(alignment: .leading,
                 horizontalSpacing: 5,
                 verticalSpacing: 5){
                Group {
                    GridRow{
                        Text("Monitoring")
                            .foregroundColor(Color.gray)
                            .gridColumnAlignment(.trailing)
                        Text(String(show.monitored).capitalized)
                            .gridColumnAlignment(.leading)
                    }
                    
                    GridRow{
                        Text("Type")
                            .foregroundColor(Color.gray)
                        Text(show.seriesType.capitalized)
                    }
                    GridRow {
                        Text("Path")
                            .foregroundColor(Color.gray)
                        Text(show.path)
                    }
                    GridRow{
                        Text("Tags")
                            .foregroundColor(Color.gray)
                        if show.tags.count == 0
                        {
                            Text("-")
                        }
                        else {
                            VStack(alignment: .leading) {
                                ForEach(show.tags, id: \.self) {tag in
                                    Text(String(tag))
                                }
                            }
                        }
                    }
                }
                Group {
                    GridRow{
                        Text("Status")
                            .foregroundColor(Color.gray)
                        Text(String(show.status).capitalized)
                    }
                    
                    GridRow{
                        Text("Next Airing")
                            .foregroundColor(Color.gray)
                        Text(show.nextAiring?.capitalized ?? "Unknown")
                    }
                    GridRow {
                        Text("Added On")
                            .foregroundColor(Color.gray)
                        Text(show.added)
                    }
                }
                Group {
                    GridRow{
                        Text("Year")
                            .foregroundColor(Color.gray)
                        Text(String(show.year))
                    }
                    
                    GridRow{
                        Text("Network")
                            .foregroundColor(Color.gray)
                        Text(show.network)
                    }
                    GridRow {
                        Text("Runtime")
                            .foregroundColor(Color.gray)
                        Text(String(show.runtime)+" minutes")
                    }
                    GridRow{
                        Text("Rating")
                            .foregroundColor(Color.gray)
                        Text(String(show.certification ?? "-"))
                    }
                    GridRow {
                        Text("Genres")
                            .foregroundColor(Color.gray)
                        if show.genres.count == 0
                        {
                            Text("-")
                        }
                        else {
                            VStack(alignment: .leading){
                                ForEach(show.genres, id: \.self) {genre in
                                    Text(genre)
                                }
                            }
                        }
                    }
                    GridRow{
                        Text("Alternate Titles")
                            .foregroundColor(Color.gray)
                        Text("-")
                    }
                }
            }
                 .padding()
                 .background(Color("Secondary"))
                 .cornerRadius(20)
                 .padding()
                 .font(.system(size: 16, weight: .medium, design: .default))
            
            Spacer()
        }
    }
}

struct DetailedShowView_Previews: PreviewProvider {
    static var previews: some View {
        DetailedShowView(show: previewSeries)
    }
}
