// Copyright (c) 2017, ivan koop. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:async';
import 'package:http/http.dart' as http;


class redditCrawl {
  String url = "https://www.reddit.com/r/programming/";
  redditCrawl(){
    print("constructor aca");
    crawl();
  }

  void onRequest(){
    http.read(url).then((contents) {
      print("crawling --> " + url);
      inspect(contents);
    });
  }

  Duration TIMEOUT = const Duration(seconds: 3);
  Duration ms = const Duration(milliseconds: 1);

  crawlTimeout([int milliseconds]) {
    var duration = milliseconds == null ? TIMEOUT : ms * milliseconds;
    return new Timer(duration, crawl);
  }

  void crawl() {

    onRequest();
    crawlTimeout();
  }

  void inspect(String site_code){
    RegExp exp = new RegExp(r"https?:\/\/(www\.)?[-a-zA-Z0-9@:%._\+~#=]{2,256}\.[a-z]{2,6}\b([-a-zA-Z0-9@:%_\+.~#?&//=]*)");

    var matches = exp.allMatches(site_code);

    for(Match match in matches){
      print(match[0]);
      if(match[0].contains("github")){
        print("HAY REPO DE GITHUB");
        break;
      }

    }
  }
}