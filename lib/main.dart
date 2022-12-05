import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shifts_demo/controller/activity_bloc/activity_bloc.dart';
import 'package:shifts_demo/controller/sync_data_bloc/sync_data_bloc.dart';
import 'package:shifts_demo/screens/activities_screen.dart';
import 'package:shifts_demo/screens/new_activities_screen.dart';
import 'controller/open_shift_bloc/open_shift_bloc.dart';
import 'models/screen_args_model.dart';
import 'models/shift_activity_model.dart';
import 'screens/new_shift_screen.dart';
import 'screens/open_shift_screen.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ActivityBloc>(create: (context) => ActivityBloc()),
        BlocProvider<OpenShiftBloc>(
            create: (context) => OpenShiftBloc()..add(GetData())),
        BlocProvider<SyncDataBloc>(create: (context) => SyncDataBloc())
      ],
      child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(primarySwatch: Colors.blue),
          onGenerateRoute: RouteGenerator.generateRoute,
          initialRoute: '/'),
    );
  }
}

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (context) => const MyHomePage());
      case '/openShift':
        return MaterialPageRoute(
          builder: (context) => const OpenShiftListScreen(),
        );
      case '/newShift':
        final args = settings.arguments as ShiftScreenArguments;
        return MaterialPageRoute(
            builder: (context) =>
                NewShiftScreen(data: args.data, isUpdate: args.isUpdate));
      case '/Activity':
        final args = settings.arguments as ShiftActivityModel;
        return MaterialPageRoute(
            builder: (context) => ActivitiesScreen(data: args));
      case '/newActivities':
        final args = settings.arguments as ScreenArguments;
        return MaterialPageRoute(
            builder: (context) => NewActivitiesScreen(
                data: args.data,
                index: args.index,
                isUpdate: args.isUpdate,
                activityShiftModel: args.activityData));
      default:
        return MaterialPageRoute(builder: (context) => const MyHomePage());
    }
  }
}
