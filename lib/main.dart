import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_news/bloc_observer.dart';
import 'package:flutter_application_news/cubit/cubit.dart';
import 'package:flutter_application_news/cubit/state.dart';
import 'package:flutter_application_news/models/dio.dart';
import 'package:flutter_application_news/screens/search_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import 'const.dart';

void main() {
  // للتأكد من تنفيذ ما بداخل الفانكشن
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<NewsCubit>(
      create: (context) {
        return NewsCubit()
          ..getBusiness()
          ..getScience()
          ..getSports();
      },
      child: BlocConsumer<NewsCubit, NewsStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return MaterialApp(
              themeMode: BlocProvider.of<NewsCubit>(context).isDark
                  ? ThemeMode.dark
                  : ThemeMode.light,
              theme: lightTheme(),
              darkTheme: darkTheme(),
              home: Home(),
              debugShowCheckedModeBanner: false,
            );
          }),
    );
  }

  ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: HexColor('333739'),
      appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: HexColor('333739'),
          statusBarIconBrightness: Brightness.light,
        ),
        backgroundColor: HexColor('333739'),
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.white,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: HexColor('333739'),
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),
    );
  }

  ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.deepOrange,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: AppBarTheme(
        titleSpacing: 20.0,
        backwardsCompatibility: false,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.white,
        elevation: 0.0,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
        ),
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: Colors.deepOrange,
      ),
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepOrange,
        unselectedItemColor: Colors.grey,
        elevation: 20.0,
        backgroundColor: Colors.white,
      ),
      textTheme: TextTheme(
        bodyText1: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
    );
  }
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = BlocProvider.of<NewsCubit>(context);
        return Scaffold(
          appBar: AppBar(
            // automaticallyImplyLeading: false,
            title: appTitle,
            actions: [
              searchIcon(context),
              themeModeIcon(cubit),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
          bottomNavigationBar: bottomNavBar(cubit),
        );
      },
    );
  }

  BottomNavigationBar bottomNavBar(NewsCubit cubit) {
    return BottomNavigationBar(
      selectedFontSize: 20,
      onTap: (index) => cubit.changeCurrentIndex(index),
      currentIndex: cubit.currentIndex,
      items: cubit.bottomItems,
    );
  }

  IconButton searchIcon(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.search),
        onPressed: () {
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => SearchScreen()));
        });
  }
}
