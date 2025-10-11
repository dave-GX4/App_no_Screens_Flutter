import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:no_screenshot/no_screenshot.dart';
import 'package:recordatorios_app/core/routes/app_router.dart';
import 'package:recordatorios_app/core/screensnot/screenshot_protection_mixin.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_buttom.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_iconbutton.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_linepainter.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_sizebox.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/custom_text.dart';
import 'package:recordatorios_app/feature/home/presentation/widgets/stant_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with ScreenshotProtectionMixin {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha(50),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),

              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomIconbutton(
                    icon: Icons.menu, 
                    onPressed: () {}, 
                    color: Colors.black, 
                    size: 30
                  ),

                  CustomSizebox(width: 80),

                  CustomIconbutton(
                    icon: Icons.notifications, 
                    onPressed: () {
                      context.push(RouterConstants.recordatorios);
                    }, 
                    color: Colors.black, 
                    size: 30
                  ),

                  CustomSizebox(width: 80),

                  CustomIconbutton(
                    icon: Icons.settings, 
                    onPressed: () {}, 
                    color: Colors.black, 
                    size: 30
                  ),
                ],
              ),
            ),

            CustomSizebox(height: 15),

            GridView.count(
              crossAxisCount: 2,
              mainAxisSpacing: 5,
              crossAxisSpacing: 5,
              childAspectRatio: 3,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                StatCard(
                  title: 'Programados',
                  count: '10',
                  icon: Icons.notifications_active,
                  iconBackgroundColor: Color.fromRGBO(132, 176, 241, 100),
                  iconColor: Colors.white,
                ),

                StatCard(
                  title: 'Desactivados',
                  count: '10',
                  icon: Icons.notifications_off,
                  iconBackgroundColor: Colors.grey,
                  iconColor: Colors.white,
                ),

                StatCard(
                  title: 'Recurrentes',
                  count: '10',
                  icon: Icons.alarm,
                  iconBackgroundColor: Color.fromRGBO(158, 61, 235, 100),
                  iconColor: Colors.white,
                ),

                StatCard(
                  title: 'No completados',
                  count: '42',
                  icon: Icons.heart_broken,
                  iconBackgroundColor: Colors.redAccent,
                  iconColor: Colors.white,
                ),
              ],
            ),
            
            CustomSizebox(height: 10),

            StatCard(
              title: 'Completados',
              count: '41',
              icon: Icons.check_circle,
              iconBackgroundColor: Color.fromRGBO(49, 239, 32, 100),
              iconColor: Colors.white,
            ),

            CustomSizebox(height: 20),
            
            Center(
              child: CustomText(
                text: 'Cumplimientos de tus recordatorios por día', 
                fontweight: FontWeight.bold, 
                size: 20,
                colors: Colors.black,
              ),
            ),

            CustomSizebox(height: 15),

            CustomButtom(
              text: 'Ver Recordatorios', 
              onPressed: () {}, 
              width: 200, 
              height: 50,
              color: Color.fromRGBO(183, 210, 250, 100),
              textColor: Colors.black,
              fontWeight: FontWeight.bold,
            ),

            CustomSizebox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                
                CustomText(
                  text: 'Recordatorios por grupos',  
                  fontweight: FontWeight.bold, 
                  size: 24,
                  colors: Colors.black,
                ),

                CustomSizebox(width: 60),

                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(223, 153, 16, 100),
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.category_sharp, color: Colors.white, size: 28),
                ),
              ],
            ),

            CustomSizebox(height: 2),

            CustomPaint(
              size: Size(300, 0),
              painter: CustomLinePainter(),
            ),
          ]
        ),
      ) 
    );
  }
}