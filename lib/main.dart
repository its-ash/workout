import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'models/workout.dart';
import 'services/workout_service.dart';
import 'screens/workout_screen.dart';

void main() {
  runApp(const WorkoutApp());
}

class WorkoutApp extends StatelessWidget {
  const WorkoutApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Workout App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const WorkoutHomePage(),
    );
  }
}

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  final WorkoutService _workoutService = WorkoutService();
  Workout? _todayWorkout;
  bool _isLoading = true;
  int _currentDay = 1;

  @override
  void initState() {
    super.initState();
    _loadTodayWorkout();
  }

  Future<void> _loadTodayWorkout() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final prefs = await SharedPreferences.getInstance();
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final savedDate = prefs.getString('last_workout_date');
      
      if (savedDate != today) {
        // New day, increment workout day
        _currentDay = await _workoutService.getNextWorkoutDay();
        await prefs.setString('last_workout_date', today);
        await prefs.setInt('current_workout_day', _currentDay);
      } else {
        // Same day, load saved day
        _currentDay = prefs.getInt('current_workout_day') ?? 1;
      }

      _todayWorkout = await _workoutService.getWorkoutForDay(_currentDay);
    } catch (e) {
      print('Error loading workout: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Workout'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _todayWorkout == null
              ? const Center(child: Text('No workout available'))
              : WorkoutScreen(workout: _todayWorkout!, currentDay: _currentDay),
      floatingActionButton: FloatingActionButton(
        onPressed: _loadTodayWorkout,
        tooltip: 'Refresh Workout',
        child: const Icon(Icons.refresh),
      ),
    );
  }
}