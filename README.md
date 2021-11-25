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
In the NewsListController, the news are load from https://gnews.io and the application will save it into persistent storage which using third-party library call Cache (https://github.com/hyperoslo/Cache) which will use in case of no internet connection and using will still able to see the news in the NewsListView. The content in the persistent storage will expire in 7 days.!

<img width="491" alt="Screen Shot 2564-11-25 at 23 09 42" src="https://user-images.githubusercontent.com/49471123/143479588-d72782ca-65b3-45c7-a289-af9962b72688.png"> 

All the article in the new are display by using webview.

<img width="491" alt="Screen Shot 2564-11-25 at 23 11 13" src="https://user-images.githubusercontent.com/49471123/143479618-760564e4-6637-4d5a-9a6f-da31783b87f6.png">

## SearchController
In this controller, the end-user can search the news base on the input keyword, and they have a lot of choices to filter the news article such as content related field (title, description and content), and publised date. Moreover, they will able to sort the searched news with Upload date or Relevance. 
As mention above, the application is built using reactive programming. Therefore, the application is run smoothly and tableview is auto reload when there is a value is update. For instance, the filter value is just update, the view will reload instantly to find the new article for the end-user. Plus code is so clean since tableView.reload() does not have to call everytime something update.
The search history are store in persistent storage as well for the convenience and usefulness of the user experience. The search history in the persistent storage will expire in 7 days !
[Uploading Screen Shot 2564-11-25 at 23.14.52.png…]()
<img width="491" alt="Screen Shot 2564-11-25 at 23 15 07" src="https://user-images.githubusercontent.com/49471123/143479827-6e8a3bdd-0e09-4bc9-aa3e-8682a52cad92.png">
<img width="491" alt="Screen Shot 2564-11-25 at 23 14 34" src="https://user-images.githubusercontent.com/49471123/143479854-5a5db3a9-649c-466c-835e-af88198d8ec6.png">
<img width="491" alt="Screen Shot 2564-11-25 at 23 16 38" src="https://user-images.githubusercontent.com/49471123/143479867-99a934eb-bb29-4da7-9fc8-b782f65720d1.png">
<img width="491" alt="Screen Shot 2564-11-25 at 23 16 49" src="https://user-images.githubusercontent.com/49471123/143479877-117de3a8-1689-4d2d-a655-b025002ac968.png">

# Third-party Libraries
Cache - Persistent storage - https://github.com/hyperoslo/Cache
RxSwift, RxCocoa - Reactive Programming for Swift - https://github.com/ReactiveX/RxSwift
AlamofireImage - Load image from given url - https://github.com/Alamofire/AlamofireImage
Presentr - Half screen pop up view - https://github.com/IcaliaLabs/Presentr


