import SwiftUI

struct MainTaskView: View {
    @ObservedObject var viewModel: AuthViewModel
    @StateObject var taskViewModel = TaskViewModel()
    @State private var showAddTask = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    NavigationLink("🟢 Daily", destination: TaskListView(viewModel: taskViewModel, category: "daily"))
                    NavigationLink("🔵 Weekly", destination: TaskListView(viewModel: taskViewModel, category: "weekly"))
                    NavigationLink("🟣 Monthly", destination: TaskListView(viewModel: taskViewModel, category: "monthly"))
                }

                Button("➕ Тапсырма қосу") {
                    showAddTask = true
                }
                .sheet(isPresented: $showAddTask) {
                    AddTaskView(viewModel: taskViewModel)
                }

                Button("🚪 Шығу") {
                    viewModel.signOut()
                }
                .padding()
                .foregroundColor(.white)
                .background(Color.red)
                .cornerRadius(10)
            }
            .navigationTitle("TaskTracker")
        }
    }
}
