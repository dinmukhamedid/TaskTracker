import SwiftUI

struct ContentView: View {
    @StateObject var authViewModel = AuthViewModel()

    var body: some View {
        if authViewModel.isAuthenticated {
            MainTaskView(viewModel: authViewModel)
        } else {
            LoginView(viewModel: authViewModel)
        }
    }
}
