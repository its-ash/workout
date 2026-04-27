import 'workout_model.dart';

class WorkoutData {
  static List<WorkoutDay> getWorkoutDays() {
    return [
      WorkoutDay(
        day: 'Monday',
        title: 'Push + Legs A — Strength & Metabolic Burn',
        description:
        'Pairs chest/shoulders/triceps with quad-dominant leg work. '
            'Supersets keep your heart rate elevated for maximum calorie burn. '
            'Rest 45–60 sec between supersets, 60–75 sec after compound sets.',
        workouts: [
          // Push block
          Workout(
            name: 'Barbell Bench Press',
            sets: '4 sets of 8–10 reps (75 sec rest)',
          ),
          Workout(
            name: 'A1: Seated Dumbbell Shoulder Press (Superset)',
            sets: '3 sets of 10–12 reps (No rest)',
          ),
          Workout(
            name: 'A2: Dumbbell Lateral Raises',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'B1: Cable Chest Fly (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'B2: Triceps Rope Pushdown',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          // Legs block
          Workout(
            name: 'Barbell Back Squat',
            sets: '4 sets of 8–12 reps (75 sec rest)',
          ),
          Workout(
            name: 'C1: Leg Extensions (Superset)',
            sets: '3 sets of 15–20 reps (No rest)',
          ),
          Workout(
            name: 'C2: Bodyweight Jump Squats',
            sets: '3 sets of 15 reps (60 sec rest)',
          ),
          Workout(
            name: 'Standing Calf Raises',
            sets: '4 sets of 20–25 reps (45 sec rest)',
          ),
          Workout(
            name: 'Metabolic Finisher — Squat Jumps or Wall Sits',
            sets: '3 rounds of 40 sec on / 20 sec off',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Tuesday',
        title: 'Pull + Legs B — Back, Biceps & Hamstrings',
        description:
        'Pairs back/biceps/rear delts with hamstring & glute-dominant leg work. '
            'Higher rep ranges and minimal rest create a powerful metabolic effect '
            'while adding thickness to the back and definition to the legs.',
        workouts: [
          // Pull block
          Workout(
            name: 'Pull-Ups or Lat Pulldown',
            sets: '4 sets of 8–12 reps (75 sec rest)',
          ),
          Workout(
            name: 'A1: Seated Cable Row (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'A2: Face Pulls',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'B1: Dumbbell Bicep Curls (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'B2: Straight-Arm Cable Pulldown',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          // Legs block
          Workout(
            name: 'Romanian Deadlift (RDL)',
            sets: '4 sets of 10–12 reps (75 sec rest)',
          ),
          Workout(
            name: 'Barbell Hip Thrusts',
            sets: '3 sets of 12–15 reps (60 sec rest)',
          ),
          Workout(
            name: 'C1: Seated Leg Curls (Superset)',
            sets: '3 sets of 15–20 reps (No rest)',
          ),
          Workout(
            name: 'C2: Adductor Machine',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'Metabolic Finisher — Glute Bridges or Kettlebell Swings',
            sets: '3 rounds of 40 sec on / 20 sec off',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Wednesday',
        title: 'HIIT, Core & Active Recovery',
        description:
        'A dedicated calorie-torching session. HIIT intervals spike your '
            'EPOC (excess post-exercise oxygen consumption) for hours after you finish. '
            'Core work targets deep stabilisers. End with low-intensity cardio to flush '
            'metabolic waste from Monday and Tuesday.',
        workouts: [
          Workout(
            name: 'Warm-Up — Jump Rope or Rowing Machine',
            sets: '5 minutes moderate pace',
          ),
          Workout(
            name: 'HIIT Block — Treadmill Sprints or Bike',
            sets: '10 rounds: 30 sec max effort / 30 sec rest',
          ),
          Workout(
            name: 'A1: Hanging Leg Raises (Superset)',
            sets: '3 sets of 15–20 reps (No rest)',
          ),
          Workout(
            name: 'A2: Ab Wheel Rollouts',
            sets: '3 sets of 10–15 reps (45 sec rest)',
          ),
          Workout(
            name: 'B1: Plank (Superset)',
            sets: '3 sets of 45–60 sec (No rest)',
          ),
          Workout(
            name: 'B2: Bicycle Crunches',
            sets: '3 sets of 20–30 reps (45 sec rest)',
          ),
          Workout(
            name: 'Russian Twists (Weighted)',
            sets: '3 sets of 20–30 reps (45 sec rest)',
          ),
          Workout(
            name: 'Low-Intensity Steady-State Cardio',
            sets: '20–25 minutes at 60–65% max heart rate',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Thursday',
        title: 'Push + Legs C — Hypertrophy & Definition',
        description:
        'Incline and cable-focused push work for upper chest and shoulder '
            'definition, combined with deep-stretch quad work. Higher rep ranges '
            'and constant tension techniques maximise muscle definition.',
        workouts: [
          // Push block
          Workout(
            name: 'Incline Dumbbell Press',
            sets: '4 sets of 10–12 reps (60 sec rest)',
          ),
          Workout(
            name: 'A1: Cable Chest Fly — Low to High (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'A2: Dumbbell Lateral Raises — Drop Set Final Set',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'Dips (Chest Version)',
            sets: '3 sets to failure (60 sec rest)',
          ),
          Workout(
            name: 'B1: Overhead Cable Triceps Extension (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'B2: Close-Grip Push-Ups',
            sets: '3 sets to failure (45 sec rest)',
          ),
          // Legs block
          Workout(
            name: 'Leg Press — High Foot Placement for Glutes',
            sets: '4 sets of 15–20 reps (60 sec rest)',
          ),
          Workout(
            name: 'Bulgarian Split Squats',
            sets: '3 sets of 12–15 reps per leg (60 sec rest)',
          ),
          Workout(
            name: 'C1: Leg Extensions (Superset)',
            sets: '3 sets of 15–20 reps (No rest)',
          ),
          Workout(
            name: 'C2: Seated Calf Raises',
            sets: '3 sets of 20–25 reps (45 sec rest)',
          ),
          Workout(
            name: 'Metabolic Finisher — Walking Lunges',
            sets: '3 rounds: 20 steps continuous (30 sec rest)',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Friday',
        title: 'Pull + Legs D — Thickness, Width & Glutes',
        description:
        'Heavy back work for muscle density combined with glute-focused '
            'leg training. Biceps are hit from multiple angles for complete development. '
            'A high-volume session that doubles as a serious fat burner.',
        workouts: [
          // Pull block
          Workout(
            name: 'T-Bar Row or Bent-Over Barbell Row',
            sets: '4 sets of 8–10 reps (75 sec rest)',
          ),
          Workout(
            name: 'A1: Wide-Grip Lat Pulldown (Superset)',
            sets: '3 sets of 12–15 reps (No rest)',
          ),
          Workout(
            name: 'A2: Rear Delt Fly (Dumbbell or Machine)',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'B1: Preacher Curls (Superset)',
            sets: '3 sets of 10–15 reps (No rest)',
          ),
          Workout(
            name: 'B2: Cable Hammer Curls',
            sets: '3 sets of 12–15 reps (45 sec rest)',
          ),
          Workout(
            name: 'Reverse Grip EZ Bar Curls',
            sets: '3 sets of 12–15 reps (45 sec rest)',
          ),
          // Legs block
          Workout(
            name: 'Barbell Hip Thrusts — Heavy',
            sets: '4 sets of 10–12 reps (75 sec rest)',
          ),
          Workout(
            name: 'Romanian Deadlift (Dumbbell)',
            sets: '3 sets of 12–15 reps (60 sec rest)',
          ),
          Workout(
            name: 'C1: Lying Leg Curls (Superset)',
            sets: '3 sets of 15–20 reps (No rest)',
          ),
          Workout(
            name: 'C2: Abductor Machine',
            sets: '3 sets of 15–20 reps (45 sec rest)',
          ),
          Workout(
            name: 'Metabolic Finisher — Kettlebell Swings or Step-Ups',
            sets: '4 rounds: 20 reps / 30 sec rest',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Saturday',
        title: 'Full Legs — Metabolic Blast & Definition',
        description:
        'All-out leg session designed to maximise calorie burn and muscular '
            'endurance. Lower weights, higher reps, zero fluff. Ends with a '
            'non-negotiable metabolic finisher for maximum fat loss stimulus.',
        workouts: [
          Workout(
            name: 'Hack Squat or Smith Machine Squat',
            sets: '4 sets of 15–20 reps (60 sec rest)',
          ),
          Workout(
            name: 'A1: Walking Lunges (Superset)',
            sets: '3 sets of 12–15 reps per leg (No rest)',
          ),
          Workout(
            name: 'A2: Goblet Squat',
            sets: '3 sets of 15 reps (45 sec rest)',
          ),
          Workout(
            name: 'B1: Leg Extensions (Superset)',
            sets: '3 sets of 20–25 reps (No rest)',
          ),
          Workout(
            name: 'B2: Lying Leg Curls',
            sets: '3 sets of 20–25 reps (45 sec rest)',
          ),
          Workout(
            name: 'Seated Calf Raises',
            sets: '4 sets of 25–30 reps (30 sec rest)',
          ),
          Workout(
            name: 'Metabolic Finisher — 5 rounds: 10 Jump Squats + 10 Burpees',
            sets: '5 rounds, 30 sec rest between rounds',
          ),
          Workout(
            name: 'Low-Intensity Steady-State Cardio',
            sets: '20 minutes — incline walk or bike',
          ),
        ],
      ),

      WorkoutDay(
        day: 'Sunday',
        title: 'Rest & Recharge',
        description:
        'Full recovery day. Muscle repair and fat loss adaptation happen '
            'during rest — skipping this will stall your results. Focus on sleep, '
            'hydration, and nutrition to set up a strong week.',
        workouts: [
          Workout(
            name: 'Full Rest',
            sets: 'Allow your body to completely recover',
          ),
          Workout(
            name: 'Light Stretching or Foam Rolling',
            sets: '15–20 minutes — ease soreness, maintain flexibility',
          ),
          Workout(
            name: 'Optional: 20-min Easy Walk',
            sets: 'Gentle movement to promote blood flow',
          ),
          Workout(
            name: 'Meal Preparation',
            sets: 'Prioritise high-protein meals for the week ahead',
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