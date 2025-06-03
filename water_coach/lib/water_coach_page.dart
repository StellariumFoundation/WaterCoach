import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:water_coach/widgets/kanban_board_widget.dart'; // Added KanbanBoardWidget import
import 'package:water_coach/widgets/task_dialog.dart'; // Added TaskDialog import

class WaterCoachPage extends StatefulWidget {
  const WaterCoachPage({super.key});

  @override
  State<WaterCoachPage> createState() => _WaterCoachPageState();
}

class _WaterCoachPageState extends State<WaterCoachPage> {
  int _waterIntake = 0;
  int _dailyGoal = 2000; // Default goal

  static const String _intakeKey = 'water_intake';
  static const String _goalKey = 'daily_goal';
  static const String _lastResetDateKey = 'last_reset_date';

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    _checkAndResetDailyIntake(); // Check before loading to ensure reset logic applies first
    setState(() {
      _waterIntake = prefs.getInt(_intakeKey) ?? 0;
      _dailyGoal = prefs.getInt(_goalKey) ?? 2000;
    });
  }

  Future<void> _saveIntake() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_intakeKey, _waterIntake);
  }

  Future<void> _saveGoal() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt(_goalKey, _dailyGoal);
  }

  Future<void> _checkAndResetDailyIntake() async {
    final prefs = await SharedPreferences.getInstance();
    String today = DateTime.now().toIso8601String().substring(0, 10); // YYYY-MM-DD
    String? lastResetDate = prefs.getString(_lastResetDateKey);

    if (lastResetDate != today) {
      // Intake for the new day starts at 0
      // No need to call setState here as _loadData will do it
      await prefs.setInt(_intakeKey, 0);
      await prefs.setString(_lastResetDateKey, today);
      // Update local state immediately if needed, or let _loadData handle it
      // Forcing _waterIntake to 0 here to reflect reset before potential async gap
      _waterIntake = 0;
    }
  }

  void _addWater(int amount) {
    setState(() {
      _waterIntake += amount;
    });
    _saveIntake();
  }

  void _resetIntake() {
    setState(() {
      _waterIntake = 0;
    });
    _saveIntake();
    SharedPreferences.getInstance().then((prefs) {
      String today = DateTime.now().toIso8601String().substring(0, 10);
      prefs.setString(_lastResetDateKey, today);
    });
  }

  void _editGoal() {
    final TextEditingController goalController = TextEditingController(text: _dailyGoal.toString());
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Set Daily Goal'),
          content: TextField(
            controller: goalController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Goal (ml)', border: OutlineInputBorder()),
            autofocus: true,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Cancel'),
            ),
            ElevatedButton( // Make "Save" more prominent
              onPressed: () {
                final newGoal = int.tryParse(goalController.text);
                if (newGoal != null && newGoal > 0) {
                  setState(() {
                    _dailyGoal = newGoal;
                  });
                  _saveGoal();
                }
                Navigator.pop(context);
              },
              child: const Text('Save'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // double progress = _dailyGoal == 0 ? 0 : _waterIntake / _dailyGoal; // Original progress logic
    // if (progress < 0) progress = 0;
    // if (progress > 1) progress = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Tasks'), // Updated title
        centerTitle: true,
        // actions: [ // Original actions removed for now, can be re-added if needed
        //   IconButton(
        //     icon: const Icon(Icons.edit_note),
        //     onPressed: _editGoal,
        //     tooltip: 'Edit Daily Goal',
        //   ),
        // ],
      ),
      body: const KanbanBoardWidget(), // Replaced body with KanbanBoardWidget
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return const TaskDialog(); // Show TaskDialog for creating new task
            },
          );
        },
        tooltip: 'Add Task',
        child: const Icon(Icons.add),
      ),
    );
  }
}
