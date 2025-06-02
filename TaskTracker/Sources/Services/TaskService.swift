import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class TaskService {
    private let ref = Database.database().reference().child("tasks")

    // 🔽 Барлық тапсырмалар
    func fetchTasks() async -> [TaskItem] {
        guard let userId = Auth.auth().currentUser?.uid else {
            return []
        }

        return await withCheckedContinuation { continuation in
            ref.observeSingleEvent(of: .value) { snapshot in
                var tasks: [TaskItem] = []

                for child in snapshot.children {
                    if let snap = child as? DataSnapshot,
                       let dict = snap.value as? [String: Any],
                       let jsonData = try? JSONSerialization.data(withJSONObject: dict),
                       let task = try? JSONDecoder().decode(TaskItem.self, from: jsonData),
                       task.userId == userId {
                        tasks.append(task)
                    }
                }

                continuation.resume(returning: tasks)
            }
        }
    }

    // 🔽 Тапсырма қосу
    func addTask(_ task: TaskItem) async {
        await withCheckedContinuation { continuation in
            ref.child(task.id).setValue([
                "id": task.id,
                "title": task.title,
                "category": task.category,
                "isDone": task.isDone,
                "userId": task.userId
            ]) { _, _ in
                continuation.resume()
            }
        }
    }

    // 🔽 Тапсырманы жаңарту
    func updateTask(_ task: TaskItem) async {
        await withCheckedContinuation { continuation in
            ref.child(task.id).updateChildValues([
                "title": task.title,
                "category": task.category,
                "isDone": task.isDone
            ]) { _, _ in
                continuation.resume()
            }
        }
    }

    // 🔽 Тапсырманы өшіру
    func deleteTask(_ task: TaskItem) async {
        await withCheckedContinuation { continuation in
            ref.child(task.id).removeValue { _, _ in
                continuation.resume()
            }
        }
    }
}
