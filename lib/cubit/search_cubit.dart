import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/models/search_response.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}

class SearchLoadingState extends SearchStates {}

class SearchSuccessState extends SearchStates {
  SearchResponse searchResponse;

  SearchSuccessState(this.searchResponse);
}

class SearchErrorState extends SearchStates {
  final String error;

  SearchErrorState(this.error);
}

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);
  String token = MyShared.getData('token');


  // SearchResponse? searchResponse;
  // List<SearchData> searchResponseList = [];
  // Future<List<SearchResponse>> search(String text) async {
  //   emit(SearchLoadingState());
  //   var response = await DioHelper.postData(
  //     endpoint: SEARCH,
  //     body: {
  //       'text': text,
  //     },
  //     token: token,
  //   );
  //   var searchList = response.data;
  //   searchResponseList = searchList;
  //   emit(SearchSuccessState(searchResponse!));
  //   return searchList;
  //
  // }


SearchResponse searchResponse = SearchResponse(status: false,);
void search(String text) {

  emit(SearchLoadingState());
  DioHelper.postData(
    endpoint: SEARCH,
    body: {
      'text':text,
    },
    token: token,
  ).then((value){
    searchResponse =SearchResponse.fromJson(value.data);
    print(value.data);
    emit(SearchSuccessState(searchResponse));
  }).catchError((error){
    print(error);
    emit(SearchErrorState(error.toString()));
  });
}
}
