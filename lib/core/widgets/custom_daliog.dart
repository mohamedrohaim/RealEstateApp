import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:realestate/core/network/cach_helper.dart';
import 'package:realestate/core/utils/app_constant.dart';
import 'package:realestate/core/utils/spacing.dart';

class CustomAlertDialog extends StatelessWidget {
  const CustomAlertDialog(
      {super.key, required this.onPresed, required this.alretTitle});
  final VoidCallback onPresed;
  final String alretTitle;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Note That'),
      content: Text(
        alretTitle,
        style: TextStyle(fontSize: 14.sp),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: onPresed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}

class CustomFilterDialog extends StatefulWidget {
  const CustomFilterDialog({
    super.key,
    required this.onPresed,
    required this.alretTitle,
    // required this.sliderWidget
  });
  final VoidCallback onPresed;
  final String alretTitle;

  @override
  State<CustomFilterDialog> createState() => _CustomFilterDialogState();
}

class _CustomFilterDialogState extends State<CustomFilterDialog> {
  // final Widget sliderWidget;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  bool _selectedLocation = false;
  bool _rangeSelected = false;
  bool _selectedTitle = false;
  var startprice = TextEditingController();
  var endPrice = TextEditingController();
  String? _selectedCity;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Filter Search'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   alretTitle,
          //   style: TextStyle(fontSize: 14.sp),
          // ),
          CheckboxListTile(
            value: CacheHelper.getData(key: 'range_selected') ?? _rangeSelected,
            onChanged: (value) {
              setState(() {
                _rangeSelected = value!;
              });
              CacheHelper.saveData(
                  key: 'range_selected', value: _rangeSelected);
              CacheHelper.removeData(key: 'location');
              // CacheHelper.removeData(key: 'title');
            },
            title: const Text('range price'),
          ),
          verticalSpace(10),
          Row(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // initialValue: _currentRangeValues.start.round().toString(),
                    controller: startprice,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'Start Price',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      CacheHelper.saveData(
                          key: 'start_price', value: startprice.text);

                      // Handle onChanged event
                      // For example, update _currentRangeValues.start
                    },
                    onTap: () {
                      CacheHelper.saveData(
                          key: 'start_price', value: startprice.text);
                    },
                  ),
                ),
              ),
              const SizedBox(
                  width: 8.0), // Add some space between the text fields
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    // initialValue: _currentRangeValues.end.round().toString(),
                    controller: endPrice,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: 'End Price',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      CacheHelper.saveData(
                          key: 'end_price', value: endPrice.text);
                    },

                    onTap: () {
                      CacheHelper.saveData(
                          key: 'end_price', value: endPrice.text);
                    },
                  ),
                ),
              ),
            ],
          ),
          CheckboxListTile(
            value: CacheHelper.getData(key: 'location') ?? _selectedLocation,
            onChanged: (value) {
              setState(() {
                _selectedLocation = value!;
              });
              CacheHelper.saveData(key: 'location', value: _selectedLocation);
              CacheHelper.removeData(key: 'range_selected');
              // CacheHelper.removeData(key: 'title');
            },
            title: const Text('Location'),
          ),
          verticalSpace(10),
          //location selection
          DropdownButton<String>(
            value: CacheHelper.getData(key: 'location') == null
                ? _selectedCity
                : CacheHelper.getData(key: 'city'),
            hint: const Text('Select City'),
            onTap: () {
              //   CacheHelper.saveData(key: 'city', value: _selectedCity);
            },
            onChanged: (String? value) {
              CacheHelper.saveData(key: 'city', value: value);
              setState(() {
                _selectedCity = value;
                //  _selectedRegion = null; // Reset selected region
              });
            },
            items: CacheHelper.getData(key: 'location') != null
                ? cities.keys.map((String city) {
                    return DropdownMenuItem<String>(
                      value: city,
                      child: Text(city),
                    );
                  }).toList()
                : [],
          ),

          // sliderWidget,
        ],
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          onPressed: widget.onPresed,
          child: const Text('OK'),
        ),
      ],
    );
  }
}
