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
![9DBF00CE-20B4-4120-AF00-FF9A5E78BCBA_1_201_a](https://user-images.githubusercontent.com/49471123/143481225-28c60dc8-3297-4ddc-9702-042ca12e8dc9.jpeg)

All the article in the new are display by using webview.
![648E3B9D-8C44-40FC-A9AC-E669FAD28C09_1_201_a](https://user-images.githubusercontent.com/49471123/143481239-e0660380-e733-41f2-8174-ad1483ba4761.jpeg)

## SearchController
In this controller, the end-user can search the news base on the input keyword, and they have a lot of choices to filter the news article such as content related field (title, description and content), and publised date. Moreover, they will able to sort the searched news with Upload date or Relevance. 
As mention above, the application is built using reactive programming. Therefore, the application is run smoothly and tableview is auto reload when there is a value is update. For instance, the filter value is just update, the view will reload instantly to find the new article for the end-user. Plus code is so clean since tableView.reload() does not have to call everytime something update.
The search history are store in persistent storage as well for the convenience and usefulness of the user experience. The search history in the persistent storage will expire in 7 days !

![CB77B710-17D0-45D3-A31E-4C580EFE3F90_1_201_a](https://user-images.githubusercontent.com/49471123/143481560-f07b8c95-3356-406f-aaab-83282f932b14.jpeg)
![ABC725D1-6978-4B87-9B84-B47C1B2C1346_1_201_a](https://user-images.githubusercontent.com/49471123/143481570-c1d32b04-c955-4c56-8f4c-df2c8ca30691.jpeg)
![4815FB0C-B045-480D-9C82-3289F4ADD892_1_201_a](https://user-images.githubusercontent.com/49471123/143481577-ad653d4e-188e-409e-bcce-37a5d68985f9.jpeg)
![552B3B1D-5C7A-45FA-BFBA-8BFD7BB297ED_1_201_a](https://user-images.githubusercontent.com/49471123/143481584-0a5ef62e-537e-4f40-95dd-133069b9cf51.jpeg)
![BFC8C684-CC81-4D74-A4B0-EE06F3CED378_1_201_a](https://user-images.githubusercontent.com/49471123/143481590-699adc57-c821-413c-bb1c-2b9669522636.jpeg)

# Third-party Libraries
Cache - Persistent storage - https://github.com/hyperoslo/Cache
RxSwift, RxCocoa - Reactive Programming for Swift - https://github.com/ReactiveX/RxSwift
AlamofireImage - Load image from given url - https://github.com/Alamofire/AlamofireImage
Presentr - Half screen pop up view - https://github.com/IcaliaLabs/Presentr
