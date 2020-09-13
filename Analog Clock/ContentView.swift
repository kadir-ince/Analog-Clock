//
//  ContentView.swift
//  Analog Clock
//
//  Created by Kadir on 13.09.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = false

    var body: some View {
        NavigationView {
            Home(isDark: $isDark)
                .navigationBarHidden(true)
                .preferredColorScheme(isDark ? .dark : .light)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct Home: View {
    @Binding var isDark: Bool

    var body: some View {
        VStack {
            HStack {
                Text("Analog Clock")
                    .font(.title)
                    .fontWeight(.heavy)

                Spacer()

                Button(action: { isDark.toggle() }, label: {
                    Image(systemName: isDark ? "sun.min.fill" : "moon.fill")
                        .font(.system(size: 22))
                        .foregroundColor(isDark ? .black : .white)
                        .padding()
                        .background(Color.primary)
                        .clipShape(Circle())

                })
            }
            .padding()

            Spacer(minLength: 0)
        }
    }
}
