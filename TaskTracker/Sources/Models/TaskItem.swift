import Foundation

struct TaskItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var category: String
    var isDone: Bool = false
    var userId: String  // 👈 МІНДЕТТІ!

    init(id: String = UUID().uuidString, title: String, category: String, isDone: Bool = false, userId: String) {
        self.id = id
        self.title = title
        self.category = category
        self.isDone = isDone
        self.userId = userId
    }
}
