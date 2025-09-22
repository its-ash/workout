class Workout {
  final String name;
  final String sets;
  final String? notes;

  Workout({required this.name, required this.sets, this.notes});
}

class WorkoutDay {
  final String day;
  final String title;
  final String description;
  final List<Workout> workouts;

  WorkoutDay({
    required this.day,
    required this.title,
    required this.description,
    required this.workouts,
  });
}
