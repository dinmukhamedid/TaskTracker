import SwiftUI

struct EditTaskView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var viewModel: TaskViewModel
    @State var task: TaskItem

    @State private var newTitle: String = ""
    @State private var newCategory: String = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Тапсырма атауы")) {
                    TextField("Мысалы: Спортпен айналысу", text: $newTitle)
                }

                Section(header: Text("Категория")) {
                    Picker("Категория", selection: $newCategory) {
                        Text("1 күнде (daily)").tag("daily")
                        Text("1 аптада (weekly)").tag("weekly")
                        Text("1 айда (monthly)").tag("monthly")
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section {
                    Button("Сақтау") {
                        Task {
                            task.title = newTitle
                            task.category = newCategory
                            await viewModel.updateTask(task)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                    .disabled(newTitle.isEmpty || newCategory.isEmpty)
                }
            }
            .navigationTitle("Тапсырманы өзгерту")
            .onAppear {
                newTitle = task.title
                newCategory = task.category
            }
        }
    }
}
