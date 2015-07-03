## Siphon 사용 관련 ##

### 왜 Siphon은 Skype와 연동이 안되나요? ###
Siphon은 SIP 프로토콜을 사용하는 반면, Skype는 SIP프로토콜이 아닌 독자 프
로토콜을 사용하고 있습니다.

_하지만 당신은 gizmo5프로젝트를 통해 Skype사용자와 통화할 수 있습니다. 해당
사용자와 통화를 통화를 하고자 한다면 SIP URL을
sip://number@opensky.gizmo5.com 으로 입력해야 합니다. 이 URL은 당신의
safari의 주소창이나 주소록의 Web field에 기록하면 됩니다._

### 왜 Siphon을 실행하지 않았을때는 수신이 안됩니까? ###
애플은 어플리케이션이 백그라운드로 작동하는것을 혀용하지 않습니다. 따라서
Siphon을 실행하지 않은경우, 당신이 사용하고 있는 SIP 서버는 당신의 iPhone의
존재를 알 수 없습니다.

### 왜 Siphon은 3G/EDGE망을 통해서는 사용할 수 없습니까? ###

The developer agreement forbids the development of VoIP software for
3G/Edge. Moreover, several mobile phone operator forbid the VoIP traffic on
their 3G/EDGE network.
개발자 계약서에는 VoIP소프트웨어는 3G/Edge망을 사용할 수 없도록 명기되어 있
습니다. 거의 대부분의 이동통신망 사업자도 마찬가지로 3G/Edge망을 통한 VoIP
트래픽은 금지하고 있습니다.

### Cydia를 통해 배포되는 Siphon은 3G/EDGE망을 사용할 수 있습니다. ###

But the users must verified their mobile subscription. The author is not
responsible of Siphon's usage.
하지만 사용자는 반드시 통신사 약관을 읽어봐야 합니다. 본 제작자는 Siphon의
사용에 관해서는 일절의 책임이 없음을 밝힙니다.



### Siphon은 별도의 게이트웨이 서버를 사용합니까? ###

아닙니다. 당신은 SIP 서비스 제공자에 직접 연결해야 합니다.


### Siphon은 블루투스 스테레오 헤드셋과 연동이 가능합니까? ###

만약 당신이 아이폰용 블루투스 헤드셋과 A2DP아답터를 가지고 있다면, Siphon은
블루투스 스테레오와 연동이 가능합니다.

참고로 Jaybird JB-200와 테스트한 결과, 핸즈프리를 통한 통화는 실패했습니다.
이는 애플의 제약사항입니다.


### NAT옵션이 뭔가요? ###

NAT은  Network Address Translation의 약자입니다.

### ICE 옵션은 뭔가요? ###

ICE는 Interactive Connectivity Establishment의 약자입니다.


### Siphon에서는 어떤 코덱을 지원하나요? ###

현재 Siphon은 G.711, GSM, G.722코덱을 지원합니다. 조만간 iLbc, amr을 지원할
예정입니다.

## Siphon와 iPhone의 어플리케이션 관련 ##

### 왜 Siphon은 iPhone의 즐겨찾기를 사용하거나 표시할 수 없나요? ###

애플은 주소록의 공유를 허락하고 있지만, iPhone OS 2.0과 2.1에서는 즐겨찾기
와 연동할 API가 존재하지 않습니다.

### 왜 Siphon과 iPhone의 최근통화 목록은 연동이 안되나요? ###

위의 favorites와 마찬가지로, 해당 기능은 애플에서 지원하지 않습니다.