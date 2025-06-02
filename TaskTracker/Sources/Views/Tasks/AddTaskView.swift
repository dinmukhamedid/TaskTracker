import SwiftUI

struct AddTaskView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TaskViewModel

    @State private var title: String = ""
    @State private var category: String = "daily"

    let categories = ["daily", "weekly", "monthly"]

    var body: some View {
        NavigationView {
            Form {
                TextField("Тапсырма атауы", text: $title)

                Picker("Категория", selection: $category) {
                    ForEach(categories, id: \.self) { cat in
                        Text(cat.capitalized).tag(cat)
                    }
                }

                Button("Қосу") {
                    viewModel.addTask(title: title, category: category)
                    dismiss()
                }
            }
            .navigationTitle("Жаңа тапсырма")
        }
    }
}
