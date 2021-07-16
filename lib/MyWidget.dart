import 'package:flutter/material.dart';

class MyWidget extends StatefulWidget {
  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {

  int _dropDownvalue = 1;

  var jsonData = {"bus_schedule": {
    "Night Shift": [
      {
        "schedule_trip": "Return",
        "start_time": "06.30 am",
        "end_time": "07.59 am"
      },
      {
        "schedule_trip": "Departure",
        "start_time": "06.30 pm",
        "end_time": "07.00 pm"
      }
    ],
    "Night Overtime": [
      {
        "schedule_trip": "Return",
        "start_time": "08.00 am",
        "end_time": "08.30 am"
      }
    ],
    "Morning Shift": [
      {
        "schedule_trip": "Departure",
        "start_time": "05.30 am",
        "end_time": "06.00 am"
      },
      {
        "schedule_trip": "Return",
        "start_time": "06.30 pm",
        "end_time": "07.59 pm"
      }
    ],
    "Morning Overtime": [
      {
        "schedule_trip": "Return",
        "start_time": "08.00 pm",
        "end_time": "08.30 pm"
      }
    ]
  },};

  List<DropdownMenuItem> dropdownItemList = [];

  @override
  Widget build(BuildContext context) {

    Map<String, List<Map<String, String>>>? timeSlot =  jsonData["bus_schedule"];

    dropdownItemList.clear();

    int count = 0;
    timeSlot!.forEach((key, value) {
      dropdownItemList.add(dropDownWidget(count,"","","",key));
      count++;
    });

    return dropDownButton();
  }

  Widget dropDownButton() {
    return Scaffold(
      body: Center(
        child: Container(
            child: DropdownButton(
                value: _dropDownvalue,
                items: [
                  DropdownMenuItem(child: Text("First Item"), value: 1,),
                  DropdownMenuItem(child: Text("Second Item"),value: 2,),
                  DropdownMenuItem(child: Text("Third Item"), value: 3),
                  DropdownMenuItem(child: Text("Fourth Item"), value: 4),
                ],
                onChanged: (int? value) {
                  setState(() {
                    _dropDownvalue = value!;
                  });
                })),
      ),
    );
  }

  dropDownWidget(int value, String startTime,String endTime,String status, String shift){
    return DropdownMenuItem(
      child: Column(
        children: [
          Text("[{$startTime}] to [{$endTime}]"),
          Text("[{$status}] ({$shift})" ),
        ],
      ),
      value: value,
    );
  }
}

