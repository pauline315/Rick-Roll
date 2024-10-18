# Rick and Roll Character List iOS Application

This project is an iOS application that fetches data from the Rick and Morty API to display a list of characters. It includes two main screens:
- A list of characters with their names, species, and images.
- A detailed view of each character with more information such as status,location and gender.


 ## Requirements:
- Xcode 15.0+
- iOS 17.2+
- Dependancies - RxSwift & RxCocoa

### Steps to Build:
1. Clone the repository from GitHub.
2. Open the `.xcodeproj` file in Xcode.
3. Select the appropriate iOS simulator or device.
4. Build and run the project (Cmd + R).

### Assumptions:
- The Rick and Morty API always returns valid data for character details.
- The filter functionality allows users to filter characters by their status, which is limited to three categories: **Alive**, **Dead**, and **Unknown**. These are predefined by the Rick and Morty API, and it is assumed that users are familiar with these statuses and can easily understand their meanings.
- Users can switch between these statuses to refine the displayed character list accordingly.

  
### Decisions:
- Used UIKit programmatically for the main screens (Character List and Character Detail) as it provides better control over table views.
-Used RxSwift for reactive programming.

### Challenges:
- Pagination Handling**: Managing the API's paginated data efficiently was challenging. 
- Image Loading**: Downloading and caching images without affecting scrolling performance was important. 

