import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:salla_shop_app/cubit/shop_cubit.dart';
import 'package:salla_shop_app/models/favorite_get_response.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShopCubit.get(context).getFavorites();
    var cubit = ShopCubit.get(context).favoritesGetResponse!.data!.data!;
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return ConditionalBuilder(
          condition: state is! ShopLoadingGetFavoritesState,
          builder: (context) => ListView.separated(
            itemBuilder: (context, index) =>
                buildFavoriteProduct(cubit[index], context),
            separatorBuilder: (context, index) => Divider(
              color: Colors.white,
              thickness: 0.3,
              height: 5,
            ),
            itemCount:
                ShopCubit.get(context).favoritesGetResponse!.data!.data!.length,
          ),
          fallback: (context) => Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  Widget buildFavoriteProduct(FavoriteData favoriteData, context) => Padding(
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
                        favoriteData.product!.image!,
                      ),
                      width: 120,
                      height: 120,
                      fit: BoxFit.fill,
                    ),
                    if (favoriteData.product!.id != 0)
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
                      favoriteData.product!.name!,
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
                          favoriteData.product!.price.toString(),
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
                        if (favoriteData.product!.discount! != 0)
                          Text(
                            favoriteData.product!.oldPrice!.toString(),
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
                              ShopCubit.get(context)
                                  .changeFavorites(favoriteData.product!.id!);
                            },
                            icon: CircleAvatar(
                              backgroundColor: ShopCubit.get(context)
                                      .favorites![favoriteData.product!.id]!
                                  ? Colors.blue
                                  : Colors.grey,
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
