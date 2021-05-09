//
//  View+.swift
//  CleanMyPhoto
//
//  Created by Volodymyr Mudrik on 28.04.2021.
//

import Foundation
import SwiftUI

extension View {

	func ifTrue(_ condition:Bool, apply:(AnyView) -> (AnyView)) -> AnyView {
		if condition {
			return apply(AnyView(self))
		}
		else {
			return AnyView(self)
		}
	}

	func customShadow(shadowRadius: CGFloat, opacity: Double = 0.8) -> some View {
		self
			.shadow(color: Color.ui.backgound.opacity(opacity), radius: shadowRadius, x: shadowRadius, y: shadowRadius)
			.shadow(color: Color.ui.tint.opacity(opacity), radius: shadowRadius, x: -shadowRadius, y: -shadowRadius)
	}
}

extension View {

	/// Navigate to a new view.
	/// - Parameters:
	///   - view: View to navigate to.
	///   - binding: Only navigates when this condition is `true`.
	func navigate<NewView: View>(to view: NewView, when binding: Binding<Bool>) -> some View {
		NavigationView {
			ZStack {
				self
					.navigationBarTitle("")
					.navigationBarHidden(true)

				NavigationLink(
					destination: view
						.navigationBarTitle("")
						.navigationBarHidden(true),
					isActive: binding
				) {
					EmptyView()
				}
			}
		}
	}
}
