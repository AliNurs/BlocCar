import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_bloc_car/bloc/car_bloc.dart';
import 'package:local_bloc_car/repositories/car_repository.dart';
import 'package:local_bloc_car/screens/cars/cars_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => CarRepository(),
      child: BlocProvider(
        create: (context) => CarBloc(
          carRepo: RepositoryProvider.of<CarRepository>(context),
        )..add(GetCars()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home:  const CarScreen(),
        ),
      ),
    );
  }
}
