import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/description/description_cubit.dart';
import 'cubit/home/home_cubit.dart';
import 'navigation/navigation.dart';
import 'theme/app_theme.dart';

class Application extends StatelessWidget {
  final String _title = 'Todoshechka';

  const Application({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<HomeCubit>(create: (context) => HomeCubit()),
        BlocProvider<DescriptionCubit>(create: (context) => DescriptionCubit()),
      ],
      child: MaterialApp(
        title: _title,
        theme: AppTheme.theme,
        debugShowCheckedModeBanner: false,
        routes: Navigation.routes,
        initialRoute: Navigation.initialRoute,
      ),
    );
  }
}
