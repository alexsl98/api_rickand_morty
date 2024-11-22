import 'package:bloc_api_rick_and_morty/data/api_rick_morty.dart';
import 'package:bloc_api_rick_and_morty/models/character_model.dart';
import 'package:bloc_api_rick_and_morty/presentation/character_bloc/character_bloc.dart';
import 'package:bloc_api_rick_and_morty/presentation/screens/character_screens.dart';
import 'package:bloc_api_rick_and_morty/presentation/screens/home_screens.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

void main() => runApp(const MyApp());

final GoRouter _router = GoRouter(routes: [
  GoRoute(
      path: '/',
      builder: (context, state) {
        return const HomeScreens();
      },
      routes: [
        GoRoute(
          path: 'characters',
          builder: (context, state) {
            final result = state.extra as Result;
            return CharacterScreens(result: result);
          },
        )
      ])
]);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterBloc(ApiProvider()),
      child: MaterialApp.router(
        title: 'Rick and Morty API',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(brightness: Brightness.dark, useMaterial3: true),
        routerConfig: _router,
      ),
    );
  }
}
