# Marvel 

## How to test?

1. Clone this repository or download source code from: https://github.com/GonzaDiz/Marvel/archive/refs/heads/main.zip 
2. Open `Marvel.xcodeproj` with Xcode
3. Wait for [Swift Package Manager](https://swift.org/package-manager/) to fetch all depencencies
4. Run the APP

## Requirements 

- `Xcode 12.0 +` (13.0 is recommended)
- `Swift 4 +`

## Notes

- This app was designed using MVVM pattern and RxSwift is being used to bind our ViewModels to Views.
- All UI code was written using autolayout without using Storyboards or XIBs.
- UI tests runs in unit test target by using [KIF](https://github.com/kif-framework/KIF) and http requests are being mocked with [OHHTTPStubs](https://github.com/AliSoftware/OHHTTPStubs)

## Demo

Recorded in (188x400 15FPS)

![demo_4](https://user-images.githubusercontent.com/26527586/139590146-0f52fefb-af72-44b0-8572-eb8a173219ad.gif)

Dark mode:

| Character List       | Character Detail    | Error view :( |
| :------------- | :----------: | -----------: |
|  ![list](https://user-images.githubusercontent.com/26527586/139591113-71cfdb5b-8638-4a8f-b196-2d4302a2f314.png) | ![detail](https://user-images.githubusercontent.com/26527586/139591118-bf4009f5-9ec5-443b-9361-2f1154301052.png)| ![error](https://user-images.githubusercontent.com/26527586/139591120-4381c115-ec04-46b1-8174-00b8aa613c3d.png)|

## Contact

I hope the code is self explanatory but don't hesitate to contact me to: `dizmartin.gonzalo@gmail.com` if you got any question.
