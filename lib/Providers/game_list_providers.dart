import 'package:flutter/cupertino.dart';
import 'package:game/API/api_manager.dart';
import 'package:game/Helper/constant.dart';
import 'package:game/Model/game_list_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:connectivity/connectivity.dart';
import 'package:get_storage/get_storage.dart';

class GameListProviders with ChangeNotifier {
  var _gameList = <SubCategory>[];
  List<SubCategory> get gameList => _gameList;

  gameListApi() async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      var response = await APIManager().getAPICall(apiBaseUrl +
          "AdvertiseNewApplications/17/com.latest.status.message.text.jokes.funny");
      var gameListModel = GameListModel.fromJson(response);
      print("done");
      for (var i = 0; i < gameListModel.appCenter!.length; i++) {
        var subCategoryList = gameListModel.appCenter![i].subCategory;
        for (var j = 0; j < subCategoryList!.length; j++) {
          gameList.add(subCategoryList[j]);
        }
      }
      GetStorage().write("localGameList", gameListModel.toJson());
    } else {
      var localGameList =
          GameListModel.fromJson(GetStorage().read("localGameList"));
      for (var i = 0; i < localGameList.appCenter!.length; i++) {
        var subCategoryList = localGameList.appCenter![i].subCategory;
        for (var j = 0; j < subCategoryList!.length; j++) {
          gameList.add(subCategoryList[j]);
        }
      }
    }

    notifyListeners();
  }

  download({required int index}) async {
    await canLaunch(baseUrl + "${gameList[index].appLink}")
        ? await launch(baseUrl + "${gameList[index].appLink}")
        : throw 'Could not launch _baseUrl+"${gameList[index].appLink}"';
    notifyListeners();
  }
}
