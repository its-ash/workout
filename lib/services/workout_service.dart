import 'package:shared_preferences/shared_preferences.dart';
import '../models/workout.dart';

class WorkoutService {
  // Research-based workout program following scientific principles
  // Based on progressive overload, muscle recovery, and balanced training
  static const int _totalWorkoutDays = 7; // One week cycle

  Future<int> getNextWorkoutDay() async {
    final prefs = await SharedPreferences.getInstance();
    int currentDay = prefs.getInt('current_workout_day') ?? 0;
    currentDay = (currentDay % _totalWorkoutDays) + 1;
    await prefs.setInt('current_workout_day', currentDay);
    return currentDay;
  }

  Future<Workout> getWorkoutForDay(int day) async {
    final workouts = _getResearchBasedWorkouts();
    final workoutIndex = (day - 1) % workouts.length;
    return workouts[workoutIndex];
  }

  List<Workout> _getResearchBasedWorkouts() {
    return [
      // Day 1: Upper Body Push
      Workout(
        day: 1,
        title: "Upper Body Push Day",
        description: "Focus on chest, shoulders, and triceps",
        focus: "Push muscles (Chest, Shoulders, Triceps)",
        estimatedDuration: 45,
        researchBasis: "Based on push/pull/legs split research showing optimal muscle recovery and growth patterns (Helms et al., 2014)",
        exercises: [
          Exercise(
            name: "Push-ups",
            description: "Classic bodyweight exercise for chest and triceps",
            sets: 3,
            reps: 12,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Chest", "Triceps", "Shoulders"],
            instructions: "Keep body straight, lower chest to floor, push back up. Modify on knees if needed.",
          ),
          Exercise(
            name: "Pike Push-ups",
            description: "Targets shoulders and upper chest",
            sets: 3,
            reps: 8,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Shoulders", "Upper Chest"],
            instructions: "Form inverted V with body, lower head toward floor, push back up.",
          ),
          Exercise(
            name: "Tricep Dips",
            description: "Bodyweight exercise for triceps",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Triceps", "Shoulders"],
            instructions: "Use chair or bench, lower body by bending arms, push back up.",
          ),
          Exercise(
            name: "Plank to Push-up",
            description: "Dynamic exercise combining core and push muscles",
            sets: 2,
            reps: 8,
            restSeconds: 90,
            difficulty: "Intermediate",
            targetMuscles: ["Core", "Chest", "Triceps"],
            instructions: "Start in plank, transition to push-up position and back.",
          ),
        ],
      ),
      
      // Day 2: Lower Body
      Workout(
        day: 2,
        title: "Lower Body Power",
        description: "Comprehensive leg and glute workout",
        focus: "Legs and Glutes",
        estimatedDuration: 40,
        researchBasis: "Research shows compound movements like squats activate multiple muscle groups efficiently (Schoenfeld et al., 2015)",
        exercises: [
          Exercise(
            name: "Bodyweight Squats",
            description: "Fundamental lower body movement",
            sets: 3,
            reps: 15,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Quadriceps", "Glutes", "Hamstrings"],
            instructions: "Feet shoulder-width apart, lower until thighs parallel to floor, stand up.",
          ),
          Exercise(
            name: "Lunges",
            description: "Unilateral leg exercise",
            sets: 3,
            reps: 12,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Quadriceps", "Glutes", "Hamstrings"],
            instructions: "Step forward into lunge, lower back knee toward floor, return to start.",
          ),
          Exercise(
            name: "Single-leg Glute Bridges",
            description: "Targets glutes and hamstrings",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Glutes", "Hamstrings"],
            instructions: "Lie on back, lift one leg, bridge up with other leg, lower slowly.",
          ),
          Exercise(
            name: "Wall Sit",
            description: "Isometric quad strengthener",
            sets: 3,
            reps: 30,
            restSeconds: 90,
            difficulty: "Beginner",
            targetMuscles: ["Quadriceps", "Glutes"],
            instructions: "Back against wall, slide down to sitting position, hold for specified time.",
          ),
        ],
      ),
      
      // Day 3: Upper Body Pull
      Workout(
        day: 3,
        title: "Upper Body Pull Day",
        description: "Back and biceps focused workout",
        focus: "Pull muscles (Back, Biceps)",
        estimatedDuration: 40,
        researchBasis: "Pull movements balance push exercises, preventing muscle imbalances (Saeterbakken et al., 2013)",
        exercises: [
          Exercise(
            name: "Superman",
            description: "Strengthens lower back and posterior chain",
            sets: 3,
            reps: 12,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Lower Back", "Glutes"],
            instructions: "Lie face down, lift chest and legs simultaneously, hold briefly, lower.",
          ),
          Exercise(
            name: "Reverse Fly",
            description: "Targets rear deltoids and upper back",
            sets: 3,
            reps: 12,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Rear Deltoids", "Upper Back"],
            instructions: "Bend forward slightly, arms out to sides, squeeze shoulder blades together.",
          ),
          Exercise(
            name: "Prone Y-T-W",
            description: "Shoulder stability and back strength",
            sets: 2,
            reps: 8,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Shoulders", "Upper Back"],
            instructions: "Lie face down, move arms in Y, T, and W positions, hold each briefly.",
          ),
          Exercise(
            name: "Plank Rows",
            description: "Core stability with pulling motion",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Core", "Back"],
            instructions: "In plank position, row one arm back, alternate sides while maintaining plank.",
          ),
        ],
      ),
      
      // Day 4: Active Recovery/Core
      Workout(
        day: 4,
        title: "Active Recovery & Core",
        description: "Low-intensity movement and core strengthening",
        focus: "Core and Mobility",
        estimatedDuration: 30,
        researchBasis: "Active recovery promotes blood flow and aids recovery while maintaining movement patterns (Vaile et al., 2008)",
        exercises: [
          Exercise(
            name: "Plank",
            description: "Core stability exercise",
            sets: 3,
            reps: 30,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Core"],
            instructions: "Hold straight body position from forearms and toes, engage core.",
          ),
          Exercise(
            name: "Dead Bug",
            description: "Core control and stability",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Core"],
            instructions: "Lie on back, arms up, knees bent. Lower opposite arm and leg, return to start.",
          ),
          Exercise(
            name: "Bird Dog",
            description: "Core stability and balance",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Core", "Lower Back"],
            instructions: "On hands and knees, extend opposite arm and leg, hold, return to start.",
          ),
          Exercise(
            name: "Cat-Cow Stretch",
            description: "Spinal mobility exercise",
            sets: 2,
            reps: 10,
            restSeconds: 30,
            difficulty: "Beginner",
            targetMuscles: ["Spine", "Core"],
            instructions: "On hands and knees, arch and round spine alternately in flowing motion.",
          ),
        ],
      ),
      
      // Day 5: Full Body HIIT
      Workout(
        day: 5,
        title: "Full Body HIIT",
        description: "High-intensity interval training",
        focus: "Cardiovascular and Full Body",
        estimatedDuration: 35,
        researchBasis: "HIIT improves both aerobic and anaerobic fitness while being time-efficient (Gibala et al., 2012)",
        exercises: [
          Exercise(
            name: "Burpees",
            description: "Full body explosive movement",
            sets: 4,
            reps: 8,
            restSeconds: 90,
            difficulty: "Intermediate",
            targetMuscles: ["Full Body"],
            instructions: "Squat down, jump back to plank, push-up, jump feet forward, jump up with arms overhead.",
          ),
          Exercise(
            name: "Mountain Climbers",
            description: "Cardio and core exercise",
            sets: 4,
            reps: 20,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Core", "Shoulders"],
            instructions: "In plank position, alternate bringing knees to chest rapidly.",
          ),
          Exercise(
            name: "Jump Squats",
            description: "Explosive lower body exercise",
            sets: 4,
            reps: 12,
            restSeconds: 90,
            difficulty: "Intermediate",
            targetMuscles: ["Legs", "Glutes"],
            instructions: "Perform squat, then explode up into jump, land softly and repeat.",
          ),
          Exercise(
            name: "High Knees",
            description: "Cardio and leg exercise",
            sets: 3,
            reps: 30,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Legs", "Core"],
            instructions: "Run in place bringing knees up to waist level rapidly.",
          ),
        ],
      ),
      
      // Day 6: Flexibility and Strength
      Workout(
        day: 6,
        title: "Flexibility & Strength",
        description: "Balance strength with mobility work",
        focus: "Flexibility and Functional Strength",
        estimatedDuration: 35,
        researchBasis: "Combining strength and flexibility training improves overall functional capacity (Behm et al., 2016)",
        exercises: [
          Exercise(
            name: "Yoga Flow",
            description: "Dynamic stretching sequence",
            sets: 2,
            reps: 5,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Full Body"],
            instructions: "Flow through downward dog, warrior pose, cobra pose sequence.",
          ),
          Exercise(
            name: "Single-leg Deadlifts",
            description: "Balance and posterior chain",
            sets: 3,
            reps: 8,
            restSeconds: 60,
            difficulty: "Intermediate",
            targetMuscles: ["Hamstrings", "Glutes", "Core"],
            instructions: "Stand on one leg, hinge at hip, reach toward floor, return to standing.",
          ),
          Exercise(
            name: "Lateral Lunges",
            description: "Hip mobility and leg strength",
            sets: 3,
            reps: 10,
            restSeconds: 60,
            difficulty: "Beginner",
            targetMuscles: ["Inner Thighs", "Glutes"],
            instructions: "Step wide to one side, sit back into lunge, push back to center.",
          ),
          Exercise(
            name: "Thoracic Spine Rotation",
            description: "Upper back mobility",
            sets: 2,
            reps: 10,
            restSeconds: 30,
            difficulty: "Beginner",
            targetMuscles: ["Upper Back", "Shoulders"],
            instructions: "On hands and knees, rotate upper body side to side with control.",
          ),
        ],
      ),
      
      // Day 7: Rest or Light Activity
      Workout(
        day: 7,
        title: "Active Rest Day",
        description: "Light movement and recovery",
        focus: "Recovery and Gentle Movement",
        estimatedDuration: 20,
        researchBasis: "Rest days are crucial for adaptation and preventing overtraining (Kellmann et al., 2018)",
        exercises: [
          Exercise(
            name: "Gentle Walking",
            description: "Low-intensity cardiovascular activity",
            sets: 1,
            reps: 20,
            restSeconds: 0,
            difficulty: "Beginner",
            targetMuscles: ["Legs"],
            instructions: "Take a leisurely 20-minute walk outdoors or indoors at comfortable pace.",
          ),
          Exercise(
            name: "Deep Breathing",
            description: "Relaxation and recovery",
            sets: 3,
            reps: 10,
            restSeconds: 30,
            difficulty: "Beginner",
            targetMuscles: ["Respiratory"],
            instructions: "Sit comfortably, breathe deeply in through nose, out through mouth slowly.",
          ),
          Exercise(
            name: "Gentle Stretching",
            description: "Full body flexibility",
            sets: 1,
            reps: 10,
            restSeconds: 0,
            difficulty: "Beginner",
            targetMuscles: ["Full Body"],
            instructions: "Hold each stretch for 30 seconds: neck, shoulders, back, hips, legs.",
          ),
          Exercise(
            name: "Foam Rolling",
            description: "Self-myofascial release",
            sets: 1,
            reps: 5,
            restSeconds: 0,
            difficulty: "Beginner",
            targetMuscles: ["Full Body"],
            instructions: "Roll major muscle groups gently for 1-2 minutes each if foam roller available.",
          ),
        ],
      ),
    ];
  }
}