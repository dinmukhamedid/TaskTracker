import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    var category: String

    var body: some View {
        List {
            ForEach(viewModel.tasks.filter { $0.category == category }) { task in
                HStack {
                    Text(task.title)
                    Spacer()
                    Button(action: {
                        viewModel.toggleCheck(for: task)
                    }) {
                        Image(systemName: task.isDone ? "checkmark.circle.fill" : "circle")
                            .foregroundColor(task.isDone ? .green : .gray)
                    }
                }
            }
            .onDelete(perform: viewModel.deleteTask)
        }
        .onAppear {
            viewModel.loadTasks()
        }
        .navigationTitle(category.capitalized)
    }
}
