// lib/components/drawer_component.dart

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../routes/app_pages.dart';

class DrawerComponent extends StatelessWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const DrawerComponent({Key? key, required this.scaffoldKey}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<String> menuItems = <String>[
      'Home',
      'Menu Makanan',
      'Paket Makanan',
      'Favorit',
    ];

    final List<String> menuRoutes = <String>[
      Routes.HOME,
      Routes.MENU,
      Routes.PAKET,
      Routes.FAVORITE
    ];

    final List<IconData> menuIcons = <IconData>[
      Icons.home,
      Icons.restaurant_menu,
      Icons.card_giftcard,
      Icons.favorite,
    ];

    return Drawer(
      backgroundColor: const Color(0xFFECD7D7),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Image.asset(
              'assets/images/logo.png',
              height: 100,
              width: 120,
            ),
          ),
          const Divider(),
          Expanded(
            child: ListView.builder(
              itemCount: menuItems.length,
              itemBuilder: (context, index) {
                bool isActive = Get.currentRoute == menuRoutes[index];

                return ListTile(
                  leading: Icon(
                    menuIcons[index],
                    color: isActive ? const Color(0xFFECD7D7) : Colors.black,
                  ),
                  onTap: () {
                    if (!isActive) {
                      scaffoldKey.currentState?.openEndDrawer();
                      Navigator.of(context).pop();
                      Navigator.pushReplacementNamed(context, menuRoutes[index]);
                    } else {
                      scaffoldKey.currentState?.openEndDrawer();
                      Navigator.of(context).pop();
                    }
                  },
                  title: Text(
                    menuItems[index],
                    style: TextStyle(
                      color: isActive ? const Color(0xFFECD7D7) : Colors.black,
                      fontWeight: isActive ? FontWeight.w900 : FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  tileColor: isActive ? const Color(0xFFFF3131) : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
