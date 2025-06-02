import SwiftUI

struct MainTaskView: View {
    @ObservedObject var viewModel: AuthViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Қош келдіңіз!")
                .font(.title)
                .bold()

            Button("Шығу") {
                viewModel.signOut() // Дұрыс шақыру
            }
            .padding()
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
        }
        .padding()
    }
}
