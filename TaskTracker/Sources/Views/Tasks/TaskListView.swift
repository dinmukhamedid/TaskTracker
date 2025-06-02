import SwiftUI

struct TaskListView: View {
    @ObservedObject var viewModel: TaskViewModel
    var category: String
    @State private var editingTask: TaskItem?

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

                    // ✏️ Edit батырмасы
                    Button(action: {
                        editingTask = task
                    }) {
                        Image(systemName: "pencil")
                    }
                    .padding(.leading, 8)
                }
            }
            .onDelete(perform: viewModel.deleteTask)
        }
        .onAppear {
            viewModel.loadTasks()
        }
        .sheet(item: $editingTask) { task in
            EditTaskView(viewModel: viewModel, task: task)
        }
        .navigationTitle(category.capitalized)
    }
}
