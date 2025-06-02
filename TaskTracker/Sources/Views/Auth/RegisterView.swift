import SwiftUI

struct RegisterView: View {
    @ObservedObject var viewModel: AuthViewModel
    @Environment(\.dismiss) var dismiss

    var body: some View {
        VStack(spacing: 20) {
            Text("Тіркелу").font(.largeTitle).bold()

            TextField("Email", text: $viewModel.email)
                .textFieldStyle(.roundedBorder)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)

            SecureField("Құпия сөз", text: $viewModel.password)
                .textFieldStyle(.roundedBorder)

            if let error = viewModel.errorMessage {
                Text(error).foregroundColor(.red)
            }

            Button("Тіркелу") {
                viewModel.register()
                dismiss()
            }
            .buttonStyle(.borderedProminent)

            Button("Артқа қайту") {
                dismiss()
            }
        }
        .padding()
    }
}
