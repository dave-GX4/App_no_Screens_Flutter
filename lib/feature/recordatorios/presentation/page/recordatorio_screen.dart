import 'package:flutter/material.dart';
import 'package:recordatorios_app/core/screensnot/screenshot_protection_mixin.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/widgets/custom_card.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/widgets/custom_buttomicon.dart';
import 'package:recordatorios_app/feature/recordatorios/presentation/widgets/custom_sizebox.dart';

class RecordatorioScreen extends StatefulWidget{
  const RecordatorioScreen({super.key});

  @override
  State<RecordatorioScreen> createState() => _RecordatorioScreenState();
}

class _RecordatorioScreenState extends State<RecordatorioScreen> with ScreenshotProtectionMixin {

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: Text('Administrador de Recordatorios')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                CustomButtomIcon(
                  text: "Agregar",
                  onPressed: () {}, 
                  width: 50, 
                  height: 40, 
                  icon: Icons.add,
                  color: Color.fromRGBO(132, 176, 241, 100)
                ),

                CustomSizebox(width: 80),

                CustomButtomIcon(
                  text: "Multiple", 
                  onPressed: () {}, 
                  width: 50,
                  height: 40, 
                  icon: Icons.delete,
                  color: Colors.red,
                )
              ]
            ),

            CustomSizebox(height: 10),

            GridView.count(
              crossAxisCount: 1,
              childAspectRatio: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                CustomCard(
                  onChanged: (String? value) {},
                  onChangedSwitch: (bool value) {},
                  onPressedOne: () {},
                  onPressedTwo: () {},
                )
              ],
            )
          ]
        ),
      ) 
    );
  }
}