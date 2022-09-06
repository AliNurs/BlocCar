// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:local_bloc_car/bloc/car_bloc.dart';
import 'package:local_bloc_car/models/car_model.dart';
import 'package:local_bloc_car/screens/create/widgets/app_button.dart';
import 'package:local_bloc_car/screens/create/widgets/app_text_fields.dart';

class CreateScreen extends StatefulWidget {
  const CreateScreen({super.key});

  @override
  State<CreateScreen> createState() => _CreateScreenState();
}

class _CreateScreenState extends State<CreateScreen> {
  final brandController = TextEditingController();

  final modelController = TextEditingController();

  final yearController = TextEditingController();

  final priceController = TextEditingController();

  final linkController = TextEditingController();
  // ignore: unused_field
  final ImagePicker _picker = ImagePicker();
  late XFile _image;
  File? imageFile;

  String get symbols => r'[a-zA-ZА-Яа-я\s]';
  String get symbolModel => r'[a-zA-ZА-Яа-я0-9\s]';
  String get numbers => r'[0-9.,]';

  final isFullFilled = ValueNotifier<bool>(false);
  final isCamera = ValueNotifier<bool>(true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Добавление авто'),
      ),
      body: ListView(padding: const EdgeInsets.all(16), children: [
        AppTextFields(
            onChanged: (v) {
              chekValidation();
            },
            label: 'Бренд',
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(symbols))
            ],
            controller: brandController),
        const SizedBox(height: 15),
        AppTextFields(
            onChanged: (v) {
              chekValidation();
            },
            label: 'Модель',
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(symbolModel))
            ],
            controller: modelController),
        const SizedBox(height: 15),
        AppTextFields(
            onChanged: (v) {
              chekValidation();
            },
            label: 'Год',
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(numbers))
            ],
            maxLength: 4,
            keyboardType: TextInputType.number,
            controller: yearController),
        const SizedBox(height: 15),
        AppTextFields(
            onChanged: (v) {
              chekValidation();
            },
            label: 'USD',
            inputFormatter: [
              FilteringTextInputFormatter.allow(RegExp(numbers))
            ],
            maxLength: 10,
            keyboardType: TextInputType.datetime,
            controller: priceController),
        const SizedBox(height: 15),
        ValueListenableBuilder(
            valueListenable: isCamera,
            child: const SizedBox(height: 15),
            builder: (context, value, child) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Visibility(
                    visible: isCamera.value,
                    replacement: AppTextFields(
                        onChanged: (v) {
                          chekValidation();
                        },
                        label: 'Ссылка на фото',
                        keyboardType: TextInputType.url,
                        maxLength: 10000000,
                        controller: linkController),
                    child: SizedBox(
                      height: 45,
                      child: Row(
                        children: [
                          AppButton(
                            isFullFilled: true,
                            isLoading: false,
                            onPressed: () {
                              showBottomSheet(
                                  context: context,
                                  builder: (context) {
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: Colors.grey.shade200,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 13,
                                            spreadRadius: 5,
                                            color:
                                                Colors.black.withOpacity(0.2),
                                          ),
                                        ],
                                      ),
                                      height: 200,
                                      width: double.infinity,
                                      child: Padding(
                                        padding: const EdgeInsets.all(16),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            const Text(
                                                'Выберите Камеру или Галерею'),
                                            const SizedBox(height: 18),
                                            SizedBox(
                                              height: 55,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () async {
                                                  _image =
                                                      (await _picker.pickImage(
                                                          source: ImageSource
                                                              .camera))!;
                                                  imageFile = File(_image.path);

                                                  Navigator.pop(context);
                                                  chekValidation();

                                                  setState(() {});
                                                },
                                                child: const Text('Камера'),
                                              ),
                                            ),
                                            const SizedBox(height: 15),
                                            SizedBox(
                                              height: 55,
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                child: const Text('Галерея'),
                                                onPressed: () async {
                                                  _image =
                                                      (await _picker.pickImage(
                                                          source: ImageSource
                                                              .gallery))!;

                                                  if (imageFile != null) {
                                                    imageFile =
                                                        File(_image.path);
                                                    Navigator.pop(context);

                                                    chekValidation();
                                                    setState(() {});
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  });
                            },
                          ),
                          const SizedBox(width: 20),
                          if (imageFile != null)
                            Container(
                              height: 55,
                              width: 55,
                              decoration: BoxDecoration(
                                  color: Colors.amber,
                                  borderRadius: BorderRadius.circular(10),
                                  image: DecorationImage(
                                    fit: BoxFit.cover,
                                    image: FileImage(imageFile!),
                                  )),
                            )
                        ],
                      ),
                    ),
                  ),
                  child!,
                  Row(
                    children: [
                      Switch.adaptive(
                        value: isCamera.value,
                        onChanged: (value) {
                          isCamera.value = !isCamera.value;
                        },
                      ),
                      const SizedBox(width: 30),
                      const Text('Загрузить фото')
                    ],
                  ),
                ],
              );
            }),
        SizedBox(
          height: 45,
          child: BlocConsumer<CarBloc, CarStates>(
            listener: (context, state) {
              if (state is CarSuccessState) {
                Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return ValueListenableBuilder(
                  valueListenable: isFullFilled,
                  builder: (context, _, __) {
                    return AppButton(
                        isFullFilled: isFullFilled.value,
                        isLoading: state is CarLoadingState,
                        onPressed: () {
                          final car = CarModel(
                            urlImage: linkController.text,
                            localimage: imageFile,
                            price: double.parse(priceController.text),
                            brand: brandController.text,
                            model: modelController.text,
                            year: int.parse(
                              yearController.text,
                            ),
                          );
                          BlocProvider.of<CarBloc>(context).add(AddCar(car));
                        });
                  });
            },
          ),
        )
      ]),
    );
  }

  void chekValidation() {
    if ([
      yearController,
      linkController,
      priceController,
      brandController,
      modelController,
    ].every((e) => e.text.length >= 3)) {
      if (linkController.text.contains('http') || imageFile != null) {
        isFullFilled.value = true;
      } else {
        isFullFilled.value = false;
      }
    } else {
      isFullFilled.value = false;
    }
  }

  @override
  void dispose() {
    modelController.dispose();
    brandController.dispose();
    priceController.dispose();
    yearController.dispose();
    linkController.dispose();
    isFullFilled.dispose();
    super.dispose();
  }
}
