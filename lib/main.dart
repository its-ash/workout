import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'workout_model.dart';
import 'workout_data.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Color(0xFF001d3d),
    statusBarIconBrightness: Brightness.light,
  ));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Today\'s Workout',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Color(0xFF001d3d),
          brightness: Brightness.light,
        ),
      ),
      home: const WorkoutHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class WorkoutHomePage extends StatefulWidget {
  const WorkoutHomePage({super.key});

  @override
  State<WorkoutHomePage> createState() => _WorkoutHomePageState();
}

class _WorkoutHomePageState extends State<WorkoutHomePage> {
  late WorkoutDay todaysWorkout;
  bool isRestDay = false;
  // Track completed exercises
  Set<int> completedExercises = {};

  @override
  void initState() {
    super.initState();
    _loadTodaysWorkout();
  }

  void _loadTodaysWorkout() {
    final currentDayIndex = WorkoutData.getCurrentDayIndex();
    final workoutDays = WorkoutData.getWorkoutDays();
    todaysWorkout = workoutDays[currentDayIndex];
    isRestDay = todaysWorkout.day == 'Wednesday' || todaysWorkout.day == 'Sunday';
  }

  String _getCurrentDayName() {
    final now = DateTime.now();
    final days = ['Sunday', 'Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday'];
    return days[now.weekday % 7];
  }

  void _toggleExerciseCompletion(int index) {
    setState(() {
      if (completedExercises.contains(index)) {
        completedExercises.remove(index);
      } else {
        completedExercises.add(index);
      }
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good morning!';
    } else if (hour < 17) {
      return 'Good afternoon!';
    } else {
      return 'Good evening!';
    }
  }

  Widget _buildRestStat(IconData icon, String label) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          icon,
          size: 24,
          color: Colors.white,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withAlpha(204),
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    // Define custom colors
    const Color primaryCoral = Color(0xFFfb6f92);
    const Color primaryDarkBlue = Color(0xFF001d3d);
    const Color lightCoral = Color(0xFFFFF0F3);
    const Color darkGreen = Color(0xFF2D5016);
    const Color lightGreen = Color(0xFFE8F5E8);

    return Scaffold(
      backgroundColor: isRestDay ? lightGreen : lightCoral,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 250,
              floating: false,
              pinned: true,
              backgroundColor: primaryDarkBlue,
              elevation: 0,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [primaryDarkBlue, const Color(0xFF000B1A)],
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        children: [
                          // Top row with greeting and date
                          Padding(
                            padding: const EdgeInsets.only(top: 16),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _getGreeting(),
                                      style: TextStyle(
                                        color: Colors.white.withAlpha(204),
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                    Text(
                                      'Let\'s ${isRestDay ? 'recover' : 'workout'}!',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white.withAlpha(51),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: Colors.white.withAlpha(77),
                                      width: 1,
                                    ),
                                  ),
                                  child: Text(
                                    _getCurrentDayName(),
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const Spacer(),

                          // Center content with icon and title
                          Column(
                            children: [
                              Container(
                                width: 80,
                                height: 80,
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(38),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(51),
                                    width: 2,
                                  ),
                                ),
                                child: Icon(
                                  isRestDay ? Icons.spa : Icons.fitness_center,
                                  size: 40,
                                  color: Colors.white,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                'Today\'s ${isRestDay ? 'Recovery' : 'Workout'}',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),

                          const Spacer(),

                          // Progress indicator for workout days
                          if (!isRestDay)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Progress',
                                        style: TextStyle(
                                          color: Colors.white.withAlpha(204),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      Text(
                                        '${completedExercises.length}/${todaysWorkout.workouts.length}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    height: 4,
                                    decoration: BoxDecoration(
                                      color: Colors.white.withAlpha(51),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: completedExercises.length,
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: primaryCoral,
                                              borderRadius: BorderRadius.circular(2),
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          flex: todaysWorkout.workouts.length - completedExercises.length,
                                          child: const SizedBox(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          // Stats row for rest days
                          if (isRestDay)
                            Padding(
                              padding: const EdgeInsets.only(bottom: 16),
                              child: Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: Colors.white.withAlpha(26),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.white.withAlpha(51),
                                    width: 1,
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    _buildRestStat(Icons.self_improvement, 'Recovery'),
                                    _buildRestStat(Icons.schedule, 'Rest Day'),
                                    _buildRestStat(Icons.refresh, 'Recharge'),
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Main Content
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Day Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withAlpha(26),
                            offset: const Offset(0, 4),
                            blurRadius: 12,
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: isRestDay
                                    ? lightGreen
                                    : lightCoral,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  todaysWorkout.day.toUpperCase(),
                                  style: TextStyle(
                                    color: isRestDay
                                      ? darkGreen
                                      : primaryDarkBlue,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            todaysWorkout.title,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: primaryDarkBlue,
                              height: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            todaysWorkout.description,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Exercises Section
                    Text(
                      isRestDay ? 'Recovery Activities' : 'Today\'s Exercises',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: primaryDarkBlue,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Exercise Cards
                    ...todaysWorkout.workouts.asMap().entries.map((entry) {
                      final index = entry.key;
                      final workout = entry.value;

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: isRestDay
                              ? lightGreen
                              : lightCoral,
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withAlpha(13),
                              offset: const Offset(0, 2),
                              blurRadius: 8,
                              spreadRadius: 0,
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            // Exercise Number
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: isRestDay
                                  ? lightGreen
                                  : lightCoral,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Center(
                                child: Text(
                                  '${index + 1}',
                                  style: TextStyle(
                                    color: isRestDay
                                      ? darkGreen
                                      : primaryDarkBlue,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),

                            // Exercise Details
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workout.name,
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                      color: primaryDarkBlue,
                                      height: 1.3,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    workout.sets,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade700,
                                      height: 1.3,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // Checkmark Icon
                            if (!isRestDay)
                              GestureDetector(
                                onTap: () => _toggleExerciseCompletion(index),
                                child: Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: completedExercises.contains(index)
                                        ? primaryCoral
                                        : Colors.grey.shade400,
                                      width: 2,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                    color: completedExercises.contains(index)
                                      ? primaryCoral
                                      : Colors.transparent,
                                  ),
                                  child: Icon(
                                    completedExercises.contains(index)
                                      ? Icons.check
                                      : Icons.check_box_outline_blank,
                                    size: 18,
                                    color: completedExercises.contains(index)
                                      ? Colors.white
                                      : Colors.grey.shade500,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),

                    const SizedBox(height: 40),

                    // Bottom Motivation Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: isRestDay
                            ? [lightGreen, const Color(0xFFD4EDDA)]
                            : [lightCoral, const Color(0xFFFFE0E1)],
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            isRestDay ? Icons.self_improvement : Icons.emoji_events,
                            size: 32,
                            color: isRestDay
                              ? darkGreen
                              : primaryDarkBlue,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            isRestDay
                              ? 'Rest days are just as important as workout days!'
                              : 'You\'ve got this! Stay consistent and strong.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: isRestDay
                                ? darkGreen
                                : primaryDarkBlue,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
