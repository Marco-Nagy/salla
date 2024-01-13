import 'package:flutter/cupertino.dart';
import 'package:salla_shop_app/ModulesAndFeatures/Home/domain/repositories/home_repository.dart';

class GetBannersList{
  BaseHomeRepository baseHomeRepository;

  GetBannersList(this.baseHomeRepository);
  Future<List<Banner>> execute() async {
    return await baseHomeRepository.getBannersList();
  }
}