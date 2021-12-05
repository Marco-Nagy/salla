import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/Components.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/models/category_response.dart';
import 'package:salla_shop_app/models/home_response.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getHomeData();
    ShopCubit.get(context).getCategoriesData();

    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if(state is ShopSuccessChangeFavoritesState){
          if(!state.favoriteChangeResponse.status!){
            showToast(message: 'Error ==>> '+state.favoriteChangeResponse.message.toString());
          }else{
            showToast(message: state.favoriteChangeResponse.message.toString());

          }
        }
      },
      builder: (context, state) {
        return ConditionalBuilder(
          condition: ShopCubit.get(context).homeResponse != null && ShopCubit.get(context).categoriesResponse!=null,
          builder: (context) => productsBuilder(ShopCubit.get(context).homeResponse!,ShopCubit.get(context).categoriesResponse!,context),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget productsBuilder(HomeResponse homeResponse,CategoryResponse categoriesResponse,context) =>
      SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              items: homeResponse.data!.banners!
                  .map(
                    (e) =>
                    Image(
                      image: NetworkImage('${e.image}'),
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
              )
                  .toList(),
              options: CarouselOptions(
                height: 250,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1.0,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade400,
              height: 150,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) =>
                    buildCategoriesItem(categoriesResponse.data!.data![index]),
                itemCount:categoriesResponse.data!.data!.length,
                separatorBuilder: (BuildContext context, int index) =>SizedBox(width: 5,),),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Text(
                "New Products",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
            Container(
              color: Colors.grey.shade400,
              child: GridView.count(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
                childAspectRatio: 1 / 1.8,
                children: List.generate(
                    homeResponse.data!.products!.length,
                        (index) =>
                        buildGridProduct(homeResponse.data!.products![index],context)),
              ),
            ),
          ],
        ),
      );

  Widget buildGridProduct(Products products,context) =>
      Container(
        color: Colors.white,
        margin: EdgeInsets.all(3),
        padding: EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: AlignmentDirectional.bottomStart,
              children: [
                Image(
                  image: NetworkImage(
                    products.image!,
                  ),
                  width: double.infinity,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                if (products.discount != 0)
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
            Text(
              products.name!,
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
                  '${products.price!.round()}',
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
                if (products.discount != 0)
                  Text(
                    '${products.oldPrice!.round()}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                      decoration: TextDecoration.lineThrough,
                    ),
                    textAlign: TextAlign.center,
                  ),
                Spacer(),
                IconButton(
                    onPressed: () {
                      ShopCubit.get(context).changeFavorites(products.id!);
                    },
                    icon: CircleAvatar(
                      backgroundColor: ShopCubit.get(context).favorites![products.id!]! ? Colors.blue : Colors.grey,
                      radius: 18,
                      child: Icon(
                        Icons.favorite,
                        color: Colors.white,
                        size: 15 ,
                      ),
                    ))
              ],
            ),
          ],
        ),
      );

  Widget buildCategoriesItem(Category categoryItem) =>
      Stack(
        alignment: AlignmentDirectional.bottomStart,
        children: [
          Image(
            image: NetworkImage(categoryItem.image!,
            ),
            width: 150,
            height: 150,
            fit: BoxFit.fill,
          ),
            Container(
              width: 150,
              padding: EdgeInsets.symmetric(horizontal: 5),
              color: Colors.black,
              child: Text(categoryItem.name!,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
        ],
      );
}
