import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/Features/AI/presentation/cubit/predict_price_cubit.dart';
import 'package:realestate/Features/Auth/presentation/widgets/custom_button.dart';
import 'package:realestate/core/utils/app_constant.dart';
import 'package:realestate/core/utils/spacing.dart';
import 'package:realestate/core/widgets/circle_progress_widget.dart';
import 'package:realestate/core/widgets/normal_textfomfield.dart';

class AIFormScreem extends StatefulWidget {
  const AIFormScreem({super.key});

  @override
  State<AIFormScreem> createState() => _AIFormScreemState();
}

class _AIFormScreemState extends State<AIFormScreem> {
  String? selectedType;
  var areaController = TextEditingController();
  var badroomsController = TextEditingController();
  var bathroomsController = TextEditingController();
  var levelController = TextEditingController();
  String? _selectedCity;
  String? _selectedRegion;
  String? _selectedFurnished;
  String? _selectedRent;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        //backgroundColor: Colors.transparent,
        title: const Text('AI To Predict Price 🤖'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: SingleChildScrollView(
            child: BlocProvider(
          create: (context) => PredictPriceCubit(),
          child: BlocConsumer<PredictPriceCubit, PredictPriceState>(
              builder: (context, state) {
            return Column(
              children: [
                Form(
                    child: Column(
                  children: [
                     Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Chose Type',
                          style: TextStyle(fontSize: 18.sp),
                        )),
                    Align(
                      alignment: Alignment.topLeft,
                      child: DropdownButton(
                        value: selectedType,
                        items: types["property_types"]!.map((String type) {
                          return DropdownMenuItem<String>(
                            value: type,
                            child: Text(type),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          setState(() {
                            selectedType = newValue;
                          });
                          debugPrint(selectedType);
                        },
                        hint: const Text("Selected a Type"),
                      ),
                    ),
                    AppTextFormField(
                      controller: areaController,
                      hintText: "Enter Area",
                      type: TextInputType.number,
                      prefixIcon: Icon(Icons.area_chart),
                      validator: (String? value) {},
                    ),
                    verticalSpace(10),
                    AppTextFormField(
                      prefixIcon: Icon(Icons.bed),
                      controller: badroomsController,
                      hintText: "Enter Number of Badrooms",
                      type: TextInputType.number,
                      validator: (String? value) {},
                    ),
                    verticalSpace(10),
                    AppTextFormField(
                      controller: bathroomsController,
                      prefixIcon: Icon(Icons.bathroom),
                      hintText: "Enter Number of Bathrooms",
                      type: TextInputType.number,
                      validator: (String? value) {},
                    ),
                    verticalSpace(20),
                    AppTextFormField(
                      controller: levelController,
                      prefixIcon: Icon(Icons.star),
                      hintText: "Enter Number of Levels ",
                      type: TextInputType.number,
                      validator: (String? value) {},
                    ),
                    verticalSpace(10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Chose City and Regioon',
                          style: TextStyle(fontSize: 18.sp),
                        )),
                    verticalSpace(10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        DropdownButton<String>(
                          value: _selectedCity,
                          hint: Text('Select City'),
                          onChanged: (String? value) {
                            setState(() {
                              _selectedCity = value;
                              _selectedRegion = null; // Reset selected region
                            });
                          },
                          items: cities.keys.map((String city) {
                            return DropdownMenuItem<String>(
                              value: city,
                              child: Text(city),
                            );
                          }).toList(),
                        ),
                        SizedBox(width: 10.h),
                        Flexible(
                          child: DropdownButton<String>(
                            isExpanded: true,
                            value: _selectedRegion,
                            hint: Text('Select Region'),
                            onChanged: (String? value) {
                              setState(() {
                                _selectedRegion = value;
                              });
                            },
                            items: _selectedCity != null
                                ? cities[_selectedCity]!.map((String region) {
                                    return DropdownMenuItem<String>(
                                      value: region,
                                      child: Text(region),
                                    );
                                  }).toList()
                                : [],
                          ),
                        ),
                      ],
                    ),
                    
                    verticalSpace(10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Furnished",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    Row(
                      children: [
                        Text('Yes'),
                        Radio(
                          value: 'yes',
                          groupValue: _selectedFurnished,
                          onChanged: (value) {
                            setState(() {
                              _selectedFurnished = value;
                              log(_selectedFurnished.toString());
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Text('No'),
                        Radio(
                          value: 'no',
                          groupValue: _selectedFurnished,
                          onChanged: (value) {
                            setState(() {
                              _selectedFurnished = value;
                            });
                          },
                        ),
                      ],
                    ),
                    verticalSpace(10),
                    Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Rent",
                          style: TextStyle(
                            fontSize: 18.sp,
                          ),
                          textAlign: TextAlign.start,
                        )),
                    Row(
                      children: [
                        Text('Yes'),
                        Radio(
                          value: 'yes',
                          groupValue: _selectedRent,
                          onChanged: (value) {
                            setState(() {
                              _selectedRent = value;
                              log(_selectedFurnished.toString());
                            });
                          },
                        ),
                        SizedBox(width: 20),
                        Text('No'),
                        Radio(
                          value: 'no',
                          groupValue: _selectedRent,
                          onChanged: (value) {
                            setState(() {
                              _selectedRent = value;
                              log(_selectedRent.toString());
                            });
                          },
                        ),
                      ],
                    ),
                    verticalSpace(10),
              state is PredictedIsLoading? const CireProgressIndecatorWidget():      CustomButton(
                        onPressed: () {
                          log(selectedType.toString());
                          log(_selectedFurnished.toString());
                          log("select rent" + _selectedRent.toString());
                          log(_selectedCity.toString() +
                              _selectedRegion.toString());
                          log(badroomsController.text.toString());
                          log(bathroomsController.text.toString());
                          log(levelController.text.toString());
                          BlocProvider.of<PredictPriceCubit>(context)
                              .predictPrice(
                            selectedType!,
                            _selectedFurnished,
                            _selectedRent,
                            _selectedCity,
                            _selectedRegion,
                            int.parse(areaController.text),
                            // areaController.text as int,
                            int.parse(badroomsController.text),
                            //badroomsController.text as int,
                            int.parse(bathroomsController.text),
                            // bathroomsController.text as int,
                            //levelController.text as int
                            int.parse(levelController.text),
                          );
                        },
                        text: "Predict")
                  ],
                ))
              ],
            );
          }, listener: (context, state) {
            if (state is PredictedSuccesState) {
              BlocProvider.of<PredictPriceCubit>(context)
                  .showCustomDialog(context, state, () {
                Navigator.pop(context);
              });
            } else if (state is PredictedErrorState) {
              log(state.error.toString());
            }
          }),
        )),
      ),
    );
  }
}
