//
//  NavigatedView.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/22.
//

import UIKit
import SwiftUI
import NiSFoundation

class NavigatedViewExt: ObservableObject {
    @Published var viewId: String = "View ID"
    
    @Published var onNewViewController: (() -> Void)?
    @Published var onNewView: (() -> Void)?
}

struct NavigatedView : View {
    @ObservedObject var extModel: NavigatedViewExt
    
    var body: some View {
        VStack(alignment: .center) {
            Text(self.extModel.viewId)
                .font(Font.custom("UbuntuMono-Regular", size: 30.0))
            Spacer()
            Button(action: self.extModel.onNewViewController ?? {}) {
                Text("New ViewController")
                    .padding(20)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
            Spacer()
            Button(action: self.extModel.onNewView ?? {}) {
                Text("New View")
                    .padding(2)
                    .foregroundColor(.orange)
                    .cornerRadius(10)
            }
        }
        .padding(20)
    }
}

struct ContextView_Previews: PreviewProvider {
    static var previews: some View {
        NavigatedView(extModel: NavigatedViewExt())
            .frame(height: 100.0)
    }
}
