import 'workout_model.dart';

class WorkoutData {
  static List<WorkoutDay> getWorkoutDays() {
    return [
      WorkoutDay(
        day: 'Monday',
        title: 'Upper Body - Strength & Density',
        description:
            'Focus on heavy compound lifts to build a foundation of strength, followed by supersets to increase workout density and metabolic rate.',
        workouts: [
          Workout(name: 'Barbell Bench Press', sets: '4 sets of 5-8 reps'),
          Workout(name: 'Bent-Over Barbell Row', sets: '4 sets of 5-8 reps'),
          Workout(
            name: 'Seated Dumbbell Overhead Press',
            sets: '3 sets of 8-12 reps',
          ),
          Workout(
            name: 'Lat Pulldown (Wide Grip)',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(
            name: 'E1: Dumbbell Bicep Curls (Superset)',
            sets: '4 sets of 10-15 reps',
          ),
          Workout(
            name: 'E2: Triceps Pushdowns',
            sets: '4 sets of 10-15 reps (60-75 sec rest)',
          ),
        ],
      ),
      WorkoutDay(
        day: 'Tuesday',
        title: 'Lower Body - Power, Glutes & Hypertrophy',
        description:
            'This routine starts with heavy power work and includes direct glute activation for a stronger, more balanced lower body.',
        workouts: [
          Workout(name: 'Barbell Back Squat', sets: '4 sets of 5-8 reps'),
          Workout(name: 'Romanian Deadlift (RDL)', sets: '3 sets of 8-12 reps'),
          Workout(name: 'Barbell Hip Thrusts', sets: '3 sets of 8-12 reps'),
          Workout(
            name: 'D1: Walking Lunges (Superset)',
            sets: '3 sets of 10-12 reps/leg',
          ),
          Workout(name: 'D2: Seated Leg Curls', sets: '3 sets of 15-20 reps'),
          Workout(name: 'Adductor Machine', sets: '3 sets of 15-20 reps'),
          Workout(name: 'Standing Calf Raises', sets: '4 sets of 15-25 reps'),
        ],
      ),
      WorkoutDay(
        day: 'Wednesday',
        title: 'Light Arms, Core & Recovery',
        description:
            'A high-repetition, low-stress session to pump the arms with blood, aiding recovery and adding volume. Focus on squeezing the muscle, not moving heavy weight.',
        workouts: [
          Workout(
            name: 'A1: Triceps Rope Pushdown (Superset)',
            sets: '3 sets of 15-20 reps (No Rest)',
          ),
          Workout(
            name: 'A2: Seated Incline Dumbbell Curls',
            sets: '3 sets of 15-20 reps (60 sec rest)',
          ),
          Workout(
            name: 'B1: Single-Arm Overhead Cable Ext. (Superset)',
            sets: '3 sets of 15-20 reps/arm (No Rest)',
          ),
          Workout(
            name: 'B2: Cable Hammer Curls (with rope)',
            sets: '3 sets of 15-20 reps (60 sec rest)',
          ),
          Workout(name: 'Plank', sets: '3 sets to failure (60 sec rest)'),
          Workout(
            name: 'Leg Raises (Lying or Hanging)',
            sets: '3 sets of 15-20 reps (60 sec rest)',
          ),
          Workout(name: 'Low-Intensity Cardio', sets: '20-30 minutes'),
        ],
      ),
      WorkoutDay(
        day: 'Thursday',
        title: 'Push Dominance - Ultimate Hypertrophy & Triceps',
        description:
            'Targeting the chest, shoulders, and triceps from multiple angles, with an added block to ensure complete triceps development.',
        workouts: [
          Workout(name: 'Incline Dumbbell Press', sets: '4 sets of 8-12 reps'),
          Workout(name: 'Dips (Chest Version)', sets: '3 sets to failure'),
          Workout(name: 'Incline Dumbbell Flye', sets: '3 sets of 12-15 reps'),
          Workout(
            name: 'D1: Dumbbell Lateral Raises (Superset)',
            sets: '3 sets of 12-15 reps',
          ),
          Workout(
            name: 'D2: Flat Machine Chest Press',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(name: 'Close-Grip Bench Press', sets: '3 sets of 8-12 reps'),
          Workout(
            name: 'F1: Overhead Cable Triceps Extension (Superset)',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(
            name: 'F2: Rope Pushdowns',
            sets: '3 sets of 15-20 reps (75 sec rest)',
          ),
        ],
      ),
      WorkoutDay(
        day: 'Friday',
        title: 'Pull Strength - Ultimate Thickness, Width & Biceps',
        description:
            'A high-volume session to build a powerful back and fully developed biceps, with a finisher for overall arm thickness.',
        workouts: [
          Workout(
            name: 'Pull-Ups (or Assisted/Lat Pulldown)',
            sets: '4 sets of 6-10 reps',
          ),
          Workout(
            name: 'T-Bar Row or Barbell Row',
            sets: '3 sets of 8-12 reps',
          ),
          Workout(
            name: 'Seated Cable Row (Neutral Grip)',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(name: 'Straight-Arm Pulldown', sets: '3 sets of 12-20 reps'),
          Workout(name: 'Face Pulls', sets: '3 sets of 15-20 reps'),
          Workout(
            name: 'F1: Preacher Curls (Superset)',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(
            name: 'F2: Dumbbell Hammer Curls',
            sets: '3 sets of 10-15 reps',
          ),
          Workout(
            name: 'G: Reverse Grip EZ Bar Curls',
            sets: '3 sets of 12-15 reps (60 sec rest)',
          ),
        ],
      ),
      WorkoutDay(
        day: 'Saturday',
        title: 'Leg Hypertrophy & Metabolic Finisher',
        description:
            'Designed to induce maximum metabolic stress for leg growth and fat burning, ending with an all-out effort.',
        workouts: [
          Workout(name: 'Leg Press', sets: '4 sets of 15-20 reps'),
          Workout(
            name: 'Bulgarian Split Squats',
            sets: '3 sets of 10-15 reps per leg',
          ),
          Workout(
            name: 'C1: Leg Extensions (Superset)',
            sets: '3 sets of 15-20 reps',
          ),
          Workout(name: 'C2: Lying Leg Curls', sets: '3 sets of 15-20 reps'),
          Workout(name: 'Seated Calf Raises', sets: '4 sets of 20-25 reps'),
          Workout(name: 'OPTIONAL: Metabolic Finisher', sets: '5-10 mins'),
        ],
      ),
      WorkoutDay(
        day: 'Sunday',
        title: 'Rest & Recharge',
        description:
            'Final recovery day to prepare for the week ahead. This is when your body repairs tissue and gets stronger.',
        workouts: [
          Workout(
            name: 'Full Rest',
            sets: 'Allow your body to completely recover',
          ),
          Workout(
            name: 'Light Stretching or Foam Rolling',
            sets: 'Ease soreness and maintain flexibility',
          ),
          Workout(
            name: 'Meal Preparation',
            sets: 'Focus on nutrition for the week ahead',
          ),
        ],
      ),
    ];
  }

  static String getDayAbbreviation(String day) {
    switch (day) {
      case 'Monday':
        return 'Mon';
      case 'Tuesday':
        return 'Tue';
      case 'Wednesday':
        return 'Wed';
      case 'Thursday':
        return 'Thu';
      case 'Friday':
        return 'Fri';
      case 'Saturday':
        return 'Sat';
      case 'Sunday':
        return 'Sun';
      default:
        return day.substring(0, 3);
    }
  }

  static int getCurrentDayIndex() {
    final now = DateTime.now();
    return now.weekday - 1;
  }
}
