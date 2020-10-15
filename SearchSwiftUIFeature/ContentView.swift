//
//  ContentView.swift
//  SearchSwiftUIFeature
//
//  Created by Shaik Ghouse Basha on 15/10/20.
//

import SwiftUI

struct ContentView: View {
	@State var searchText = ""
	@State var isSearching = false
	
    var body: some View {
		NavigationView {
			ScrollView {
				SearchBar(searchText: $searchText, isSearching: $isSearching)
				ForEach((1...20).filter({"\($0)".contains(searchText) || searchText.isEmpty}), id:\.self) { num in
					HStack {
						Text("\(num)")
						Spacer()
					}
					.padding()
					Divider()
						.background(Color(.systemGray4))
						.padding(.leading)
				}
			}
			.navigationTitle("Food")
		}
		
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct SearchBar: View {
	@Binding var searchText: String
	@Binding var isSearching: Bool
	
	var body: some View {
		HStack {
			HStack {
				TextField("search text", text: $searchText)
					.padding(.leading, 20)
				
			}
			.padding()
			.background(Color(.systemGray4))
			.cornerRadius(6)
			.padding(.horizontal)
			.onTapGesture(perform: {
				isSearching = true
			})
			
			.overlay(
				HStack {
					Image(systemName: "magnifyingglass")
					Spacer()
					if isSearching {
						Button(action: {
							searchText = ""
						}, label: {
							Image(systemName: "xmark.circle.fill")
								.padding(.vertical)
						})
						
					}
				}
				.padding(.horizontal, 30)
				.foregroundColor(.gray)
			)
			.transition(.move(edge: .trailing))
			.animation(.spring())
			
			
			if isSearching {
				Button(action: {
					searchText = ""
					isSearching = false
					UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
				}, label: {
					Text("Cancel")
						.padding(.trailing)
						.padding(.leading, -15)
					
				})
				.transition(.move(edge: .trailing))
				.animation(.spring())
			}
		}
	}
}
