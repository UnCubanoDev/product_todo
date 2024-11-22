import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flashy_tab_bar2/flashy_tab_bar2.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:product_todo/di.dart';
import 'package:product_todo/features/product/presentation/bloc/revised_product_bloc/revised_product_bloc.dart';
import 'package:product_todo/features/product/presentation/bloc/search_product_bloc/search_product_bloc.dart';
import 'package:product_todo/features/product/presentation/screens/product_earring_screen.dart';
import 'package:product_todo/features/product/presentation/screens/product_revised_screen.dart';

void main() async {
  await init();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    List<Widget> tabItems = [
      const ProductEarringScreen(),
      const ProductRevisedScreen()
    ];

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => GetIt.instance.get<SearchProductBloc>()),
        BlocProvider(create: (_) => GetIt.instance.get<RevisedProductBloc>()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.blue,
          ),
        ),
        home: Scaffold(
          body: Center(
            child: tabItems[selectedIndex],
          ),
          bottomNavigationBar: FlashyTabBar(
            animationCurve: Curves.linear,
            animationDuration: const Duration(milliseconds: 500),
            iconSize: 30,
            showElevation: true,
            selectedIndex: selectedIndex,
            onItemSelected: (index) => setState(() {
              selectedIndex = index;
              log(selectedIndex.toString());
            }),
            items: [
              FlashyTabBarItem(
                icon: const Icon(Icons.pending_actions),
                title: const Text('Por Revisar'),
              ),
              FlashyTabBarItem(
                icon: const Icon(Icons.checklist),
                title: const Text('Revisados'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
