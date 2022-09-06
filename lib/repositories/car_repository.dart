import 'package:local_bloc_car/models/car_model.dart';

class CarRepository {
  List<CarModel> getCars() {
    return _cars;
  }
}

final _cars = [
  CarModel(
    urlImage:
        'https://upload.wikimedia.org/wikipedia/commons/f/ff/08-Subaru-Legacy-SpecB.jpg',
    price: 5500.0,
    brand: 'Subaru',
    model: 'Legacy',
    year: 2006,
  ),
  CarModel(
    urlImage:
        'https://editorial.pxcrush.net/carsales/general/editorial/toyota-camry-gr-sport-2.jpg?width=1024&height=682',
    price: 32000.0,
    brand: 'Toyota',
    model: 'Camry 70',
    year: 2022,
  ),
  CarModel(
    urlImage:
        'https://upload.wikimedia.org/wikipedia/commons/f/f6/Mercedes-Benz_S_350_CDI_BlueEFFICIENCY_4MATIC_%28W_221%2C_Facelift%29_%E2%80%93_Frontansicht%2C_6._Mai_2011%2C_Velbert.jpg',
    price: 15000.0,
    brand: 'Mercedes-Benz',
    model: 'w221',
    year: 2008,
  ),
  CarModel(
    urlImage:
        'https://hdpic.club/uploads/posts/2021-12/1638972110_1-hdpic-club-p-mashina-zhiguli-1.jpg',
    price: 2500.0,
    brand: 'ВАЗ',
    model: '2101',
    year: 150,
  ),
  CarModel(
    urlImage:
        'https://upload.wikimedia.org/wikipedia/commons/1/16/Bugatti_Divo%2C_GIMS_2019%2C_Le_Grand-Saconnex_%28GIMS0029%29.jpg',
    price: 2600.0,
    brand: 'Bugatti',
    model: 'Divo',
    year: 2022,
  ),
];
