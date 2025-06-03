import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:water_coach/models/task.dart';
import 'package:water_coach/services/firestore_service.dart';

class TaskDialog extends StatefulWidget {
  final Task? task; // Task object for editing, null for creating

  const TaskDialog({super.key, this.task});

  @override
  State<TaskDialog> createState() => _TaskDialogState();
}

class _TaskDialogState extends State<TaskDialog> {
  final _formKey = GlobalKey<FormState>();
  final FirestoreService _firestoreService = FirestoreService();
  final Uuid _uuid = const Uuid();

  late String _title;
  late String _description;
  late String _status;
  late DateTime _timestamp;

  final List<String> _statusOptions = ['todo', 'in progress', 'done'];

  @override
  void initState() {
    super.initState();
    if (widget.task != null) {
      _title = widget.task!.title;
      _description = widget.task!.description;
      _status = widget.task!.status;
      _timestamp = widget.task!.timestamp;
    } else {
      _title = '';
      _description = '';
      _status = _statusOptions.first; // Default to 'todo'
      _timestamp = DateTime.now();
    }
  }

  void _saveTask() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final task = Task(
        id: widget.task?.id ?? _uuid.v4(), // Use existing ID or generate new one
        title: _title,
        description: _description,
        status: _status,
        timestamp: (widget.task != null && widget.task?.timestamp != _timestamp) ? _timestamp : DateTime.now() , // Preserve original if not changed, else update for edits, or set for new
      );

      if (widget.task != null) {
        _firestoreService.updateTask(task).then((_) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task updated successfully!')));
        }).catchError((error) {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to update task: $error')));
        });
      } else {
        _firestoreService.addTask(task).then((_) {
          Navigator.of(context).pop();
           ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Task added successfully!')));
        }).catchError((error) {
           ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to add task: $error')));
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.task == null ? 'Add Task' : 'Edit Task'),
      content: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextFormField(
                initialValue: _title,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
                onSaved: (value) => _title = value!,
              ),
              const SizedBox(height: 16),
              TextFormField(
                initialValue: _description,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
                onSaved: (value) => _description = value!,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                value: _status,
                decoration: const InputDecoration(labelText: 'Status'),
                items: _statusOptions.map((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
                onChanged: (String? newValue) {
                  setState(() {
                    _status = newValue!;
                  });
                },
                onSaved: (value) => _status = value!,
              ),
            ],
          ),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text('Save'),
          onPressed: _saveTask,
        ),
      ],
    );
  }
}
