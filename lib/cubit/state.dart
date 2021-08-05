abstract class NewsStates {}

class AppInitialState extends NewsStates {}

class AppChangeCurrentIndexState extends NewsStates {}

class AppGetBusinessDataLoadingState extends NewsStates {}

class AppGetBusinessDataState extends NewsStates {}

class AppGetBusinessDataErrorState extends NewsStates {}

class AppGetSportsDataLoadingState extends NewsStates {}

class AppGetSportsDataState extends NewsStates {}

class AppGetSportsDataErrorState extends NewsStates {}

class AppGetScienceDataLoadingState extends NewsStates {}

class AppGetScienceDataState extends NewsStates {}

class AppGetScienceDataErrorState extends NewsStates {}

class AppGetSearchDataLoadingState extends NewsStates {}

class AppGetSearchDataState extends NewsStates {}

class AppGetSearchDataErrorState extends NewsStates {}

class AppChangeModeState extends NewsStates {}
