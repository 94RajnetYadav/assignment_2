import 'dart:convert';
import 'dart:developer';
import 'package:get/get.dart';
import '../data/networkApiServic.dart';

class CounterControler extends GetxController {
  var page = 1.obs;

  var limit = 8.obs;
  var isFirstLoadRunning = false.obs;
  var hasNextPage = true.obs;

  var isLoadMoreRunning = false.obs;

  isloadingmore(bool value) {
    isLoadMoreRunning.value = value;

    update();
    log("isLoadMore:--" + isFirstLoadRunning.value.toString());
  }

  isFirstLoad(bool value1) {
    isFirstLoadRunning.value = value1;

    update();
    log("firstload:--" + isFirstLoadRunning.value.toString());
  }

  var jsonresponse = [].obs;

  void firstLoad() async {
    isFirstLoad(true);

    try {
      getApiServic(
        page.value,
        limit.value,
      ).then((response) {
        log("data13:--");
        if (response == null) {
        } else {
          jsonresponse.value.clear();
          jsonresponse.value = jsonDecode(response);

          log("data13:--1" + jsonresponse.toString());
        }
      });
    } catch (err) {
      print('Something went wrong');
    }

    isFirstLoad(false);
  }

  loadMore() async {
    if (hasNextPage.value == true &&
        isFirstLoadRunning.value == false &&
        isLoadMoreRunning.value == false) {
      isloadingmore(true);
      log("tttt:-" + isLoadMoreRunning.value.toString());
      page.value += 1;
      try {
        getApiServic(
          page.value,
          limit.value,
        ).then((response) {
          isloadingmore(true);
          log("data13:--re");
          if (response == null) {
          } else {
            final List fetchedPosts = jsonDecode(response);
            if (fetchedPosts.isNotEmpty) {
              jsonresponse.value.addAll(fetchedPosts);
              log("reload:--" + jsonresponse.value.toString());
              update();
              isloadingmore(false);
              update();
            } else {
              hasNextPage.value = false;
            }
          }
        });
      } catch (err) {
        print('Something went wrong!');
      }

      isloadingmore(false);
    }
  }
}
