import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'src/core/theme/app_theme.dart';
import 'src/features/auth/presentation/welcome_screen.dart';
import 'src/features/auth/presentation/login_screen.dart';
import 'src/features/auth/presentation/register_screen.dart';
import 'src/features/home/presentation/home_screen.dart';
import 'src/features/lesson/presentation/lesson_screen.dart';
import 'src/features/lesson/presentation/learn_screen.dart';
import 'src/features/lesson/presentation/writing_practice_screen.dart';
import 'src/features/lesson/presentation/listening_speaking_screen.dart';
import 'src/features/profile/presentation/profile_screen.dart';

void main() {
  runApp(const MandarinQuestApp());
}

class MandarinQuestApp extends StatelessWidget {
  const MandarinQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Mandarin Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: '/welcome',
  routes: [
    GoRoute(
      path: '/welcome',
      builder: (context, state) => const WelcomeScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/register',
      builder: (context, state) => const RegisterScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/lesson/:id',
      builder: (context, state) {
        final id = state.pathParameters['id']!;
        return LessonScreen(lessonId: id);
      },
    ),
    GoRoute(
      path: '/learn',
      builder: (context, state) => const LearnScreen(),
    ),
    GoRoute(
      path: '/writing-practice',
      builder: (context, state) => const WritingPracticeScreen(),
    ),
    GoRoute(
      path: '/profile',
      builder: (context, state) => const ProfileScreen(),
    ),
    GoRoute(
      path: '/listening-speaking',
      builder: (context, state) => const ListeningSpeakingScreen(),
    ),
  ],
);
