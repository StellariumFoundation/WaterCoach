import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:water_coach/models/task.dart';

class FirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final String _tasksCollection = 'tasks';

  // Add a new task
  Future<void> addTask(Task task) {
    return _db.collection(_tasksCollection).doc(task.id).set(task.toMap());
  }

  // Update an existing task
  Future<void> updateTask(Task task) {
    return _db.collection(_tasksCollection).doc(task.id).update(task.toMap());
  }

  // Delete a task
  Future<void> deleteTask(String taskId) {
    return _db.collection(_tasksCollection).doc(taskId).delete();
  }

  // Get a stream of tasks
  Stream<List<Task>> getTasks() {
    return _db.collection(_tasksCollection)
        .orderBy('timestamp', descending: true) // Optional: order by timestamp
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => Task.fromMap(doc.data()))
        .toList());
  }
}
