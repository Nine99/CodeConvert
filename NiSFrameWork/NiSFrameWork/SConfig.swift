//
//  SConfig.swift
//  SMobile
//
//  Created by 60029566 on 2019. 2. 21..
//  Copyright © 2019년 Shinhan DS. All rights reserved.
//

import Foundation
import WebKit

/**
 * 프레임워크 환경설정 클래스
 * 플러그인 클래스, 커스텀 팝업 클래스 등 연계 처리
 */

public class SConfig: NSObject {
    @objc static let shared = {
        return SConfig()
    }()
    @objc public static func Instance() -> SConfig {
        return shared
    }
    
    // MARK: 네트워크 관련 설정
    @objc public var baseUrl = ""                        // 기본 url
    @objc public var serverList = [String: String]()     // 서버 목록 (사용자 정의 타입)
    @objc public var requestTimeout = 10.0               // 네트워크 요청 타임아웃 (기본 10초)
    @objc public var successStatusCode = 200             // 네트워크 정상응답코드 (기본 200. 서버 정상응답코드가 200이 아닌 경우에만 예외적으로 바꿔야함)
    @objc public var isNetworkLoading = true             // 프레임워크 네트워크 로딩 표시 여부 (해당 플래그를 false로 할 경우 개별 request의 showLoading 플래그 값 무시)
    @objc public var isImageCacheEnabled = true          // 이미지 캐시 기능 사용 여부 (기본 true)
    @objc public var isFileCacheEnabled = false          // 파일 캐시 기능 사용 여부 (기본 false)
    @objc public var isCodeguardErrorCheck = true        // 코드가드 에러 발생 시의 XML 파싱 기능 사용 여부 (기본 false, 코드가드 에러응답 대응이 필요할 경우 true)
    @objc public var isNetworkLogRecord = false          // 전문요청 로그파일 저장 여부 (기본 false)
    @objc public var isAllowsAnyHTTPSCertificate = false // 사설 인증서 허용여부 (모의해킹 테스트 시 허용)
    
    // MARK: 웹뷰 관련 설정
    @objc public var isWebViewCookieEnabled = true                          // SWebView 쿠키 저장 허용 여부 (기본 true)
    @objc public var userPluginClasses = [String: AnyClass]()               // 플러그인 클래스 목록
    @objc public var wkUserContentController = WKUserContentController()    // SWebView WKUserContentController
    @objc public var wkProcessPool = WKProcessPool()                        // SWebView 쿠키 WKProcessPool
    @objc public var wkPreferences = WKPreferences()                        // SWebView 쿠키 WKPreferences
    
    // MARK: 팝업 관련 설정
    public var alertClass: NiSAlertControl.Type?        // 커스텀 팝업 클래스 (등록된 커스텀 팝업이 없을 경우 기본 팝업 호출)
    
    // MARK: 로그 관련 설정
    @objc public var isLog = true                     // 프레임워크 로그 출력 여부
    // by Nine99 : @objc public var logLevel: SLogLevel = .DEBUG      // 프레임워크 로그 레벨
    
    // MARK: 플러그인 클래스 추가
    @objc public func addPlugin(pluginClass: AnyClass, pluginId: String) {
        self.userPluginClasses[pluginId] = pluginClass
    }
    
    // MARK: 등록된 플러그인 클래스 호출
    @objc public func pluginClassWithId(pluginId: String) -> AnyClass? {
        if let pluginClass = self.userPluginClasses[pluginId] {
            return pluginClass
        }
        else {
            return nil
        }
    }
    
}
