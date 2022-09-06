import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:local_bloc_car/bloc/car_bloc.dart';
import 'package:local_bloc_car/models/car_model.dart';

import '../create/create_screen.dart';

part 'widgets/car_item.dart';
part 'widgets/app_bar.dart';

class CarScreen extends StatefulWidget {
  const CarScreen({Key? key}) : super(key: key);

  @override
  State<CarScreen> createState() => _CarScreenState();
}

class _CarScreenState extends State<CarScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
      appBar: const _AppBar(),
      body: BlocBuilder<CarBloc, CarStates>(
        builder: (context, state) {
          if (state is CarLoadingState) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CarSuccessState) {
            return ListView.separated(
              itemCount: state.cars.length,
              padding: const EdgeInsets.all(16),
              separatorBuilder: (context, index) => const SizedBox(height: 24),
              itemBuilder: (context, index) => _CarItem(
                model: state.cars[index],
              ),
            );
          }

          return const Center(
            child: Text('Данные еще не загружены'),
          );
        },
      ),
    );
  }
}
