import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  final String id;
  final String title;
  final String description;
  final String status;
  final DateTime timestamp;

  Task({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.timestamp,
  });

  Task copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    DateTime? timestamp,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'timestamp': Timestamp.fromDate(timestamp), // Convert DateTime to Firestore Timestamp
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      status: map['status'] as String,
      timestamp: (map['timestamp'] as Timestamp).toDate(), // Convert Firestore Timestamp to DateTime
    );
  }
}
