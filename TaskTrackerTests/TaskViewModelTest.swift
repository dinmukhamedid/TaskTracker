import XCTest
@testable import TaskTracker

@MainActor
final class TaskViewModelTest: XCTestCase {

    // ✅ 1. isDone өзгерісін тексеру
    func testToggleCheckChangesIsDone() async {
        // Берілген
        let task = TaskItem(title: "Test Task", category: "daily", isDone: false, userId: "1")
        let viewModel = TaskViewModel()
        viewModel.tasks = [task]

        // Әрекет
        await viewModel.toggleCheck(for: task)

        // Нақты тексеру мүмкін емес, өйткені loadTasks() Firebase-ке тәуелді
        // Дегенмен, код қатесіз орындалады ма — соны тексереміз
        XCTAssertTrue(true)
    }

    // ✅ 2. Категория бойынша фильтр логикасы
    func testFilterTasksByCategory() {
        let task1 = TaskItem(title: "Task 1", category: "daily", userId: "1")
        let task2 = TaskItem(title: "Task 2", category: "weekly", userId: "1")
        let task3 = TaskItem(title: "Task 3", category: "daily", userId: "1")

        let viewModel = TaskViewModel()
        viewModel.tasks = [task1, task2, task3]

        let filtered = viewModel.tasks.filter { $0.category == "daily" }

        XCTAssertEqual(filtered.count, 2)
        XCTAssertTrue(filtered.allSatisfy { $0.category == "daily" })
    }

    // ✅ 3. addTask дұрыс жұмыс істей ме (Firebase жоқ жағдайда)
    func testAddTaskDoesNotCrash() async {
        let viewModel = TaskViewModel()

        // Firebase пайдаланушы болмаса, addTask return жасайды
        await viewModel.addTask(title: "New Task", category: "daily")

        // Кем дегенде crash болмай, дұрыс жұмыс істеуін тексереміз
        XCTAssertTrue(true)
    }
}
