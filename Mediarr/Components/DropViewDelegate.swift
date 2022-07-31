//
//  DropViewDelegate.swift
//  Mediarr
//
//  Created by David Sudar on 30/7/2022.
//

import Foundation
import SwiftUI

struct DropViewDelegate: DropDelegate {
    @ObservedObject var vm = TransmissionViewModel()
    var currentItem: Torrent
    var items: Binding<[Torrent]>
    var draggingItem: Binding<Torrent?>

    func performDrop(info: DropInfo) -> Bool {
        vm.isEditing = false
        draggingItem.wrappedValue = nil // <- HERE
        return true
    }
    
    func dropEntered(info: DropInfo) {
        if currentItem.id != draggingItem.wrappedValue?.id {
            let from = items.wrappedValue.firstIndex(of: draggingItem.wrappedValue!)!
            let to = items.wrappedValue.firstIndex(of: currentItem)!
            if items[to].id != draggingItem.wrappedValue?.id {
                withAnimation(.default) {
                    items.wrappedValue.move(fromOffsets: IndexSet(integer: from),
                                            toOffset: to > from ? to + 1 : to)
                }
            }
        }
    }
    
    func dropUpdated(info: DropInfo) -> DropProposal? {
       return DropProposal(operation: .move)
    }
}
