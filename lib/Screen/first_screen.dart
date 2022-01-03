import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:game/Providers/game_list_providers.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';


class FirstScreen extends StatefulWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override
  _FirstScreenState createState() => _FirstScreenState();
}

class _FirstScreenState extends State<FirstScreen> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      Provider.of<GameListProviders>(context, listen: false).gameListApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameListProviders>(
        builder: (context, gameListProvidersObj, _) {
      return gameListProvidersObj.gameList.length == 0
            ? Center(child: CupertinoActivityIndicator()):
       Scaffold(
        appBar: AppBar(
          title: Text("Game List "),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: gameListProvidersObj.gameList.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 12.h,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    color: Colors.white,
                    boxShadow: [
                      new BoxShadow(
                        color: Color(0xffbeeca4),
                        blurRadius: 5.0, // soften the shadow
                        spreadRadius: 6.0,
                      ),
                    ]),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15.0),
                        child: CachedNetworkImage(
                          imageUrl: "${gameListProvidersObj.gameList[index].icon}",
                          progressIndicatorBuilder: (context, url, downloadProgress) =>
                              CircularProgressIndicator(value: downloadProgress.progress),
                          errorWidget: (context, url, error) => Icon(Icons.error),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                          left: 15,
                        ),
                        width: 20.h,
                        // color: Colors.black54,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${gameListProvidersObj.gameList[index].name}",
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 17,
                                fontWeight: FontWeight.w500,
                              ),
                              // textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            RatingBar.builder(
                              initialRating: double.parse(
                                  "${gameListProvidersObj.gameList[index].star}"),
                              direction: Axis.horizontal,
                              ignoreGestures:true ,
                              allowHalfRating: true,
                              itemSize: 15,
                              itemCount: 5,
                              itemPadding:
                                  EdgeInsets.symmetric(horizontal: 1.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.black54,
                              ), onRatingUpdate: (double value) {  },

                            ),
                            SizedBox(
                              height: 0.5.h,
                            ),
                            // Spacer(),
                            Text(
                              "${gameListProvidersObj.gameList[index].installedRange}",
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                              // textAlign: TextAlign.start,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Provider.of<GameListProviders>(context, listen: false).download(index: index);
                          },
                          child: Container(
                            height: 3.7.h,
                            width: 12.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.green,
                            ),
                            child: Center(
                              child: Text(
                                "Download",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w500,
                                ),
                                // textAlign: TextAlign.start,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }

  // _gameListApi() async {
  //   // try {
  //     var response = await APIManager().getAPICall(
  //         "http://vasundharaapps.com/artwork_apps/api/AdvertiseNewApplications/17/com.latest.status.message.text.jokes.funny");
  //     var gameListModel = GameListModel.fromJson(response);
  //     print("done");
  //     setState(() {
  //       // var i=0;
  //       for (var i = 0; i < gameListModel.appCenter!.length; i++) {
  //         var subCategoryList = gameListModel.appCenter![i].subCategory;
  //         for (var j = 0; j < subCategoryList!.length; j++) {
  //           gameList!.add(subCategoryList[j]);
  //           // print(subCategoryList[j].id);
  //         }
  //       }
  //
  //       // i++;
  //     });
  // } catch (e) {
  //   print(e);
  // }
  // }

  // _download(int index) async {
  //   await canLaunch(_baseUrl + "${gameList![index].appLink}")
  //       ? await launch(_baseUrl + "${gameList![index].appLink}")
  //       : throw 'Could not launch _baseUrl+"${gameList![index].appLink}"';
  // }
}
