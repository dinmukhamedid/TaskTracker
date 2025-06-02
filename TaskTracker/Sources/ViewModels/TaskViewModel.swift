import Foundation
import FirebaseAuth

@MainActor
class TaskViewModel: ObservableObject {
    @Published var tasks: [TaskItem] = []
    private let service = TaskService()

    // 🔄 Барлық тапсырмаларды жүктеу
    func loadTasks() async {
        tasks = await service.fetchTasks()
    }

    // ➕ Тапсырма қосу
    func addTask(title: String, category: String) async {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        let task = TaskItem(title: title, category: category, userId: userId)
        await service.addTask(task)
        await loadTasks()
    }

    // ✅ Check/Uncheck жасау
    func toggleCheck(for task: TaskItem) async {
        var updated = task
        updated.isDone.toggle()
        await service.updateTask(updated)
        await loadTasks()
    }

    // 🗑️ Тапсырманы жою
    func deleteTask(at offsets: IndexSet) async {
        for index in offsets {
            await service.deleteTask(tasks[index])
        }
        await loadTasks()
    }

    // ✏️ Тапсырманы жаңарту
    func updateTask(_ task: TaskItem) async {
        await service.updateTask(task)
        await loadTasks()
    }
}
