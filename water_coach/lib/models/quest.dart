import 'package:uuid/uuid.dart';

// Forward declaration of QuestStatus for Quest class
enum QuestStatus {
  draft,
  active,
  completed,
  failed,
  paused
}

class Quest {
  String id;
  String description;
  DateTime startTime;
  DateTime? endTime; // Nullable for active quests or drafts
  QuestStatus status;
  List<String> notes; // Optional: For adding notes or logs to a quest

  Quest({
    String? id,
    required this.description,
    required this.startTime,
    this.endTime,
    this.status = QuestStatus.draft,
    List<String>? notes,
  }) : this.id = id ?? Uuid().v4(),
       this.notes = notes ?? [];

  // Optional: Add methods for JSON serialization/deserialization if needed later for shared_preferences or API calls
  // Map<String, dynamic> toJson() => {
  //   'id': id,
  //   'description': description,
  //   'startTime': startTime.toIso8601String(),
  //   'endTime': endTime?.toIso8601String(),
  //   'status': status.toString(),
  //   'notes': notes,
  // };

  // factory Quest.fromJson(Map<String, dynamic> json) => Quest(
  //   id: json['id'],
  //   description: json['description'],
  //   startTime: DateTime.parse(json['startTime']),
  //   endTime: json['endTime'] != null ? DateTime.parse(json['endTime']) : null,
  //   status: QuestStatus.values.firstWhere((e) => e.toString() == json['status']),
  //   notes: List<String>.from(json['notes'] ?? []),
  // );
}
