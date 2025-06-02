import Foundation
import Firebase
import FirebaseDatabase
import FirebaseAuth

class TaskService {
    private let ref = Database.database().reference().child("tasks")

    // 🔽 Барлық тапсырмалар (тек ағымдағы қолданушының)
    func fetchTasks(completion: @escaping ([TaskItem]) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion([])
            return
        }

        ref.observeSingleEvent(of: .value) { snapshot in
            var tasks: [TaskItem] = []
            for child in snapshot.children {
                if let snap = child as? DataSnapshot,
                   let dict = snap.value as? [String: Any],
                   let jsonData = try? JSONSerialization.data(withJSONObject: dict),
                   var task = try? JSONDecoder().decode(TaskItem.self, from: jsonData) {

                    // 🔐 Тек ағымдағы қолданушының тапсырмасын қосу
                    if task.userId == userId {
                        tasks.append(task)
                    }
                }
            }
            completion(tasks)
        }
    }

    // 🔽 Тапсырма қосу
    func addTask(_ task: TaskItem) {
        ref.child(task.id).setValue([
            "id": task.id,
            "title": task.title,
            "category": task.category,
            "isDone": task.isDone,
            "userId": task.userId  // 🔐 Міндетті!
        ])
    }

    // 🔽 Тапсырманы жаңарту
    func updateTask(_ task: TaskItem) {
        ref.child(task.id).updateChildValues([
            "title": task.title,
            "category": task.category,
            "isDone": task.isDone
        ])
    }

    // 🔽 Тапсырманы өшіру
    func deleteTask(_ task: TaskItem) {
        ref.child(task.id).removeValue()
    }
}
