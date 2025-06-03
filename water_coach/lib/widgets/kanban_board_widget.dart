import 'package:flutter/material.dart';
import 'package:water_coach/models/task.dart';
import 'package:water_coach/services/firestore_service.dart';

class KanbanBoardWidget extends StatefulWidget {
  const KanbanBoardWidget({super.key});

  @override
  State<KanbanBoardWidget> createState() => _KanbanBoardWidgetState();
}

class _KanbanBoardWidgetState extends State<KanbanBoardWidget> {
  final FirestoreService _firestoreService = FirestoreService();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Task>>(
      stream: _firestoreService.getTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('No tasks found.'));
        }

        List<Task> tasks = snapshot.data!;
        List<Task> todoTasks = tasks.where((task) => task.status == 'todo').toList();
        List<Task> inProgressTasks = tasks.where((task) => task.status == 'in progress').toList();
        List<Task> doneTasks = tasks.where((task) => task.status == 'done').toList();

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTaskColumn('To Do', todoTasks),
            _buildTaskColumn('In Progress', inProgressTasks),
            _buildTaskColumn('Done', doneTasks),
          ],
        );
      },
    );
  }

  Widget _buildTaskColumn(String title, List<Task> tasks) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.all(8.0),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                title,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 0),
                    elevation: 2.0,
                    child: ListTile(
                      title: Text(task.title, style: Theme.of(context).textTheme.titleMedium),
                      subtitle: Text(task.description),
                      // TODO: Add drag and drop functionality or tap to edit/update status
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
