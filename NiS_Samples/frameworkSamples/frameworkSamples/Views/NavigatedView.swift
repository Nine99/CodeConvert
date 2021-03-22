//
//  NavigatedView.swift
//  frameworkSamples
//
//  Created by ITTF04 on 2021/03/22.
//

import UIKit
import SwiftUI

//struct NavigatedView : UIViewControllerRepresentable {
struct NavigatedView : View {
//    typealias UIViewControllerType = UIViewController
    

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var body: some View {
        VStack(alignment: .center) {
            Text("id")
                .font(Font.custom("UbuntuMono-Regular", size: 30.0))
            Spacer()
            Button(action: {}) {
                Text("New ViewController")
                    .padding(20)
                    .foregroundColor(.blue)
                    .cornerRadius(10)
            }
            Spacer()
            Button(action: {}) {
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
        NavigatedView()
            .frame(height: 100.0)
    }
}
