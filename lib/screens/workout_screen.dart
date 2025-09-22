import 'package:flutter/material.dart';
import '../models/workout.dart';

class WorkoutScreen extends StatefulWidget {
  final Workout workout;
  final int currentDay;

  const WorkoutScreen({
    super.key,
    required this.workout,
    required this.currentDay,
  });

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  int _currentExerciseIndex = 0;
  bool _isRestMode = false;
  int _remainingRestTime = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildWorkoutHeader(),
          const SizedBox(height: 20),
          _buildWorkoutInfo(),
          const SizedBox(height: 20),
          _buildExercisesList(),
          const SizedBox(height: 20),
          _buildResearchBasis(),
        ],
      ),
    );
  }

  Widget _buildWorkoutHeader() {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Day ${widget.currentDay}',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        color: Theme.of(context).colorScheme.primary,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${widget.workout.estimatedDuration} min',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onPrimaryContainer,
                        ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              widget.workout.title,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.workout.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildWorkoutInfo() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Workout Focus',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              widget.workout.focus,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(
                  Icons.fitness_center,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '${widget.workout.exercises.length} Exercises',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExercisesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Exercises',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
        ),
        const SizedBox(height: 16),
        ...widget.workout.exercises.asMap().entries.map(
          (entry) {
            int index = entry.key;
            Exercise exercise = entry.value;
            return _buildExerciseCard(exercise, index);
          },
        ),
      ],
    );
  }

  Widget _buildExerciseCard(Exercise exercise, int index) {
    bool isCompleted = index < _currentExerciseIndex;
    bool isCurrent = index == _currentExerciseIndex;

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isCurrent
          ? Theme.of(context).colorScheme.primaryContainer
          : isCompleted
              ? Theme.of(context).colorScheme.surfaceVariant
              : null,
      child: ExpansionTile(
        leading: CircleAvatar(
          backgroundColor: isCompleted
              ? Colors.green
              : isCurrent
                  ? Theme.of(context).colorScheme.primary
                  : Theme.of(context).colorScheme.outline,
          child: isCompleted
              ? const Icon(Icons.check, color: Colors.white)
              : Text(
                  '${index + 1}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
        ),
        title: Text(
          exercise.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            decoration: isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(
          '${exercise.sets} sets × ${exercise.reps} reps • ${exercise.restSeconds}s rest',
          style: TextStyle(
            color: Theme.of(context).colorScheme.onSurfaceVariant,
          ),
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  exercise.description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 12),
                _buildExerciseDetails(exercise),
                const SizedBox(height: 16),
                Text(
                  'Instructions:',
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  exercise.instructions,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                const SizedBox(height: 16),
                if (isCurrent) _buildExerciseControls(index),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExerciseDetails(Exercise exercise) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _buildDetailChip('Difficulty', exercise.difficulty, Icons.trending_up),
        ...exercise.targetMuscles.map(
          (muscle) => _buildDetailChip('Target', muscle, Icons.accessibility),
        ),
      ],
    );
  }

  Widget _buildDetailChip(String label, String value, IconData icon) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(
        value,
        style: Theme.of(context).textTheme.bodySmall,
      ),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
    );
  }

  Widget _buildExerciseControls(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        ElevatedButton.icon(
          onPressed: () {
            setState(() {
              if (index < widget.workout.exercises.length - 1) {
                _currentExerciseIndex = index + 1;
              } else {
                _showWorkoutCompleteDialog();
              }
            });
          },
          icon: const Icon(Icons.check),
          label: Text(
            index == widget.workout.exercises.length - 1
                ? 'Complete Workout'
                : 'Mark Complete',
          ),
        ),
        OutlinedButton.icon(
          onPressed: () {
            _startRestTimer(widget.workout.exercises[index].restSeconds);
          },
          icon: const Icon(Icons.timer),
          label: Text(_isRestMode ? '$_remainingRestTime s' : 'Start Rest'),
        ),
      ],
    );
  }

  Widget _buildResearchBasis() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.science,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Research Basis',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              widget.workout.researchBasis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontStyle: FontStyle.italic,
                  ),
            ),
          ],
        ),
      ),
    );
  }

  void _startRestTimer(int seconds) {
    setState(() {
      _isRestMode = true;
      _remainingRestTime = seconds;
    });

    Future.doWhile(() async {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _remainingRestTime--;
        });
      }
      if (_remainingRestTime <= 0) {
        if (mounted) {
          setState(() {
            _isRestMode = false;
          });
        }
        return false;
      }
      return true;
    });
  }

  void _showWorkoutCompleteDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Workout Complete! 🎉'),
          content: const Text(
            'Great job! You\'ve completed today\'s workout. Remember to stay hydrated and get adequate rest for recovery.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  _currentExerciseIndex = 0;
                });
              },
              child: const Text('Awesome!'),
            ),
          ],
        );
      },
    );
  }
}