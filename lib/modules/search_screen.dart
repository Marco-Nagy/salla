import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/search_cubit.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/models/search_response.dart';
import '../Components.dart';

class SearchScreen extends StatelessWidget {
   SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();
  var formKye =GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {

    return  BlocProvider(
      create: (BuildContext context) =>SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state) {
          if (state is SearchSuccessState) {
            if (state.searchResponse.status == true) {
              print(state.searchResponse.status);
              //print(state.searchResponse.data!.data);
              showToast(message: state.searchResponse.status.toString());
            } else {
              //print(state.searchResponse.status);
              showToast(message: state.searchResponse.status.toString());
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              child: Column(
                key: formKye,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: defaultTextField(
                      controller: searchController,
                      type: TextInputType.text,
                      validator: (value) {
                        if (value.isEmpty) {
                          return "Search must not be Empty";
                        }
                        return null;
                      },
                      onChange: (value) {
                        print(value);
                        SearchCubit.get(context).search(value);
                      },
                      label: 'Search',
                      prefixIcon: Icons.search,
                      inputAction: TextInputAction.search,
                    ),
                  ),
                  Divider(
                    color: Colors.white,
                    thickness: 0.5,
                    height: 10,
                  ),
                  if (state is SearchLoadingState)
                    LinearProgressIndicator(),
                  if (state is SearchSuccessState && SearchCubit.get(context).searchResponse != null)

                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>
                            buildSearchProduct(SearchCubit.get(context).searchResponse.data!.data[index], context),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).searchResponse.data!.data.length,
                      ),
                    ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget buildSearchProduct(SearchData searchData, context) => Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          height: 150,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 120,
                width: 120,
                child: Stack(
                  alignment: AlignmentDirectional.bottomStart,
                  children: [
                    Image(
                      image: NetworkImage(
                        searchData.image,
                      ),
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                    if (searchData.id != 0)
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 5),
                        color: Colors.red,
                        child: Text(
                          'Discount',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 10,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Expanded(
                child: Column(
                  children: [
                    Text(
                      searchData.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                      textAlign: TextAlign.start,
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          searchData.price.toString(),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.blue,
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            height: 1.3,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        // if (productData.d! != 0)
                        //   Text(
                        //     favoriteData.product!.oldPrice!.toString(),
                        //     maxLines: 2,
                        //     overflow: TextOverflow.ellipsis,
                        //     style: TextStyle(
                        //       color: Colors.grey,
                        //       fontSize: 14,
                        //       fontWeight: FontWeight.w600,
                        //       height: 1.3,
                        //       decoration: TextDecoration.lineThrough,
                        //     ),
                        //     textAlign: TextAlign.center,
                        //   ),
                        Spacer(),
                        IconButton(
                            onPressed: () {
                              ShopCubit.get(context)
                                  .changeFavorites(searchData.id);
                            },
                            icon: CircleAvatar(
                              // backgroundColor: ShopCubit.get(context)
                              //         .favorites![searchData.id]!
                              //     ? Colors.blue
                              //     : Colors.grey,
                              radius: 18,
                              child: Icon(
                                Icons.favorite,
                                color: Colors.white,
                                size: 15,
                              ),
                            ))
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}
