# Workout App

A Flutter workout app that shows research-based workouts and changes automatically day-wise.

## Features

- 🏋️ **Research-Based Workouts**: All workouts are based on scientific research and exercise science principles
- 📅 **Day-Wise Progression**: Automatically changes workout based on the day, following a structured 7-day cycle
- 💪 **Comprehensive Exercise Library**: Covers all major muscle groups with proper form instructions
- ⏱️ **Built-in Timers**: Rest timers and workout tracking for optimal performance
- 📱 **Clean UI**: Modern, intuitive interface with Material Design 3
- 🔄 **Progressive Training**: Follows push/pull/legs split with active recovery days

## Workout Program

The app follows a science-based 7-day workout cycle:

1. **Day 1**: Upper Body Push (Chest, Shoulders, Triceps)
2. **Day 2**: Lower Body Power (Legs and Glutes)
3. **Day 3**: Upper Body Pull (Back, Biceps)
4. **Day 4**: Active Recovery & Core
5. **Day 5**: Full Body HIIT
6. **Day 6**: Flexibility & Strength
7. **Day 7**: Active Rest Day

## Research Basis

All workouts are based on peer-reviewed research including:
- Progressive overload principles (Helms et al., 2014)
- Optimal muscle recovery patterns
- Push/pull/legs split effectiveness (Schoenfeld et al., 2015)
- HIIT benefits for cardiovascular fitness (Gibala et al., 2012)
- Active recovery importance (Vaile et al., 2008)

## Getting Started

### Prerequisites
- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/its-ash/workout.git
cd workout
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Testing

Run tests with:
```bash
flutter test
```

## Features in Detail

### Automatic Day-Wise Changes
- The app automatically detects new days and progresses to the next workout
- Uses SharedPreferences to persist workout progress
- Cycles through the 7-day program continuously

### Exercise Tracking
- Mark exercises as complete
- Built-in rest timers between sets
- Progress tracking through workout sessions
- Detailed exercise instructions and form cues

### Research-Based Design
- Each workout includes its scientific basis
- Balanced muscle group targeting
- Appropriate rest periods and progressive difficulty
- Includes both strength and cardiovascular training

## Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/
│   └── workout.dart         # Data models for workouts and exercises
├── services/
│   └── workout_service.dart # Business logic for workout management
└── screens/
    └── workout_screen.dart  # UI for displaying workouts
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details.