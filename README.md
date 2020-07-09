# Fictive Kin Project
This is the project for the interview with Fictive Kin. It fetches `posts` from https://jsonplaceholder.typicode.com/posts and displays them in a `UICollectionView` where the cells size themselves according to their content using AutoLayout.

## Main Components
- `Webservice` as a `Service` that has the logic to fetch the data from the server
- `Post` as the `Model`, it complies to `Codable` so the JSON can be easily parsed
- `TitlesViewController` and `PostViewController` as the `UIViewControllers`, more info below
- `PostCell` as the `UICollectionViewCell`
- `LoadingView` as a `UIView` to display the loading state, more info below

### `TitlesViewController`:
`TitlesViewController` handles the `UICollectionView` layout logic and it makes the call to `WebService` to fetch the posts. `WebService` gets injected into `TitlesViewController` by `Property Injection` on `SceneDelegate.swift:22`
### `PostViewController`:
`PostViewController` simply displays the `Title` and the `Body` for each `Post` when a `PostCell` is tapped on `TitlesViewController`
### `LoadingView`:
The idea of `LoadingView` is to resemble a clock (in a very basic way) to show the user that we're loading the data. Since we can get the JSON **really** fast I placed a delay before making the call to the server so the animation can be seen (`TitlesViewController.swift:35`)

---

## Error Handling
If there's an error when fetching the data from the server (e.g. no internet connection) an alert appears indicating such error with a *Retry* button which fires the request again. This can be tested by initializing the app without internet connection and connecting again before tapping on *Retry*

## Testing
I decided to add Unit Tests just for the data handling, there's a `class` called `WebServiceTests` and a local JSON file with mock data (`DataMock.json`). The idea is to use the `getPosts()` function from `WebService` with the local JSON file's URL to check if the parsing works as expected

## Launch Screen
I decided to use a `Gradient` for the background of the `TitlesViewController` which is generated at runtime (`TitlesViewController.swift:81`) but to keep the `Launch Screen` consistent I needed to use the same gradient there. `Launch Screen` doesn't allow to use custom code so I generated a `UIImage` from the `CAGradientLayer`, saved it to my Mac, added it to the `XCAssets` and put it in the `Launch Screen` inside a `UIImageView`. After doing this I could've used this same `UIImage` for the `TitlesViewController` background but I felt like the original code for the creation of the layer should remain there for the purpose of this project

---

### Notes
- I'm delaying the fetching of the posts in `TitleViewController.swift:36` by 4 seconds so the loading clock can be seen, if this is removed the data is shown almost instantly
- I decided not to include more tests to keep it simple, as requested. Same reason I didn't add UI tests
- The overall UI of the app is definitely not ideal but I chose to spend time with the code structure and the architecture of the app rather than on its UI
- I'm pretty happy with how the loading clock works although again, not ideal UI :see_no_evil:
