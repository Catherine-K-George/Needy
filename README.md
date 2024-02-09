Needy Shopping App - A very basic iOS shopping application with mainly six screens

* Splash
* Login
* Home
* Product List
* Product Detail
* Favourite List

Followed Clean Architecture and implemented all layers

Functionalities Covered
* Splash - Basic splash load with logo and text
* Login - Username and password login with loading indicator, API driven
* Home - Tabbar with two tabs, home & favourites. Home screen with product category listing from API and User logout
* Product List - Product listing screen with product collection from API
* Product Detail - Basic detail screen
* Networking - Generic networking to handle all service calls
* Mock Network Client - Used mock data to test network calls 

SwiftUI Screens
* Favourite Listing with mock json

Libraries Used -  Swift Package Manager 
* Kingfisher - To load product images
* iOSSnapShotTestCases - For snapshot testing

Snapshot testing
* Incorporated snapshot testing using the iOSSnapShotTestCase library.
* Covered snapshot testing for Login, Home, Product list, and detail screens, reference snaps uploaded in the repo.

Test Coverage - 91% 
* Added test cases for mocking API calls, ensuring 100% code coverage.
* Covered all views, viewmodels and supporting classes

UI - UIKit & SwiftUI

API - https://fakestoreapi.com/docs
* https://fakestoreapi.com/auth/login
* https://fakestoreapi.com/products/categories
* https://fakestoreapi.com/products/category/jewelery


Screenshots attached. Thanks!!
