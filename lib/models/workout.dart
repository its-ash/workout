class Exercise {
  final String name;
  final String description;
  final int sets;
  final int reps;
  final int restSeconds;
  final String difficulty;
  final List<String> targetMuscles;
  final String instructions;

  Exercise({
    required this.name,
    required this.description,
    required this.sets,
    required this.reps,
    required this.restSeconds,
    required this.difficulty,
    required this.targetMuscles,
    required this.instructions,
  });

  factory Exercise.fromMap(Map<String, dynamic> map) {
    return Exercise(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      sets: map['sets'] ?? 3,
      reps: map['reps'] ?? 10,
      restSeconds: map['restSeconds'] ?? 60,
      difficulty: map['difficulty'] ?? 'Beginner',
      targetMuscles: List<String>.from(map['targetMuscles'] ?? []),
      instructions: map['instructions'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'restSeconds': restSeconds,
      'difficulty': difficulty,
      'targetMuscles': targetMuscles,
      'instructions': instructions,
    };
  }
}

class Workout {
  final int day;
  final String title;
  final String description;
  final String focus;
  final int estimatedDuration;
  final List<Exercise> exercises;
  final String researchBasis;

  Workout({
    required this.day,
    required this.title,
    required this.description,
    required this.focus,
    required this.estimatedDuration,
    required this.exercises,
    required this.researchBasis,
  });

  factory Workout.fromMap(Map<String, dynamic> map) {
    return Workout(
      day: map['day'] ?? 1,
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      focus: map['focus'] ?? '',
      estimatedDuration: map['estimatedDuration'] ?? 30,
      exercises: (map['exercises'] as List<dynamic>?)
              ?.map((e) => Exercise.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      researchBasis: map['researchBasis'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'day': day,
      'title': title,
      'description': description,
      'focus': focus,
      'estimatedDuration': estimatedDuration,
      'exercises': exercises.map((e) => e.toMap()).toList(),
      'researchBasis': researchBasis,
    };
  }
}