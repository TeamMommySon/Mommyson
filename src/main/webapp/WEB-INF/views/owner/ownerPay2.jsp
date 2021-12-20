<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="../resources/css/pay.css">
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<title>결제</title>
</head>
<body>
	
	<div style="width: 1550px; margin: 0 auto; margin-top: 50px;">
        <a href="${ pageContext.servletContext.contextPath }/"><img src="../resources/images/mainlogo.png" style="width: 300px;"></a>
        <br><br><br>
        <hr> 
    </div>
    <br><br>
    <div style="width: 1550px; margin: 0 auto;">
        <p style="margin: 20px 0 50px 30px; font-size: 40px; font-weight: 900; float: left">이용권 결제</p>
        <p style="float: right; font-size: 20px; font-weight: 700; margin-top: 30px; margin-right: 30px;">결제완료</p.>
        <p style="float: right; font-size: 20px; font-weight: 700; color: #346aff; margin-top: 30px;">이용권 결제></p>
        <br><br><br><br><br><br>
        <hr style="width: 1550px;">
    </div>
    
    <div class="pay">
    <h2>구매자 정보</h2>
    </div>
    <table class="tg" style="text-align: center;">
        <tbody>
        <tr>
            <th class="tg-c3ow">상호명</th>
            <th class="tg-0pky">${ requestScope.ownerInfo.ceo.store.storeName }</th>
        </tr>
        <tr>
            <td class="tg-c3ow">아이디</td>
            <td class="tg-0pky">${ requestScope.ownerInfo.memId }</td>
        </tr>
        <tr>
            <td class="tg-c3ow">이메일</td>
            <td class="tg-0pky">${ requestScope.ownerInfo.email }</td>
        </tr>
        <tr>
            <td class="tg-c3ow">전화번호 </td>
            <td class="tg-0pky">${ requestScope.ownerInfo.phone }</td>
        </tr>
        <tr>
            <td class="tg-c3ow">대표자명</td>
            <td class="tg-0pky">${ requestScope.ownerInfo.ceo.name }</td>
        </tr>
        <tr>
            <td class="tg-c3ow">사업자 등록번호</td>
            <td class="tg-0pky">${ requestScope.ownerInfo.ceo.no }</td>
        </tr>
        </tbody>
    </table>
    <br><br>
    <div class="pay">
        <h2>결제 정보</h2>
    </div>
        <table class="tg" style="text-align: center;">
            <tbody>
            <tr>
                <th class="tg-c3ow">상품명</th>
                <th class="tg-0pky">${ requestScope.membership.msType }</th>
            </tr>
            <tr>
                <td class="tg-c3ow" style="font-weight: 700;">총 결제금액</td>
                <td class="tg-0pky" style="font-weight: 700;">${ requestScope.membership.msPrice }원</td>
            </tr>
            <tr>
                <td class="tg-c3ow" style="font-weight: 700;">결제 방법</td>
                <td class="tg-0pky" style="font-weight: 700;">카카오페이 <img src="../resources/images/pay.png" width="70px" height="30px" style="position: relative; top: 9px " ></td>
            </tr>
            </tbody>
        </table>
    <br><br>
    <div class="pay">
        <p style="margin-left: 20px; font-weight: 700;">구매조건 확인 및 결제대행 서비스 약관 동의 &nbsp;&nbsp;<button style="border: none; background: 0;" id="btn1">보기</button></p>
        <div class="terms" id="div1">
            <span>
                [전자금융거래 기본약관]
                한국정보통신주식회사
                
                제 1 조 (목적)
                이 약관은 한국정보통신 주식회사(이하 “회사”라 합니다)가 제공하는 전자지급결제대행서비스 및 결제대금예치서비스를 이용자가 이용함에 있어 회사와 이용자 사이의 전자금융거래에 관한 기본적인 사항을 정함을 목적으로 합니다.
                
                제 2 조 (용어의 정의)
                이 약관에서 정하는 용어의 정의는 다음과 같습니다.
                
                '전자금융거래'라 함은 회사가 전자적 장치를 통하여 전자지급결제대행서비스 및 결제대금예치서비스 (이하 '전자금융거래 서비스'라고 합니다)를 제공하고, 이용자가 회사의 종사자와 직접 대면하거나 의사소통을 하지 아니하고 자동화된 방식으로 이를 이용하는 거래를 말합니다.
                '전자지급결제대행서비스'라 함은 전자적 방법으로 재화의 구입 또는 용역의 이용에 있어서 지급결제정보를 송신하거나 수신하는 것 또는 그 대가의 정산을 대행하거나 매개하는 서비스를 말합니다.
                '결제대금예치서비스'라 함은 이용자가 재화의 구입 또는 용역의 이용에 있어서 그 대가(이하 '결제대금'이라 한다)의 전부 또는 일부를 재화 또는 용역(이하 '재화 등'이라 합니다)을 공급받기 전에 미리 지급하는 경우, 회사가 이용자의 물품수령 또는 서비스 이용 확인 시점까지 결제대금을 예치하는 서비스를 말합니다.
                '이용자'라 함은 이 약관에 동의하고 회사가 제공하는 전자금융거래 서비스를 이용하는 자를 말합니다.
                '접근매체'라 함은 전자금융거래에 있어서 거래지시를 하거나 이용자 및 거래내용의 진실성과 정확성을 확보하기 위하여 사용되는 수단 또는 정보로서 전자식 카드 및 이에 준하는 전자적 정보(신용카드번호를 포함한다), '전자서명법'상의 인증서, 회사에 등록된 이용자번호, 이용자의 생체정보, 이상의 수단이나 정보를 사용하는데 필요한 비밀번호 등 전자금융거래법 제2조 제10호에서 정하고 있는 것을 말합니다.
                '거래지시'라 함은 이용자가 본 약관에 의하여 체결되는 전자금융거래계약에 따라 회사에 대하여 전자금융거래의 처리를 지시하는 것을 말합니다.
                '오류'라 함은 이용자의 고의 또는 과실 없이 전자금융거래가 전자금융거래계약 또는 이용자의 거래지시에 따라 이행되지 아니한 경우를 말합니다.
                제3조 (약관의 명시 및 변경)
                회사는 이용자가 전자금융거래 서비스를 이용하기 전에 이 약관을 게시하고 이용자가 이 약관의 중요한 내용을 확인할 수 있도록 합니다.
                회사는 이용자의 요청이 있는 경우 전자문서의 전송방식에 의하여 본 약관의 사본을 이용자에게 교부합니다.
                회사가 약관을 변경하는 때에는 그 시행일 1월 전에 변경되는 약관을 회사가 제공하는 전자금융거래 서비스 이용 초기화면 및 회사의 홈페이지에 게시함으로써 이용자에게 공지합니다.
                제4조 (전자지급결제대행서비스의 종류)
                회사가 제공하는 전자지급결제대행서비스는 지급결제수단에 따라 다음과 같이 구별됩니다.
                
                신용카드결제대행서비스: 이용자가 결제대금의 지급을 위하여 제공한 지급결제수단이 신용카드인 경우로서, 회사가 전자결제시스템을 통하여 신용카드 지불정보를 송, 수신하고 결제대금의 정산을 대행하거나 매개하는 서비스를 말합니다.
                제5조 (결제대금예치서비스의 내용)
                이용자(이용자의 동의가 있는 경우에는 재화 등을 공급받을 자를 포함합니다. 이하 본 조에서 같습니다)는 재화 등을 공급받은 사실을 재화 등을 공급받은 날부터 3영업일 이내에 회사에 통보하여야 합니다.
                회사는 이용자로부터 재화 등을 공급받은 사실을 통보 받은 후 회사와 통신판매업자간 사이에서 정한 기일 내에 통신판매업자에게 결제대금을 지급합니다.
                회사는 이용자가 재화 등을 공급받은 날부터 3영업일이 지나도록 정당한 사유의 제시 없이 그 공급받은 사실을 회사에 통보하지 아니하는 경우에는 이용자의 동의 없이 통신판매업자에게 결제대금을 지급할 수 있습니다.
                회사는 통신판매업자에게 결제대금을 지급하기 전에 이용자에게 결제대금을 환급 받을 사유가 발생한 경우에는 그 결제대금을 소비자에게 환급합니다.
                회사는 이용자와의 결제대금예치서비스 이용과 관련된 구체적인 권리,의무를 정하기 위하여 본 약관과는 별도로 결제대금예치서비스이용약관을 제정할 수 있습니다.
                제6조 (이용시간)
                회사는 이용자에게 연중무휴 1일 24시간 전자금융거래 서비스를 제공함을 원칙으로 합니다. 단, 금융기관 기타 결제수단 발행업자의 사정에 따라 달리 정할 수 있습니다.
                회사는 정보통신설비의 보수,점검 기타 기술상의 필요나 금융기관 기타 결제수단 발행업자의 사정에 의하여 서비스 중단이 불가피한 경우, 서비스 중단 3일 전까지 게시 가능한 전자적 수단을 통하여 서비스 중단 사실을 게시한 후 서비스를 일시 중단할 수 있습니다. 다만, 시스템 장애보국, 긴급한 프로그램 보수, 외부요인 등 불가피한 경우에는 사전 게시 없이 서비스를 중단할 수 있습니다.
                제7조 (접근매체의 선정과 사용 및 관리)
                회사는 전자금융거래 서비스 제공 시 접근매체를 선정하여 이용자의 신원, 권한 및 거래지시의 내용 등을 확인할 수 있습니다.
                이용자는 접근매체를 제3자에게 대여하거나 사용을 위임하거나 양도 또는 담보 목적으로 제공할 수 없습니다.
                이용자는 자신의 접근매체를 제3자에게 누설 또는 노출하거나 방치하여서는 안되며, 접근매체의 도용이나 위조 또는 변조를 방지하기 위하여 충분한 주의를 기울여야 합니다.
                회사는 이용자로부터 접근매체의 분실이나 도난 등의 통지를 받은 때에는 그 때부터 제3자가 그 접근매체를 사용함으로 인하여 이용자에게 발생한 손해를 배상할 책임이 있습니다.
                제8조 (거래내용의 확인)
                회사는 이용자와 미리 약정한 전자적 방법을 통하여 이용자의 거래내용(이용자의 '오류정정 요구사실 및 처리결과에 관한 사항'을 포함합니다)을 확인할 수 있도록 하며, 이용자의 요청이 있는 경우에는 요청을 받은 날로부터 2주 이내에 모사전송 등의 방법으로 거래내용에 관한 서면을 교부합니다.
                회사가 이용자에게 제공하는 거래내용 중 거래계좌의 명칭 또는 번호, 거래의 종류 및 금액, 거래상대방을 나타내는 정보, 거래일자, 전자적 장치의 종류 및 전자적 장치를 식별할 수 있는 정보와 해당 전자금융거래와 관련한 전자적 장치의 접속기록은 5년간, 건당 거래금액이 1만원 이하인 소액 전자금융거래에 관한 기록, 전자지급수단 이용 시 거래승인에 관한 기록, 이용자의 오류정정 요구사실 및 처리결과에 관한 사항은 1년간의 기간을 대상으로 하되, 회사가 전자지급결제대행 서비스 제공의 대가로 수취한 수수료에 관한 사항은 제공하는 거래내용에서 제외됩니다.
                이용자가 제1항에서 정한 서면교부를 요청하고자 할 경우 다음의 주소 및 전화번호로 요청할 수 있습니다.
                주소: 서울특별시 중구 세종대로39 대한상공회의소7층 한국정보통신주식회사
                이메일 주소: easypay@kicc.co.kr
                전화번호: 1600-1234
                제9조 (오류의 정정 등)
                이용자는 전자금융거래 서비스를 이용함에 있어 오류가 있음을 안 때에는 회사에 대하여 그 정정을 요구할 수 있습니다.
                회사는 전항의 규정에 따른 오류의 정정요구를 받은 때에는 이를 즉시 조사하여 처리한 후 정정요구를 받은 날부터 2주 이내에 그 결과를 이용자에게 알려 드립니다.
                제10조 (회사의 책임)
                회사는 접근매체의 위조나 변조로 발생한 사고로 인하여 이용자에게 발생한 손해에 대하여 배상책임이 있습니다. 다만, 이용자가 제7조 제2항을 위반하거나 제3자가 권한 없이 이용자의 접근매체를 이용하여 전자금융거래를 할 수 있음을 알았거나 알 수 있었음에도 불구하고 이용자가 자신의 접근매체를 누설 또는 노출하거나 방치한 경우, 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.
                회사는 계약체결 또는 거래지시의 전자적 전송이나 처리과정에서 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다. 다만, 본 조 제1항 단서에 해당하거나 법인('중소기업기본법' 제2조 제2항에 의한 소기업을 제외합니다)인 이용자에게 손해가 발생한 경우로서 회사가 사고를 방지하기 위하여 보안절차를 수립하고 이를 철저히 준수하는 등 합리적으로 요구되는 충분한 주의의무를 다한 경우, 그 책임의 전부 또는 일부를 이용자가 부담하게 할 수 있습니다.
                회사는 이용자로부터의 거래지시가 있음에도 불구하고 천재지변, 회사의 귀책사유가 없는 정전, 화재, 통신장애 기타의 불가항력적인 사유로 처리 불가능하거나 지연된 경우로서 이용자에게 처리 불가능 또는 지연사유를 통지한 경우(금융기관 또는 결제수단 발행업체나 통신판매업자가 통지한 경우를 포함합니다)에는 이용자에 대하여 이로 인한 책임을 지지 아니합니다.
                회사는 전자금융거래를 위한 전자적 장치 또는 ‘정보통신망 이용촉진 및 정보보호 등에 관한 법률’ 제2조 제1항 제1호에 따른 정보통신망에 침입하여 거짓이나 그 밖의 부정한 방법으로 획득한 접근매체의 이용으로 발생한 사고로 인하여 이용자에게 그 손해가 발생한 경우에는 그 손해를 배상할 책임이 있습니다.
                제11조 (전자지급거래계약의 효력)
                회사는 이용자의 거래지시가 전자지급거래에 관한 경우 그 지급절차를 대행하며, 전자지급거래에 관한 거래지시의 내용을 전송하여 지급이 이루어지도록 합니다.
                회사는 이용자의 전자지급거래에 관한 거래지시에 따라 지급거래가 이루어지지 않은 경우 수령한 자금을 이용자에게 반환하여야 합니다.
                제12조 (거래지시의 철회)
                이용자는 전자지급거래에 관한 거래지시의 경우 지급의 효력이 발생하기 전까지 거래지시를 철회할 수 있습니다.
                전항의 지급의 효력이 발생 시점이란 (i) 전자자금이체의 경우에는 거래 지시된 금액의 정보에 대하여 수취인의 계좌가 개설되어 있는 금융기관의 계좌 원장에 입금기록이 끝난 때 (ii) 그 밖의 전자지급수단으로 지급하는 경우에는 거래 지시된 금액의 정보가 수취인의 계좌가 개설되어 있는 금융기관의 전자적 장치에 입력이 끝난 때를 말합니다.
                이용자는 지급의 효력이 발생한 경우에는 전자상거래 등에서의 소비자보호에 관한 법률 등 관련 법령상 청약의 철회의 방법 또는 본 약관 제5조에서 정한 바에 따라 결제대금을 반환 받을 수 있습니다.
                제13조 (전자지급결제대행 서비스 이용 기록의 생성 및 보존)
                회사는 이용자가 전자금융거래의 내용을 추적, 검색하거나 그 내용에 오류가 발생한 경우에 이를 확인하거나 정정할 수 있는 기록을 생성하여 보존합니다.
                전항의 규정에 따라 회사가 보존하여야 하는 기록의 종류 및 보존방법은 제8조 제2항에서 정한 바에 따릅니다.
                제14조 (전자금융거래정보의 제공금지)
                회사는 전자금융거래 서비스를 제공함에 있어서 취득한 이용자의 인적 사항, 이용자의 계좌, 접근매체 및 전자금융거래의 내용과 실적에 관한 정보 또는 자료를 이용자의 동의를 얻지 아니하고 제3자에게 제공,누설하거나 업무상 목적 외에 사용하지 아니합니다.
                
                제15조 (분쟁처리 및 분쟁조정)
                이용자는 다음의 분쟁처리 책임자 및 담당자에 대하여 전자금융거래 서비스 이용과 관련한 의견 및 불만의 제기, 손해배상의 청구 등의 분쟁처리를 요구할 수 있습니다.
                - 담당자: PG사업본부 강창완 차장
                - 전화번호 : 02-3416-2644
                - 전자우편주소 : easypay_op@kicc.co.kr
                이용자가 회사에 대하여 분쟁처리를 신청한 경우에는 회사는 15일 이내에 이에 대한 조사 또는 처리 결과를 이 용자에게 안내합니다.
                이용자는 '금융감독기구의 설치 등에 관한 법률' 제51조의 규정에 따른 금융감독원의 금융분쟁조정위원회나 '소비자보호법' 제31조 제1항의 규정에 따른 소비자보호원에 회사의 전자금융거래 서비스의 이용과 관련한 분쟁조정을 신청할 수 있습니다.
                제16조 (회사의 안정성 확보 의무)
                회사는 전자금융거래의 안전성과 신뢰성을 확보할 수 있도록 전자금융거래의 종류별로 전자적 전송이나 처리를 위한 인력, 시설, 전자적 장치 등의 정보기술부문 및 전자금융업무에 관하여 금융감독위원회가 정하는 기준을 준수합니다.
                
                제17조 (약관 외 준칙 및 관할)
                이 약관에서 정하지 아니한 사항에 대하여는 전자금융거래법, 전자상거래 등에서의 소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.
                회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.</span>
                
        </div>
        <p  class="pay" style="margin: 50px 0 0 70px; font-weight: 700;">개인정보 수집 및 이용 동의 &nbsp;&nbsp;<button style="border: none; background: 0;" id="btn2">보기</button></p>
        <div class="terms" id="div2">
            <span>
                [개인정보 수집 및 이용 동의]

                "주식회사 한국사이버결제" (이하 "회사")는 이용자의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호에 관한 법률" 및 “개인정보보호법”과 “전자상거래 등에서의 소비자 보호에 관한 법률”을 준수하고 있습니다. 회사는 전자지급결제대행서비스 및 결제대금예치서비스(이하 "서비스") 이용자로부터 아래와 같이 개인정보를 수집 및 이용합니다.

                1.(개인정보의 수집 및 이용목적)
                회사는 다음과 같은 목적 하에 “서비스”와 관련한 개인정보를 수집합니다.

                서비스 제공 계약의 성립, 유지, 종료를 위한 본인 식별 및 실명확인, 각종 회원관리
                서비스 제공 과정 중 본인 식별, 인증, 실명확인 및 회원에 대한 각종 안내/고지
                대금 환불, 상품배송 등 전자상거래 관련 서비스 제공
                서비스 제공 및 관련 업무처리에 필요한 동의 또는 철회 등 의사확인
                이용 빈도 파악 및 인구통계학적 특성에 따른 서비스 제공 및 CRM
                기타 회사가 제공하는 이벤트 등 광고성 정보 전달, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 실제 마케팅 활동
                현금영수증 발행 및 관리 등
                2.(수집하는 개인정보 항목)
                가.결제수단별 회사가 수집하는 개인정보의 항목은 다음과 같습니다. (신용카드) 카드번호(3rd-마스킹), 승인시간, 승인번호, 승인금액 등
                나.상기 명시된 개인정보 항목 이외의 “서비스” 이용과정이나 “서비스” 처리 과정에서 다음과 같은 추가 정보들이 자동 혹은 수동으로 생성되어 수집 될 수 있습니다.
                -이용자 IP/Mac Address, 쿠키, e-mail, 서비스 접속 일시, 서비스 이용기록, 불량 혹은 비정상 이용기록, 결제기록
                다.기타, 회사는 서비스 이용과 관련한 대금결제, 물품배송 및 환불 등에 필요한 정보를 추가로 수집할 수 있습니다.
                3.(개인정보의 보유 및 이용기간)
                이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존 합니다.

                가.회사 내부 방침의 의한 정보보유
                -보존항목: 서비스 상담 수집 항목(회사명, 고객명, 전화번호, E-mail, 상담내용 등)
                -보존이유: 분쟁이 발생 할 경우 소명자료 활용
                -보존기간: 상담 완료 후 6개월
                나.관련법령에 의한 정보보유
                상법, 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법 등 관련법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관련법령에서 정한 일정한 기간 동안 정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다.

                계약 또는 청약철회 등에 관한 기록
                보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
                계약 또는 청약철회 등에 관한 기록
                보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
                대금결제 및 재화 등의 공급에 관한 기록
                보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
                (단, 건당 거래 금액이 1만원 이하의 경우에는 1년간 보존 합니다.)
                -소비자의 불만 또는 분쟁처리에 관한 기록
                보존기간: 3년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률
                신용정보의 수집/처리 및 이용 등에 관한 기록
                보존기간: 3년 / 보존근거: 신용정보의 이용 및 보호에 관한 법률
                본인확인에 관한 기록
                보존기간: 6개월 / 보존근거: 정보통신 이용촉진 및 정보보호 등에 관한 법률
                방문에 관한 기록
                보존기간: 3개월 / 보존근거: 통신비밀보호법
                현금영수증 결제내역에 관한 기록
                보존기간: 1년 / 보존근거: 조세특례제한법
                4.(이용자의 개인정보의 수집 및 이용 거부)
                이용자는 회사의 개인정보 수집 및 이용 동의를 거부할 수 있습니다. 단, 동의를 거부 하는 경우 서비스 결제가 정상적으로 완료 될 수 없음을 알려 드립니다.
                [개인정보의 수집 및 이용에 대한 동의]
                “한국정보통신주식회사”(이하 “회사”)는 이용자의 개인정보를 중요시하며, "정보통신망 이용촉진 및 정보보호에 관한 법률" 및 “개인정보보호법”과 “전자상거래 등에서의 소비자 보호에 관한 법률”을 준수하고 있습니다. 회사는 전자지급결제대행서비스 및 결제대금예치서비스(이하 “서비스”) 이용자로부터 아래와 같이 개인정보를 수집 및 이용합니다.

                1. 개인정보의 수집 및 이용목적
                회사는 다음과 같은 목적 하에 “서비스”와 관련한 개인정보를 수집합니다.
                - 서비스 제공 계약의 성립, 유지, 종료를 위한 본인 식별 및 실명확인, 각종 회원관리

                - 서비스 제공 과정 중 본인 식별, 인증, 실명확인 및 회원에 대한 각종 안내/고지

                - 대금 환불, 상품배송 등 전자상거래 관련 서비스 제공

                - 서비스 제공 및 관련 업무처리에 필요한 동의 또는 철회 등 의사확인

                - 사고조사, 분쟁해결, 민원처리

                - 이용 빈도 파악 및 인구통계학적 특성에 따른 서비스 제공 및 CRM

                - 기타 회사가 제공하는 이벤트 등 광고성 정보 전달, 통계학적 특성에 따른 서비스 제공 및 광고 게재, 실제 마케팅 활동

                2. 수집하는 개인정보 항목
                가. 결제수단별 회사가 수집하는 개인정보의 항목은 다음과 같습니다
                (신용카드) 카드사명, 카드번호(3rd-마스킹), 승인시간, 승인번호, 승인금액, IP, 고유식별번호 일부(외국인등록번호) 등

                나. 상기 명시된 개인정보 항목 이외의 “서비스” 이용과정이나 “서비스” 처리 과정에서 다음과 같은 추가 정보들이 자동 혹은 수동으로 생성되어 수집 될 수 있습니다.
                - 이용자 IP/Mac Address, 쿠키, e-mail, 서비스 접속 일시, 서비스 이용기록, 불량 혹은 비정상 이용기록, 결제기록

                다. 기타, 회사는 서비스 이용과 관련한 대금결제, 물품배송 및 환불 등에 필요한 정보를 추가로 수집할 수 있습니다.
                3. 개인정보의 보유 및 이용기간
                이용자의 개인정보는 원칙적으로 개인정보의 수집 및 이용목적이 달성되면 지체 없이 파기 합니다. 단, 다음의 정보에 대해서는 아래의 이유로 명시한 기간 동안 보존 합니다.

                가. 회사 내부 방침의 의한 정보보유
                - 보존항목: 서비스 상담 수집 항목(회사명, 고객명, 전화번호, E-mail, 상담내용 등)

                - 보존이유: 분쟁이 발생 할 경우 소명자료 활용

                - 보존기간: 상담 완료 후 6개월

                나. 관련법령에 의한 정보보유
                상법, 전자상거래 등에서의 소비자보호에 관한 법률, 전자금융거래법 등 관련법령의 규정에 의하여 보존할 필요가 있는 경우 회사는 관련법령에서 정한 일정한 기간 동안 정보를 보관합니다. 이 경우 회사는 보관하는 정보를 그 보관의 목적으로만 이용하며 보존기간은 아래와 같습니다. - 계약 또는 청약철회 등에 관한 기록 보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률

                - 대금결제 및 재화 등의 공급에 관한 기록 보존기간: 5년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률 (단, 건당 거래 금액이 1만원 이하의 경우에는 1년간 보존 합니다).

                - 소비자의 불만 또는 분쟁처리에 관한 기록 보존기간: 3년 / 보존근거: 전자상거래 등에서의 소비자보호에 관한 법률

                - 신용정보의 수집/처리 및 이용 등에 관한 기록 보존기간: 3년 / 보존근거: 신용정보의 이용 및 보호에 관한 법률

                - 본인확인에 관한 기록 보존기간: 6개월 / 보존근거: 정보통신 이용촉진 및 정보보호 등에 관한 법률

                - 방문에 관한 기록 보존기간: 3개월 / 보존근거: 통신비밀보호법

                4. 이용자의 개인정보의 수집 및 이용 거부
                이용자는 회사의 개인정보 수집 및 이용 동의를 거부할 수 있습니다. 단, 동의를 거부 하는 경우 서비스 결제가 정상적으로 완료 될 수 없음을 알려 드립니다.소비자 보호에 관한 법률, 통신판매에 관한 법률, 여신전문금융업법 등 소비자보호 관련 법령에서 정한 바에 따릅니다.
                회사와 이용자간에 발생한 분쟁에 관한 관할은 민사소송법에서 정한 바에 따릅니다.</span>
                
        </div> 
        <p style="margin: 50px 0 0 0; font-weight: 700;">위 내용을 확인하였으며, 회원 본인은 결제에 동의합니다.</p>
        <p style="margin: 30px 0 0 140px; font-weight: 700;">동의하기 <input type="checkbox" id="check"></p>
    </div>
    <div style="margin: 80px 0 50px 800px;">
        <button class="payment">결제하기</button>
    </div>   
    
    <script>
	    $("#btn1").click(function(){
	        $("#div1").toggle();
	    });
	    $("#btn2").click(function(){
	        $("#div2").toggle();
	    });
	    
	    $('.payment').click(function(){
	    	
	    	if($('#check').is(':checked')){

	    		let name = "${ requestScope.ownerInfo.ceo.store.storeName }";
	      		let phone = "${ requestScope.ownerInfo.phone }";
	      		let totalPrice = "${ requestScope.membership.msPrice }";
	      		let msCode = "${ requestScope.membership.msCode }";
	      		let msDate = "${ requestScope.membership.msDate }";
	      		var IMP = window.IMP; 
	      	    IMP.init('imp43692691'); 
	      	    IMP.request_pay({
	      	    	pg : 'kakaopay',
	      	        pay_method : 'card', //생략 가능
	      	        merchant_uid: "${ requestScope.orderCode }" + 4, // 상점에서 관리하는 주문 번호 db에서 가져와야함
	      	        name : "${ requestScope.membership.msType }", // 상품명
	      	        amount : totalPrice, 
	      	        buyer_email : "${ requestScope.ownerInfo.email }",
	      	        buyer_name : name,
	      	        buyer_tel : phone,
	      	        buyer_addr : "${ requestScope.ownerInfo.address }",
	      	        buyer_postcode : "${ requestScope.ownerInfo.postCode }",
	      	       /*  m_redirect_url : '{ ${ pageContext.servletContext.contextPath }/owner/kakaoPay?msCode=${ requestScope.membership.msCode }&msDate=${ requestScope.membership.msDate } }' */
	      	    },  function(rsp) { 
	      	    	
	      	    	if( rsp.success ){
		      	    	
	      	    		location.href = ' ${ pageContext.servletContext.contextPath }/owner/kakaoPay?msCode=${ requestScope.membership.msCode }&msDate=${ requestScope.membership.msDate } ';
	      	    		
		      	    	} else {
	      	    		//결제 시작 페이지로 리디렉션되기 전에 오류가 난 경우
		      	        var msg = '오류로 인하여 결제가 시작되지 못하였습니다.';
		      	        msg += '에러내용 : ' + rsp.error_msg;

		      	        alert(msg);
	      	    	}
	      	    	
	      		});
	    		
	    	} else {
	    		alert("약관 동의를 하지 않았습니다.")
	    	}
	    }); 
	    
    </script>
    
     <!-- footer -->
  <jsp:include page="../commons/footer.jsp"/>
	
</body>
</html>