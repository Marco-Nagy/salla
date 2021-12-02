import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../Components.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);
  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
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
              label: 'Search',
              prefixIcon: Icons.search,
              inputAction: TextInputAction.search,
            ),
          ),
          // Expanded(
          //     child: Visibility(
          //       visible: NewsCubit.get(context).isNewsVisible,
          //       child: myNewsListView(
          //   NewsCubit.get(context).searchNewsList,
          // ),
          //     ))
        ],
      ),
    );
  }
}
