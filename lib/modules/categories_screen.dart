import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/models/category_response.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) => buildCategoriesItem(ShopCubit.get(context).categoriesResponse!.data!.data![index]),
          separatorBuilder: (context, index) => SizedBox(height: 5,),
          itemCount: ShopCubit.get(context).categoriesResponse!.data!.data!.length,
        );
      },
    );
  }

  Widget buildCategoriesItem(Category categoryItem) => Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
          children: [
            Image(
              image: NetworkImage(
                categoryItem.image!,
              ),
              width: 100,
              height: 100,
              fit: BoxFit.fill,
            ),
            SizedBox(width: 10,),
            Text(categoryItem.name!,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
            ),
            Spacer(),
            Icon(Icons.arrow_forward_ios)
          ],
        ),
  );
}
