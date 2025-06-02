import SwiftUI
import RealityKit
import ARKit

struct ARScreenView: View {
    var isDone: Bool

    var body: some View {
        ZStack {
            ARViewContainer(isDone: isDone)
                .edgesIgnoringSafeArea(.all)

            VStack {
                Spacer()
                Text(isDone ? "Тапсырма аяқталды!" : "Тапсырма орындалмады")
                    .font(.title)
                    .padding()
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(12)
                    .padding()
            }
        }
    }
}
