# MediaNews
MediaNews is an application that end-user can read the recent news from different source. Moreover, the application also allow the end-user to search for a news that they want base on published date or content related.

# Description
This application is built using Reactive programming known as RxSwift and RxCocoa, AlamofireImage for retrieve the image from given URL link, and Cache for persistent storage.

# Installation
To run the project, first you need to install the pods first by running command: 
To install, run:
```bash
pod install
```
You also need the API key from: https://gnews.io/docs/v4#introduction (which is free to register), and then you need to replace the API key which is provide as sample in Model/ApiKey-Sample.swift .

# Technique & Methods

## NewsListController
In the NewsListController, the news are load from https://gnews.io and the application will save it into persistent storage which using third-party library call Cache (https://github.com/hyperoslo/Cache) which will use in case of no internet connection and using will still able to see the news in the NewsListView. The content in the persistent storage will expire in 7 days.
All the article in the new are display by using webview.

## SearchController
In this controller, the end-user can search the news base on the input keyword, and they have a lot of choices to filter the news article such as content related field (title, description and content), and publised date. Moreover, they will able to sort the searched news with Upload date or Relevance. 
As mention above, the application is built using reactive programming. Therefore, the application is run smoothly and tableview is auto reload when there is a value is update. For instance, the filter value is just update, the view will reload instantly to find the new article for the end-user. Plus code is so clean since tableView.reload() does not have to call everytime something update.
The search history are store in persistent storage as well for the convenience and usefulness of the user experience. The search history in the persistent storage will expire in 7 days 

# Third-party Libraries
Cache - Persistent storage - https://github.com/hyperoslo/Cache
RxSwift, RxCocoa - Reactive Programming for Swift - https://github.com/ReactiveX/RxSwift
AlamofireImage - Load image from given url - https://github.com/Alamofire/AlamofireImage
Presentr - Half screen pop up view - https://github.com/IcaliaLabs/Presentr


