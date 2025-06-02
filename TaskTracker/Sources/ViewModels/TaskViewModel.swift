import Foundation
import FirebaseAuth  // 👈 Auth үшін қажет

class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    private let service = TaskService()

    func loadTasks() {
        service.fetchTasks { [weak self] tasks in
            DispatchQueue.main.async {
                self?.tasks = tasks
            }
        }
    }

    func addTask(title: String, category: String) {
        guard let userId = FirebaseAuth.Auth.auth().currentUser?.uid else { return }
        let task = TaskItem(title: title, category: category, userId: userId)
        service.addTask(task)
        loadTasks()
    }

    func toggleCheck(for task: TaskItem) {
        var updated = task
        updated.isDone.toggle()
        service.updateTask(updated)
        loadTasks()
    }

    func deleteTask(at offsets: IndexSet) {
        offsets.forEach { index in
            service.deleteTask(tasks[index])
        }
        loadTasks()
    }

    func updateTask(_ task: TaskItem) {
        service.updateTask(task)
        loadTasks()
    }
}
