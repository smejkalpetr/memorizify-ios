//
//  PlainTimerSetupView.swift
//  Memorizify
//
//  Created by Petr Šmejkal on 23.04.2024.
//

import SwiftUI

struct PlainTimerSetupView: View {
    
    @ObservedObject var viewModel: PlainTimerSetupViewModel
    
    @EnvironmentObject var router: Router
    
    @Environment(\.presentationMode) var presentationMode
    
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            ZStack(alignment: .bottom) {
                alarmImage
                ScrollView {
                    plainTimerSettings
                }
            }
            Spacer()
            startPlainTimerButton
        }
        .background {
            backgroundImage
        }
    }
    
    private var backgroundImage: some View {
        ZStack {
            Image("bg_home")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
            if colorScheme == .dark {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
            }
        }
    }
    
    private var alarmImage: some View {
        VStack {
            Image("plain_timer_setup_alarm")
                .resizable()
                .scaledToFit()
                .padding()
        }
    }
    
    private var plainTimerSettings: some View {
        VStack {
            ZStack {
                sliders
            }
        }
        .background(
            RoundedRectangle(
                cornerRadius: 10
            )
            .fill(colorScheme == .dark ? .black : .white)
            .shadow(radius: 5, x: 3.5, y: 3.5)
        )
        .padding()
    }
    
    private var sliders: some View {
        VStack {
            SliderView(title: "Study Interval", range: PlainTimerSetupViewModel.studyIntervalRange, valueBinding: $viewModel.state.studyInterval)
            SliderView(title: "Break Interval", range: PlainTimerSetupViewModel.breakIntervalRange, valueBinding: $viewModel.state.breakInterval)
        }
        .padding()
    }

    private var startPlainTimerButton: some View {
        Button("Start") {
            presentationMode.wrappedValue.dismiss()
            router.homePath.append(
                HomeRoute.plainTimer(
                    studyInterval: viewModel.state.studyInterval,
                    breakInterval: viewModel.state.breakInterval
                )
            )
        }
        .buttonStyle(PrimaryButtonStyle())
        .padding()
    }
}

#Preview {
    PlainTimerSetupView(viewModel: PlainTimerSetupViewModel())
}
