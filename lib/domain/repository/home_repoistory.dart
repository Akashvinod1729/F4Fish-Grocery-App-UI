import 'package:grocery_app/domain/entity/home_entity.dart';

import '../../data/remote/model/region_model.dart';

abstract class HomeRepository {
  Future<HomeEntity> getHome(int region);
  Future<List<RegionModel>> getAllLocations();
  Future<RegionModel> getNearestLocation(String lat, String long);
}
