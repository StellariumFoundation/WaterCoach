import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
    double progress = _dailyGoal == 0 ? 0 : _waterIntake / _dailyGoal;
    if (progress < 0) progress = 0;
    if (progress > 1) progress = 1;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Water Intake Coach'), // Slightly more descriptive title
        centerTitle: true, // Center title
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_note), // More descriptive icon for editing goal
            onPressed: _editGoal,
            tooltip: 'Edit Daily Goal',
          ),
        ],
      ),
      body: SingleChildScrollView( // Make content scrollable
        child: Padding(
          padding: const EdgeInsets.all(20.0), // Increased padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch, // Stretch children like progress bar
            children: <Widget>[
              const SizedBox(height: 10),
              Text(
                'Your Daily Water Goal:',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                '$_dailyGoal ml',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 30),
              Text(
                'Current Intake:',
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                '$_waterIntake ml',
                style: Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: progress,
                minHeight: 30, // Thicker progress bar
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(15), // Rounded corners
              ),
              const SizedBox(height: 10),
              Text(
                '${(progress * 100).toStringAsFixed(0)}% of your goal',
                style: Theme.of(context).textTheme.labelLarge,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Text(
                'Add Water:',
                style: Theme.of(context).textTheme.titleMedium,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton.icon(
                    icon: const Icon(Icons.local_drink),
                    label: const Text('250ml Glass'),
                    onPressed: () => _addWater(250),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                  ElevatedButton.icon(
                    icon: const Icon(Icons.opacity_rounded), // Different icon for bottle
                    label: const Text('500ml Bottle'),
                    onPressed: () => _addWater(500),
                     style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      textStyle: Theme.of(context).textTheme.labelLarge,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),
              Center( // Center the reset button
                child: TextButton.icon(
                  icon: const Icon(Icons.refresh_rounded),
                  label: const Text('Reset Daily Intake'),
                  onPressed: _resetIntake,
                  style: TextButton.styleFrom(
                    foregroundColor: Theme.of(context).colorScheme.error,
                    textStyle: Theme.of(context).textTheme.labelLarge,
                  ),
                ),
              ),
              const SizedBox(height: 20), // Bottom padding
            ],
          ),
        ),
      ),
    );
  }
}
