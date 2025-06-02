import Foundation

struct TaskItem: Identifiable, Codable {
    var id: String = UUID().uuidString
    var title: String
    var category: String // "daily", "weekly", "monthly"
    var isDone: Bool = false
}
