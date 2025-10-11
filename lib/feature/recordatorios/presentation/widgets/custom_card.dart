import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final String name = "Recordatorio 1";
  final String group = "Sin grupo";
  final String repetir = "Lun.";

  final bool value = false;
  final List<DropdownMenuItem<String>> items = const [
    DropdownMenuItem(value: "Opcion 1", child: Text("Opcion 1")),
    DropdownMenuItem(value: "Opcion 2", child: Text("Opcion 2")),
    DropdownMenuItem(value: "Opcion 3", child: Text("Opcion 3")),
  ];
  final void Function(String?)? onChanged;
  final void Function(bool)? onChangedSwitch;
  final void Function()? onPressedOne;
  final void Function()? onPressedTwo;

  const CustomCard({
    super.key, 
    this.onChanged, 
    this.onChangedSwitch, 
    this.onPressedOne, 
    this.onPressedTwo
    });

  @override
  Widget build(BuildContext context){
    return Card(
      color: Colors.blueGrey,
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                name, 
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold, 
                  fontSize: 16
                )
              ),
              Text(
                group, 
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                )
              ),
              Row(
                children: [
                  IconButton(
                    onPressed: onPressedOne,
                    iconSize: 24,
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    )
                  ),
                  IconButton(
                    onPressed: onPressedTwo,
                    iconSize: 24,
                    icon: Icon(Icons.delete),
                    color: Colors.white,
                  )
                ],
              )
            ]
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            
            children:[
              /*DropdownMenu(
                initialSelection: items.first, 
                onSelected:
              ),*/
              Text(
                repetir,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
              Switch(
                value: value, 
                onChanged: onChangedSwitch
              ),
            ]
          ),
        ],
      ),
    );
  }
}