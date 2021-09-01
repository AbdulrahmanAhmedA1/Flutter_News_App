import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_news/models/dio.dart';
import 'package:flutter_application_news/screens/business_screen.dart';
import 'package:flutter_application_news/screens/science_screen.dart';
import 'package:flutter_application_news/screens/sports_screen.dart';

import 'state.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(AppInitialState());
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
  ];
  int currentIndex = 0;
  changeCurrentIndex(int index) {
    currentIndex = index;
    emit(AppChangeCurrentIndexState());
  }

  List screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];
  // ThemeMode themeMode = ThemeMode.light;
  bool isDark = false;
  changeAppThemeMode() {
    isDark = !isDark;
    emit(AppChangeModeState());
  }

  List<dynamic> business = [];

  void getBusiness() {
    emit(AppGetBusinessDataLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'bc2b74f7bbed48a8925a87234c2581af',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      business = value.data['articles'];
      print(business[0]['title']);

      emit(AppGetBusinessDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetBusinessDataErrorState());
    });
  }

  List<dynamic> sports = [];

  void getSports() {
    emit(AppGetSportsDataLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'bc2b74f7bbed48a8925a87234c2581af',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      sports = value.data['articles'];
      print(sports[0]['title']);

      emit(AppGetSportsDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetSportsDataErrorState());
    });
  }

  List<dynamic> science = [];

  void getScience() {
    emit(AppGetScienceDataLoadingState());

    DioHelper.getData(
      url: 'v2/top-headlines',
      queryParameters: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'bc2b74f7bbed48a8925a87234c2581af',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      science = value.data['articles'];
      print(science[0]['title']);

      emit(AppGetScienceDataState());
    }).catchError((error) {
      print(error.toString());
      emit(AppGetScienceDataErrorState());
    });
  }

  List<dynamic> search = [];

  void getSearch(String value) {
    emit(AppGetSearchDataLoadingState());

    DioHelper.getData(
      url: 'v2/everything',
      queryParameters: {
        'q': '$value',
        'apiKey': 'bc2b74f7bbed48a8925a87234c2581af',
      },
    ).then((value) {
      //print(value.data['articles'][0]['title']);
      search = value.data['articles'];
      print(search[0]['title']);

      emit(AppGetSearchDataState());
    }).catchError((error) {
      print('error ${error.toString()}');
      emit(AppGetSearchDataErrorState());
    });
  }
}
