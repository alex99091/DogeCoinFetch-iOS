# DogeCoinFetch-iOS

### How to run

```
> cd DogeCoinFetch-iOS
> open DogeCoinFetch-iOS.xcodeproj
```
### Contents

- [App Apperance](https://github.com/alex99091/DogeCoinFetch-iOS#app-apperance)
- [`웹소켓` 이란?](https://github.com/alex99091/DogeCoinFetch-iOS#app-apperance)
- [StarScream 라이브러리](https://github.com/alex99091/DogeCoinFetch-iOS#app-apperance)
- [WebSocket 구현](https://github.com/alex99091/DogeCoinFetch-iOS#app-apperance)


## App Apperance

<img src="https://user-images.githubusercontent.com/111719007/221828887-e9a8220f-05a6-47d9-9ea6-9a364e7b653e.gif" height="500"/>



### 앱 개요

&nbsp; 이 샘플 앱은 [도지코인 웹소켓 API](https://dogechain.info/api/websocket)를 사용하여 도지코인의 `실시간 가격`을 볼 수 있는 앱입니다.

프로젝트는 `UIKit` / `SwiftUI` 코드 구현, `Starscream` Libary를 활용한 WebSocket Fetch, `NewWebSocket 구현`을 통한 Fetch등을 포함하고 있습니다.



### 웹소켓 이란?

&nbsp;WebSocket은 클라이언트와 서버 간에 `실시간 양방향` 데이터 전송을 가능하게 하는 `통신 프로토콜`입니다.
클라이언트와 서버 간에 `최초 연결 요청`을 보낸 후에, 이후에는 계속해서 연결을 유지합니다. 

이 과정에서 클라이언트와 서버는 서로의 프로토콜 버전 및 기능을 확인하고, 연결을 유지하기 위한 특별한 `헤더를 교환`합니다. 
이후에는 연결이 유지되는 동안에 데이터를 전송하고, 이를 통해 `실시간 양방향` 통신이 가능해집니다.

기존의 HTTP 요청보다 더 `빠르고 효율적인 통신`이 가능하기 때문에
`WebSocket`은 실시간 채팅, 라이브 업데이트, 온라인 게임 등 웹 애플리케이션에서 일반적으로 사용됩니다.

`Swift`에서는 `URLSessionWebSocketTask`를 제공하며, 
```Swift
class URLSessionWebSocketTask : URLSessionTask
```
이는 `WebSocket` `프레이밍의 형태`로 TCP 및 TLS를 통한 
메시지 지향 전송 프로토콜을 제공하는 `URLSessionTask`의 구체적인 `하위 클래스`입니다. 
```Swift
var delegate: URLSessionDelegate? { get }
```
`Delegate`를 사용하여 `서버의 응답정보`를 원하는 형태로 `가져올 수` 있습니다.
