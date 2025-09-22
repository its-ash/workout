import 'package:flutter_test/flutter_test.dart';
import 'package:workout/services/workout_service.dart';

void main() {
  group('WorkoutService Tests', () {
    late WorkoutService workoutService;

    setUp(() {
      workoutService = WorkoutService();
    });

    test('getWorkoutForDay returns a valid workout', () async {
      // Test getting workout for day 1
      final workout = await workoutService.getWorkoutForDay(1);
      
      expect(workout.day, equals(1));
      expect(workout.title, isNotEmpty);
      expect(workout.exercises, isNotEmpty);
      expect(workout.researchBasis, isNotEmpty);
    });

    test('getWorkoutForDay cycles through workouts correctly', () async {
      // Test that day 8 returns same as day 1 (cycling)
      final workout1 = await workoutService.getWorkoutForDay(1);
      final workout8 = await workoutService.getWorkoutForDay(8);
      
      expect(workout1.title, equals(workout8.title));
      expect(workout1.exercises.length, equals(workout8.exercises.length));
    });

    test('all workouts have required properties', () async {
      for (int day = 1; day <= 7; day++) {
        final workout = await workoutService.getWorkoutForDay(day);
        
        expect(workout.title, isNotEmpty, reason: 'Day $day workout should have title');
        expect(workout.description, isNotEmpty, reason: 'Day $day workout should have description');
        expect(workout.focus, isNotEmpty, reason: 'Day $day workout should have focus');
        expect(workout.exercises, isNotEmpty, reason: 'Day $day workout should have exercises');
        expect(workout.researchBasis, isNotEmpty, reason: 'Day $day workout should have research basis');
        expect(workout.estimatedDuration, greaterThan(0), reason: 'Day $day workout should have positive duration');
        
        // Test each exercise has required properties
        for (final exercise in workout.exercises) {
          expect(exercise.name, isNotEmpty, reason: 'Exercise should have name');
          expect(exercise.description, isNotEmpty, reason: 'Exercise should have description');
          expect(exercise.instructions, isNotEmpty, reason: 'Exercise should have instructions');
          expect(exercise.sets, greaterThan(0), reason: 'Exercise should have positive sets');
          expect(exercise.reps, greaterThan(0), reason: 'Exercise should have positive reps');
          expect(exercise.targetMuscles, isNotEmpty, reason: 'Exercise should target muscles');
        }
      }
    });
  });
}