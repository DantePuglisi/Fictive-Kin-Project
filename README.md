# Fictive-Kin-Project
This is the project for the interview with Fictive Kin. It fetches `posts` from https://jsonplaceholder.typicode.com/posts and displays them in a `UICollectionView` where the cells size themselves according to their content using AutoLayout.

## Main Components
- `Webservice` as a `Service` that has the logic to fetch the data from the server
- `Post` as the `Model`, it complies to `Codable` so the JSON can be easily parsed
- `TitlesViewController` and `PostViewController` as the `UIViewControllers`, more info below
- `PostCell` as the `UICollectionViewCell`
- `LoadingView` as a `UIView` to display the loading state, more info below

----

### `TitlesViewController`:
`TitlesViewController` handles the `UICollectionView` layout logic and it makes the call to `WebService` to fetch the posts
### `PostViewController`:
`PostViewController` simply displays the `Title` and the `Body` for each `Post` when a `PostCell` is tapped on `TitlesViewController`
### `LoadingView`:
The idea of `LoadingView` is to resemble a clock (in a very basic way) to show the user that we're loading the data. Since we can get the JSON **really** fast I placed a delay before making the call to the server so the animation can be seen (`TitlesViewController.swift:34`)
