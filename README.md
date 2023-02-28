# DogeCoinFetch-iOS

### How to run

```
> cd DogeCoinFetch-iOS
> open DogeCoinFetch-iOS.xcodeproj
```
### Contents

- [App Apperance](https://github.com/alex99091/DogeCoinFetch-iOS#app-apperance)
- [웹소켓 이란?](https://github.com/alex99091/DogeCoinFetch-iOS#웹소켓-이란??)
- [StarScream 라이브러리](https://github.com/alex99091/DogeCoinFetch-iOS#StarScream-라이브러리)
- [WebSocket 구현](https://github.com/alex99091/DogeCoinFetch-iOS#NewWebSocket-구현)


## App Apperance

<img src="https://user-images.githubusercontent.com/111719007/221828887-e9a8220f-05a6-47d9-9ea6-9a364e7b653e.gif" height="500"/>

### 앱 개요

&nbsp; 이 샘플 앱은 [도지코인 웹소켓 API](https://dogechain.info/api/websocket)를 사용하여 도지코인의 `실시간 가격`을 볼 수 있는 `앱`입니다.

프로젝트는 `UIKit` / `SwiftUI` 코드 구현, `Starscream Libary`를 활용한 WebSocket Fetch, `NewWebSocket 구현`을 통한 Fetch등을 포함하고 있습니다.



### 웹소켓 이란??

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



### StarScream 라이브러리

&nbsp;`Starscream`은 `Swift` 프로그래밍 언어로 오픈 소스 `WebSocket 클라이언트 라이브러리`입니다. WebSocket 연결 설정, 메시지 전송 및 수신, 연결 해제 및 오류 처리와 같은 이벤트 처리를 위한 간단하고 쉬운 API를 제공하며 및 다양한 WebSocket 사양을 지원합니다.

UIKit으로 구성된 PriceViewController에서는 extension에 WebSocketDelegate를 추가하여 사용했습니다.

```Swift
class PriceViewController: UIViewController {
    // Property
    var socket: WebSocket!
    var isConnected = false
    let server = WebSocketServer()
    ...
    // Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        ...
        openWebSocket()
    }
    // Method
    func openWebSocket() {
        let urlString = "wss://ws.dogechain.info/inv"
        guard let url = URL(string: urlString) else { return }
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
        requestPrice()
    }
    func requestPrice() {
        socket.write(string: message)
    }
    ...
}
```

```Swift
extension PriceViewController: WebSocketDelegate {
    func didReceive(event: WebSocketEvent, client: WebSocketClient) {
        switch event {
        case .connected(let headers):
            isConnected = true
        case .disconnected(let reason, let code):
            isConnected = false
        case .text(let string):
            guard let json = string.data(using: .utf8) else { return }
            let decoder = JSONDecoder()
            
            guard let dataResponse = try? decoder.decode(DataResponse.self, from: json) else { return }
            dogeCoinPrice.updateValue(dataResponse.x.value!, forKey: "USD")
            coinCollectionView.reloadData()
        }
    }
    ...
}
```

string 형태의 응답을 받을 경우에 해당 string을 jsonDecoder를 사용하여 DataResponse 모델로 받아준 후에

해당 값을 콜렉션뷰의 데이터소스에 갱신한 후 데이터를 리로드하는 방식을 사용했습니다.

### NewWebSocket 구현

- URLSession을 통한 웹소켓 커넥션 생성 
- 웹소켓 연결 
- 서버에 연결 
- 메시지 request 및 respond 처리를 기능을 담당하는 NewWebSocket Class입니다.

`URLSessionWebSocketDelegate`를 사용하였는데 `URLSessionWebSocketDelegate`는 `URLSession`에서 `WebSocket 연결`을 `관리`하기 위한 `델리게이트 프로토콜`입니다. 이 `프로토콜`은 WebSocket 연결 상태의 변경, 메시지 수신, 에러 처리 등의 `이벤트`를 처리하기 위한 `메서드를 제공`하여, `URLSession 객체`를 통해 `WebSocket 연결`을 `설정`하고 `관리`할 수 있습니다.

```Swift
class NewWebSocket: NSObject, URLSessionWebSocketDelegate {
    let urlString = "wss://ws.dogechain.info/inv"
    var websocketTask: URLSessionWebSocketTask?
    weak var delegate: NewWebSocketDelegate?
    
    func connect() {
        let session = URLSession(configuration: .default,
                                 delegate: self,
                                 delegateQueue: OperationQueue())
        
        guard let url = URL(string: urlString) else { return }
        websocketTask = session.webSocketTask(with: url)
        websocketTask?.resume()
    }
    
    func receive() {
        websocketTask?.receive(completionHandler: { (result: Result<URLSessionWebSocketTask.Message, Error>) in
            switch result {
            case .success(.string(let string)):
                ...
        })
    }
    
    func send(message: String) { ... }
    
    func close() { ...}
    ...
}

protocol NewWebSocketDelegate: AnyObject {
    func webSocketDidConnect()
    func webSocketDidReceiveMessage(_ message: String)
    func webSocketDidDisconnect()
}
```

`SwiftUI`화면에서는 PriceViewModel클래스의 @Published된 도지코인 가격을 `onReceive 메소드`를 사용하여 `데이터 변경`때마다 `UI`를 `업데이트` 할 수 있게 사용하였습니다.

```Swift
class PriceViewModel: ObservableObject, NewWebSocketDelegate {
    @Published var dogeCoinPrice = [String: String]()
    var newWebSocket = NewWebSocket()
    let USDtoKRWCurrency: Double = 1318.60
    let message = "{\"op\":\"price_sub\"}"
    
    init() {
        newWebSocket.connect()
        newWebSocket.delegate = self
        newWebSocket.send(message: message)
    }
    ...
}
```

```Swift
struct PriceView: View {
    @StateObject var priceViewModel = PriceViewModel()
    ...
    var body: some View {
        ...
        }
        .onReceive(priceViewModel.$dogeCoinPrice) { dogeCoinPrice in
            currentDogeCoinPrice = dogeCoinPrice
        }
    }
    ...
}
```
