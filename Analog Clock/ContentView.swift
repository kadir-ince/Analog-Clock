//
//  ContentView.swift
//  Analog Clock
//
//  Created by Kadir on 13.09.2020.
//

import SwiftUI

struct ContentView: View {
    @State var isDark = true

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

            ZStack {
                Circle() // Clock Background
                    .fill(Color("Color").opacity(0.1))

                // Seconds Dots
                // This formula (Foreach Section) taked from Kavasoft
                ForEach(0 ..< 60, id: \.self) { i in
                    Rectangle()
                        .fill(Color.primary)
                        // Height section -> Hours are long rectangle, Seconds are short rectangles
                        .frame(width: 2, height: (i % 5) == 0 ? 15 : 5)
                        .offset(y: (screen.width - 110) / 2)
                        .rotationEffect(.init(degrees: Double(i) * 6))
                }
            }
            .frame(width: screen.width - 80, height: screen.width - 80)

            Spacer(minLength: 0)
        }
    }
}

let screen = UIScreen.main.bounds
