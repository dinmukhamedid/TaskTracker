import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: AuthViewModel
    @State private var showRegister = false

    var body: some View {
        VStack(spacing: 20) {
            Text("Кіру").font(.largeTitle).bold()

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Құпия сөз", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Button("Кіру") {
                viewModel.login()
            }
            .buttonStyle(.borderedProminent)

            Button("Тіркелу бетіне өту") {
                showRegister = true
            }
            .sheet(isPresented: $showRegister) {
                RegisterView(viewModel: viewModel)
            }
        }
        .padding()
    }
}
