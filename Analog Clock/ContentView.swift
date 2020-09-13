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

//struct Home: View {
    @Binding var isDark: Bool
    @State var currentTime = Time(hour: 0, min: 0, sec: 0)
    @State var receiver = Timer.publish(every: 1, on: .current, in: .default)
        .autoconnect()

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

                // Second Line
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (screen.width - 180) / 2)
                    .offset(y: -(screen.width - 180) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.sec) * 6))

                // Minute Line
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (screen.width - 200) / 2)
                    .offset(y: -(screen.width - 200) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.min) * 6))

                // Hour Line
                Rectangle()
                    .fill(Color.primary)
                    .frame(width: 2, height: (screen.width - 240) / 2)
                    .offset(y: -(screen.width - 240) / 4)
                    .rotationEffect(.init(degrees: Double(currentTime.hour + (currentTime.min / 60)) * 30))

                // Center Dot
                Circle()
                    .fill(Color.primary)
                    .frame(width: 15, height: 15)
            }
            .frame(width: screen.width - 80, height: screen.width - 80)

//
//            // Getting Region Name
//            let locale = Locale.current
//            Text(locale.regionCode ?? "")
//                .font(.largeTitle)
//                .fontWeight(.heavy)
//                .padding(.top, 35)
            
            Text(getTime())
                .font(.system(size: 45))
                .fontWeight(.heavy)
                .padding(.top, 10)
            Spacer(minLength: 0)
        }
        .onAppear(perform: {
            let calender = Calendar.current

            let hour = calender.component(.hour, from: Date())
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())

            withAnimation(Animation.linear(duration: 0.01)) {
                currentTime = Time(hour: hour, min: min, sec: sec)
            }
        })
        .onReceive(receiver) { _ in
            let calender = Calendar.current

            let hour = calender.component(.hour, from: Date())
            let min = calender.component(.minute, from: Date())
            let sec = calender.component(.second, from: Date())

            withAnimation(Animation.linear(duration: 0.01)) {
                currentTime = Time(hour: hour, min: min, sec: sec)
            }
        }
    }
    func getTime() -> String {
        let format = DateFormatter()
        format.dateFormat = "hh:mm a"
        return format.string(from: Date())
    }
}

let screen = UIScreen.main.bounds

struct Time {
    var hour: Int
    var min: Int
    var sec: Int
}
