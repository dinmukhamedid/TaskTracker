import Foundation
import FirebaseDatabase

class TaskService {
    private let ref = Database.database().reference().child("tasks")

    func fetchTasks(completion: @escaping ([TaskItem]) -> Void) {
        ref.observeSingleEvent(of: .value) { snapshot in
            var tasks: [TaskItem] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let jsonData = try? JSONSerialization.data(withJSONObject: dict),
                   let task = try? JSONDecoder().decode(TaskItem.self, from: jsonData) {
                    tasks.append(task)
                }
            }
            completion(tasks)
        }
    }

    func addTask(_ task: TaskItem) {
        ref.child(task.id).setValue([
            "id": task.id,
            "title": task.title,
            "category": task.category,
            "isDone": task.isDone
        ])
    }

    func updateTask(_ task: TaskItem) {
        ref.child(task.id).updateChildValues([
            "title": task.title,
            "category": task.category,
            "isDone": task.isDone
        ])
    }

    func deleteTask(_ task: TaskItem) {
        ref.child(task.id).removeValue()
    }
}
