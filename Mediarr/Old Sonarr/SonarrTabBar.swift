//
//  SonarrTabBar.swift
//  Mediarr v2
//
//  Created by David Sudar on 15/6/2022.
//

import SwiftUI

struct SonarrTabBar: View {
    @Binding var selectedTab: String
    @State var tabPoints: [CGFloat] = []
    var body: some View {
        HStack(spacing: 0) {
            TabBarButton(image: "film", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "calendar", selectedTab: $selectedTab, tabPoints: $tabPoints)
            TabBarButton(image: "magnifyingglass", selectedTab: $selectedTab, tabPoints: $tabPoints)
        }
        .padding()
        .background(Color("Secondary").clipShape(TabCurve(tabPoint: GetCurvePoint()-15)))
        .overlay(
            Circle().fill(Color.accentColor)
                .frame(width: 10, height: 10)
                .offset(x: GetCurvePoint()-20)
            ,alignment: .bottomLeading
        )
        .cornerRadius(30)
        .padding(.horizontal)
    }
    
    func GetCurvePoint()->CGFloat {
        if tabPoints.isEmpty
        {
            return 10
        }
        else {
            switch selectedTab {
            case "film":
                return tabPoints[0]
            case "calendar":
                return tabPoints[1]
            default:
                return tabPoints[2]
            }
        }
    }
}

struct TabBarButton: View {
    var image: String
    @Binding var selectedTab: String
    @Binding var tabPoints: [CGFloat]
    var body: some View {
        GeometryReader { reader -> AnyView in
            let midX = reader.frame(in: .global).midX
            DispatchQueue.main.async {
                switch image {
                case "film":
                    if tabPoints.count > 0
                    {
                    tabPoints[0] = midX
                    }
                    else
                    {
                        tabPoints.append(midX)
                    }
                case "calendar":
                    if tabPoints.count > 1
                    {
                    tabPoints[1] = midX
                    }
                    else
                    {
                        tabPoints.append(midX)
                    }
                default:
                    if tabPoints.count > 2
                    {
                    tabPoints[2] = midX
                    }
                    else
                    {
                        tabPoints.append(midX)
                    }
                }
            }
            return AnyView(
                Button(action: {
                    withAnimation(.easeInOut) {
                        selectedTab = image
                    }
                }, label: {
                    Image(systemName: image)
                        .font(.system(size: 25, weight: .semibold))
                        .foregroundColor(.accentColor)
                        .offset(y: selectedTab == image ? -10 : 0)
                })
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            )
        }
        .frame(height: 30)
    }
}

struct TabCurve: Shape {
    var tabPoint: CGFloat
    
    var animatableData: CGFloat {
        get{return tabPoint}
        set{tabPoint = newValue}
    }
    func path(in rect: CGRect) -> Path {
        return Path{path in
            path.move(to: CGPoint(x: rect.width, y: rect.height))
            path.addLine(to: CGPoint(x: rect.width, y: 0))
            path.addLine(to: CGPoint(x: 0, y: 0))
            path.addLine(to: CGPoint(x: 0, y: rect.height))
            
            let mid = tabPoint
            path.move(to: CGPoint(x: mid - 40, y: rect.height))
            
            let to = CGPoint(x: mid, y: rect.height - 20)
            let control1 = CGPoint(x: mid - 15, y: rect.height)
            let control2 = CGPoint(x: mid - 15, y: rect.height - 20)
            
            let to1 = CGPoint(x: mid + 40, y: rect.height)
            let control3 = CGPoint(x: mid + 15, y: rect.height - 20)
            let control4 = CGPoint(x: mid + 15, y: rect.height)
            
            path.addCurve(to: to, control1: control1, control2: control2)
            path.addCurve(to: to1, control1: control3, control2: control4)
        }
    }
}

struct SonarrTabBar_Previews: PreviewProvider {
    static var previews: some View {
        SonarrTabBar(selectedTab: .constant("film"))
    }
}
