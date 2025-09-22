import 'workout_model.dart';

class WorkoutData {
  static List<WorkoutDay> getWorkoutDays() {
    return [
      WorkoutDay(
        day: 'Monday',
        title: 'Upper Body - Strength & Density',
        description: 'Focus on heavy compound lifts to build a foundation of strength, followed by supersets to increase workout density and metabolic rate.',
        workouts: [
          Workout(name: 'Barbell Bench Press', sets: '4 sets of 5-8 reps (90-120 sec rest)'),
          Workout(name: 'Bent-Over Barbell Row', sets: '4 sets of 5-8 reps (90-120 sec rest)'),
          Workout(name: 'Seated Dumbbell Overhead Press', sets: '3 sets of 8-12 reps (60-75 sec rest)'),
          Workout(name: 'Lat Pulldown (Wide Grip)', sets: '3 sets of 10-15 reps (60 sec rest)'),
          Workout(name: 'E1: Dumbbell Bicep Curls (Superset)', sets: '3 sets of 10-15 reps (No Rest)'),
          Workout(name: 'E2: Triceps Pushdowns', sets: '3 sets of 10-15 reps (60-75 sec rest)'),
        ],
      ),
      WorkoutDay(
        day: 'Tuesday',
        title: 'Lower Body - Power, Glutes & Hypertrophy',
        description: 'This routine starts with heavy power work and now includes direct glute activation for a stronger, more balanced lower body.',
        workouts: [
          Workout(name: 'Barbell Back Squat', sets: '4 sets of 5-8 reps (120 sec rest)'),
          Workout(name: 'Romanian Deadlift (RDL)', sets: '3 sets of 8-12 reps (90 sec rest)'),
          Workout(name: 'Barbell Hip Thrusts', sets: '3 sets of 8-12 reps (75 sec rest)'),
          Workout(name: 'D1: Walking Lunges (Superset)', sets: '3 sets of 10-12 reps/leg (No Rest)'),
          Workout(name: 'D2: Seated Leg Curls', sets: '3 sets of 15-20 reps (90 sec rest)'),
          Workout(name: 'Adductor Machine', sets: '3 sets of 15-20 reps (60 sec rest)'),
          Workout(name: 'Standing Calf Raises', sets: '4 sets of 15-25 reps (45-60 sec rest)'),
        ],
      ),
      WorkoutDay(
        day: 'Wednesday',
        title: 'Active Recovery & Core',
        description: 'Facilitates recovery with light activity and builds a stronger core to support your heavy lifts.',
        workouts: [
          Workout(name: 'Low-Intensity Cardio', sets: '30-45 minutes (e.g., Brisk Walking, Light Cycling)'),
          Workout(name: 'Plank', sets: '3 sets to failure (60 sec rest)'),
          Workout(name: 'Leg Raises (Lying or Hanging)', sets: '3 sets of 15-20 reps (60 sec rest)'),
        ],
      ),
      WorkoutDay(
        day: 'Thursday',
        title: 'Push Dominance - Ultimate Hypertrophy',
        description: 'This workout uses free weights and machines to target the chest, shoulders, and triceps from multiple angles for complete development.',
        workouts: [
          Workout(name: 'Incline Dumbbell Press', sets: '4 sets of 8-12 reps (75 sec rest)'),
          Workout(name: 'Dips (Chest Version)', sets: '3 sets to failure (75 sec rest)'),
          Workout(name: 'Incline Dumbbell Flye', sets: '3 sets of 12-15 reps (60 sec rest)'),
          Workout(name: 'D1: Dumbbell Lateral Raises (Superset)', sets: '3 sets of 12-15 reps (No Rest)'),
          Workout(name: 'D2: Flat Machine Chest Press', sets: '3 sets of 10-15 reps (75 sec rest)'),
          Workout(name: 'E1: Close-Grip Bench Press (Superset)', sets: '3 sets of 8-12 reps (No Rest)'),
          Workout(name: 'E2: Bench Dips', sets: '3 sets to failure (75 sec rest)'),
        ],
      ),
      WorkoutDay(
        day: 'Friday',
        title: 'Pull Strength - Ultimate Thickness & Width',
        description: 'A high-volume session to build a powerful back and fully developed biceps, targeting muscles for both width and density.',
        workouts: [
          Workout(name: 'Pull-Ups (or Assisted/Lat Pulldown)', sets: '4 sets of 6-10 reps (90-120 sec rest)'),
          Workout(name: 'T-Bar Row or Barbell Row', sets: '3 sets of 8-12 reps (90 sec rest)'),
          Workout(name: 'Seated Cable Row (Neutral Grip)', sets: '3 sets of 10-15 reps (75 sec rest)'),
          Workout(name: 'Straight-Arm Pulldown', sets: '3 sets of 12-20 reps (60 sec rest)'),
          Workout(name: 'Face Pulls', sets: '3 sets of 15-20 reps (60 sec rest)'),
          Workout(name: 'F1: Preacher Curls (Superset)', sets: '3 sets of 10-15 reps (No Rest)'),
          Workout(name: 'F2: Dumbbell Hammer Curls', sets: '3 sets of 10-15 reps (75 sec rest)'),
        ],
      ),
      WorkoutDay(
        day: 'Saturday',
        title: 'Leg Hypertrophy & Metabolic Finisher',
        description: 'Designed to induce maximum metabolic stress for leg growth and fat burning, ending with an all-out effort.',
        workouts: [
          Workout(name: 'Leg Press', sets: '4 sets of 15-20 reps (60-75 sec rest)'),
          Workout(name: 'Bulgarian Split Squats', sets: '3 sets of 10-15 reps per leg (60 sec rest)'),
          Workout(name: 'C1: Leg Extensions (Superset)', sets: '3 sets of 15-20 reps (No Rest)'),
          Workout(name: 'C2: Lying Leg Curls', sets: '3 sets of 15-20 reps (75 sec rest)'),
          Workout(name: 'Seated Calf Raises', sets: '4 sets of 20-25 reps (45 sec rest)'),
          Workout(name: 'OPTIONAL: Metabolic Finisher', sets: '5-10 mins (e.g., Kettlebell Swings, Bike Sprints)'),
        ],
      ),
      WorkoutDay(
        day: 'Sunday',
        title: 'Rest & Recharge',
        description: 'Final recovery day to prepare for the week ahead. This is when your body repairs tissue and gets stronger.',
        workouts: [
          Workout(name: 'Full Rest', sets: 'Allow your body to completely recover'),
          Workout(name: 'Light Stretching or Foam Rolling', sets: 'Gentle activity to ease soreness and maintain flexibility'),
          Workout(name: 'Meal Preparation', sets: 'Focus on nutrition and hydration for the week ahead'),
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
    // DateTime.weekday returns 1 for Monday, 7 for Sunday
    // We need 0 for Monday, 6 for Sunday to match our array
    return (now.weekday - 1) % 7;
  }
}
