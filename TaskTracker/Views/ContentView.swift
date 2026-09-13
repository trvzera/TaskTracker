//
//  ContentView.swift
//  TaskTracker
//
//  Created by Giovanni Trivellato on 12/09/26.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Query private var tasks: [Task]
    @Environment(\.modelContext) private var modelContext
    @State
    private var newTask: String = ""
    var body: some View {
        VStack {
            Text("Task Tracker")
                .font(.largeTitle.bold())
                .padding(.bottom)
            Text("Tasks (\(tasks.count))")
                .font(.subheadline)
                .contentTransition(.numericText(value: Double(tasks.count)))
                .animation(.spring, value: tasks.count)
            HStack {
                TextField("New Task", text: $newTask)
                    .textFieldStyle(.roundedBorder)
                Button("Add"){
                    withAnimation {
                        addTask()
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(newTask.isEmpty)
            }
            List{
                ForEach(tasks) { task in
                    HStack {
                        Text(task.title)
                            .strikethrough(task.iscompleted)
                            .foregroundStyle(task.iscompleted ? .secondary : .primary)
                        Spacer()
                        Image(systemName: task.iscompleted ? "checkmark.seal.fill" : "circlebadge")
                            .foregroundStyle(task.iscompleted ? .blue : .secondary)
                    }
                    .contentShape(Rectangle())
                    .listRowBackground(Color.clear)
                    .animation(.spring, value: task.iscompleted)
                    .onTapGesture {
                        withAnimation(.spring) {
                            toggleTask(task)
                        }
                    }
                }
                .onDelete { offsets in
                    withAnimation {
                        removeTasks(at: offsets)
                    }
                }
            }
            .scrollContentBackground(.hidden)
            .background(Color.white)
        }
        .padding()
        .background(Color.white)
    }
    private func addTask() {
        let newTask = Task(title: self.newTask)
        modelContext.insert(newTask)
        self.newTask = ""
    }
    
    private func toggleTask(_ task: Task) {
        task.iscompleted.toggle()
    }
    
    private func removeTasks(at offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(tasks[index])
        }
    }
    
    
}

#Preview {
    ContentView()
}
