import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/data/dio_helper.dart';
import 'package:salla_shop_app/data/end_points.dart';
import 'package:salla_shop_app/data/my_shared.dart';
import 'package:salla_shop_app/models/search_response.dart';

abstract class SearchStates {}

class SearchInitialState extends SearchStates {}




class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

}
