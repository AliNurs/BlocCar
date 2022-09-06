// ignore_for_file: depend_on_referenced_packages, overridden_fields

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stream_transform/stream_transform.dart';
import 'package:local_bloc_car/models/car_model.dart';
import 'package:local_bloc_car/repositories/car_repository.dart';

EventTransformer<E> _restartableDebounce<E>() {
  return (events, mapper) =>
      events.debounce(const Duration(milliseconds: 400)).switchMap(mapper);
}

class CarBloc extends Bloc<CarEvents, CarStates> {
  CarBloc({
    required this.carRepo,
  }) : super(CarInitialState([])) {
    on<GetCars>((event, emit) async {
      emit(CarLoadingState(state.cars));
      await Future.delayed(const Duration(seconds: 1));
      final cars = carRepo.getCars();
      allCars = cars;
      emit(CarSuccessState(cars));
    });

      on<SearchCars>(
      (event, emit) async {
        final newCars = allCars.where((e) {
          final fullName = '${e.brand} ${e.model}';
          return fullName.toLowerCase().contains(event.text.toLowerCase());
        }).toList();
        emit(CarSuccessState(newCars));
      },
      transformer: _restartableDebounce(),
    );

    on<AddCar>(
      (event, emit) async {
        emit(CarLoadingState(state.cars));
        //  print(allCars);
        await Future.delayed(const Duration(seconds: 2));
        allCars.add(event.car);
        emit(CarSuccessState(allCars));
      },
    );
  
    on<FilterCars>(

      (event, emit) async {
  

switch (event.filter) {
  case Filters.byName:
    allCars.sort((a, b) =>a.model.compareTo(b.model) );
    break;
  case Filters.byYear:
     allCars.sort((a, b) =>a.year.compareTo(b.year) );
    break;
  case Filters.byPrice:
     allCars.sort((a, b) =>a.price.compareTo(b.price) );
    break;
  default:
}


        emit(CarSuccessState(allCars));
      },
     
    );
  }
  @override
  void onTransition(Transition<CarEvents, CarStates> transition) {
    super.onTransition(transition);
  }

  final CarRepository carRepo;
  List<CarModel> allCars = [];
}

abstract class CarEvents {}

class GetCars extends CarEvents {}

class SearchCars extends CarEvents {
  final String text;

  SearchCars(this.text);
}

class FilterCars extends CarEvents {
  final Filters filter;

  FilterCars(this.filter);
}

class AddCar extends CarEvents {
  final CarModel car;

  AddCar(this.car);
}

enum Filters { byYear, byPrice, byName }

//

abstract class CarStates {
  CarStates(this.cars);
  final List<CarModel> cars;
}

class CarLoadingState extends CarStates {
  CarLoadingState(this.cars) : super(cars);
  @override
  final List<CarModel> cars;
}

class CarInitialState extends CarStates {
  CarInitialState(this.cars) : super(cars);
  @override
  final List<CarModel> cars;
}

class CarErrorState extends CarStates {
  CarErrorState(this.cars) : super(cars);
  @override
  final List<CarModel> cars;
}

class CarSuccessState extends CarStates {
  @override
  final List<CarModel> cars;

  CarSuccessState(this.cars) : super(cars);
}
