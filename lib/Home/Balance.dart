import 'package:app_movil/Cuentas/Cuentas.dart';
import 'package:app_movil/Inventario/Inventario.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Balance> {

  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final views = [ Inventario(), Cuentas()];

    return Scaffold(
      body:IndexedStack(
        index: selectedIndex,
        children: views,
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting,
        currentIndex: selectedIndex,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        unselectedItemColor: Colors.black54,
        items: [
          BottomNavigationBarItem(
            icon: const Icon(Icons.inventory_2),
            activeIcon: const Icon(Icons.inventory_2_outlined),
            label:'Inventario',
            backgroundColor: colors.primary,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.list_alt),
            activeIcon: const Icon(Icons.list_alt_outlined),
            label:'Cuentas',
            backgroundColor: colors.primary,

          ),
        ],
      ),
    );
  }
}