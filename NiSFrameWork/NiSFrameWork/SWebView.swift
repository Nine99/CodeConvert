//
//  SWebView.swift
//  SMobile
//
//  Created by 60029566 on 2019. 2. 11..
//  Copyright © 2019년 Shinhan DS. All rights reserved.
//

import Foundation
import WebKit
import NiSLib

let HYBRID_SCHEME = "sframe"      // S-Frame 2.0
//let HYBRID_SCHEME = "sdshybrid"     // SDSFramework 1.0
let HYBRID_FUNC_NAME = "shinhansys"
let HYBRID_PATH_REQUEST = "request"
let HYBRID_PATH_PLUGIN = "plugin"
let CALLBACK_PLUGIN_JS = "SFrame.plugin.callBack(%@, '%@', %@)"
let INIT_SCRIPT_SAMPLE = "initScript()"

public typealias SCallBack = (Bool, [String : Any]?) -> Void

/**
 * WKWebView 상속 클래스
 * 플러그인, 쿠키 저장, JS팝업 등 처리 추가
 */
open class SWebView: WKWebView, WKUIDelegate, WKNavigationDelegate, WKScriptMessageHandler, UIScrollViewDelegate, WKHTTPCookieStoreObserver {
    
    var vc: UIViewController?               // SWebView를 포함하고 있는 부모 뷰컨트롤러
    
    //    var hybridPlugins: Dictionary<String, Any> = [:]
    var hybridPlugins: Dictionary<String, NSObject> = [:] // 하이브리드 플러그인 목록
    
    public var sUiDelegate: WKUIDelegate?   //WKUIDelegate 메소드를 별도로 사용하고자 하는 경우 설정
    public var sNavigationDelegate: WKNavigationDelegate?   // WKNavigationDelegate 메소드를 별도로 사용하고자 하는 경우 설정
    static public var configuaration: WKWebViewConfiguration?  = WKWebViewConfiguration()  // 전역 WKWebViewConfiguration
    static public var processPool: WKProcessPool? = WKProcessPool()  // 전역 WKProcessPool
    
    // MARK: initialize
    public init(vc: UIViewController) {
        // by Nine99 : SUtil.log()
        let contentController = WKUserContentController()
        let userScript = WKUserScript(source: INIT_SCRIPT_SAMPLE, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        let configuration = WKWebViewConfiguration()
        configuration.userContentController = contentController
        if #available(iOS 11.0, *), SConfig.shared.isWebViewCookieEnabled {
            let cookies = HTTPCookieStorage.shared.cookies ?? []
            for (cookie) in cookies {
                configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }

        super.init(frame: .zero, configuration: configuration)
        
        contentController.add(self, name: HYBRID_SCHEME)
        
        self.vc = vc

        // iOS 10 이하인 경우 쿠키 저장 로직
        if SConfig.shared.isWebViewCookieEnabled {
            addCookieInScript(contentController)
            addCookieOutScript(contentController)
        }
        
        doInit()
    }
    
    public init(vc: UIViewController, initScript: String, callbackScript: String) {
        // by Nine99 : SUtil.log()
        let contentController = WKUserContentController()
        let configuration = WKWebViewConfiguration()

        configuration.userContentController = contentController
        let userScript = WKUserScript(source: INIT_SCRIPT_SAMPLE, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
        if #available(iOS 11.0, *), SConfig.shared.isWebViewCookieEnabled {
            
            let cookies = HTTPCookieStorage.shared.cookies ?? []
            for (cookie) in cookies {
                configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }
        
        super.init(frame: .zero, configuration: configuration)
        self.vc = vc
        
        contentController.add(self, name: HYBRID_SCHEME)
        
        if SConfig.shared.isWebViewCookieEnabled {
            addCookieInScript(contentController)
            addCookieOutScript(contentController)
        }
        
        doInit()
    }
    
    public override init(frame: CGRect, configuration: WKWebViewConfiguration) {
        // by Nine99 : SUtil.log()
        let contentController = WKUserContentController()
        let userScript = WKUserScript(source: INIT_SCRIPT_SAMPLE, injectionTime: .atDocumentEnd, forMainFrameOnly: true)
        contentController.addUserScript(userScript)
        
//        let configuration = WKWebViewConfiguration()
        
        configuration.userContentController = contentController
        if #available(iOS 11.0, *), SConfig.shared.isWebViewCookieEnabled {
            let cookies = HTTPCookieStorage.shared.cookies ?? []
            for (cookie) in cookies {
                configuration.websiteDataStore.httpCookieStore.setCookie(cookie)
            }
        }

        super.init(frame: frame, configuration: configuration)
        contentController.add(self, name: HYBRID_SCHEME)

        doInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        // by Nine99 : SUtil.log()
        super.init(coder: aDecoder)
        doInit()
    }
    
    // MARK: delegate 설정 등 초기화
    public func doInit() {
        // by Nine99 : SUtil.log()
        super.uiDelegate = self
        super.navigationDelegate = self
        self.allowsBackForwardNavigationGestures = true
        self.scrollView.delegate = self
    }
    
    // MARK: WKWebView에 쿠키 적용
    @discardableResult
    override open func load(_ request: URLRequest) -> WKNavigation? {
        // by Nine99 : SUtil.log()
        if #available(iOS 11.0, *) {
            return super.load(request)
        } else {
            if SConfig.shared.isWebViewCookieEnabled {
                // iOS 10 이하인 경우 쿠키 저장 로직
                var aRequest = URLRequest(url: request.url!)
                let cookies = HTTPCookie.requestHeaderFields(with: HTTPCookieStorage.shared.cookies(for: aRequest.url!)!)
                if let value = cookies["Cookie"] { aRequest.addValue(value, forHTTPHeaderField: "Cookie") }
                
                /* https만 쿠키 저장
                var aRequest = URLRequest(url: request.url!)
                let validDomain = aRequest.url?.host
                let requestIsSecure: Bool = aRequest.url?.scheme == "https"
                
                var array: [String] = []
                for cookie in HTTPCookieStorage.shared.cookies ?? [] {
                    if (cookie.name as NSString).range(of: "'").location != NSNotFound {
                        continue
                    }
                    
                    if !(cookie.domain.hasSuffix(validDomain ?? "")) {
                        continue
                    }
                    
                    if cookie.isSecure && !requestIsSecure {
                        continue
                    }
                    
                    let value = "\(cookie.name)=\(cookie.value)"
                    array.append(value)
                }
                
                let header = array.joined(separator: ";")
                aRequest.setValue(header, forHTTPHeaderField: "Cookie")
                
                return super.load(aRequest)
                */
                
                return super.load(aRequest)
                
            } else {
                return super.load(request)
            }
        }
    }
    
    // MARK: SMobile Framework 구현부
    @objc public func addPlugin(plugin: NSObject?, forKey: String) {
        // by Nine99 : SUtil.log()
        hybridPlugins[forKey] = plugin
    }
    
    func parseSchemeData(_ queryString: String?) -> [String : Any]? {
        var paramsDic: [String : Any] = [:]
        
        if queryString != nil {
            let splitList = queryString?.components(separatedBy: "&")
            
            (splitList as NSArray?)?.enumerateObjects({ obj, idx, stop in
                let row = obj as? String
                let rowSplit = row?.components(separatedBy: "=")
                
                if rowSplit?.count == 2 {
                    let key = rowSplit?[0]
                    let value = rowSplit?[1]
                    
                    if (key == "params") {
                        let jsonParams = dictionaryForString(value)
                        paramsDic[key!] = jsonParams
                    } else {
                        paramsDic[key!] = value
                    }
                }
            })
        }
        
        return paramsDic
    }
    
    func executePlugIn(_ params: Dictionary<String, Any>) {
        guard let pluginId = params["pluginId"] as? String,
            let method = params["method"] as? String
        else {
//            SUtil.log("parameter invalid", level:.ERROR)
//            SUtil.log("params", params)
            NiSLogger.Instance().Log(format: "parameter invalid")
            NiSLogger.Instance().Log(format: "params", params)
            return
        }

        let callBackKey = params["callBackKey"] as? String
        var subParams: [String : Any]? = nil

        let param = params["params"]
        if (param is String) {
            let jsonData: Data? = (param as? String)?.data(using: .utf8)
            let error: Error? = nil
            if let jsonData = jsonData {
                //subParams = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any]
                subParams = try! JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers) as? [String : Any]
            }
            if error != nil {
                //SUtil.log(String(describing: error))
                NiSLogger.Instance().Log(String(describing: error))
            }
        } else if (param is [String : Any]) {
            subParams = param as? [String : Any]
        } else {
            //SUtil.log(param as? CVarArg ?? "")
            NiSLogger.Instance().Log(param.debugDescription)
        }
        
        if hybridPlugins[pluginId] == nil {
            guard let pluginClass = SConfig.shared.pluginClassWithId(pluginId: pluginId) as? NSObject.Type else {
                //SUtil.log(" >>>>>>>>> 플러그인을 찾을 수 없습니다. 플러그인 ID :", pluginId, level:.ERROR)
                NiSLogger.Instance().Log(format: " >>>>>>>>> 플러그인을 찾을 수 없습니다. 플러그인 ID :", pluginId)
                return
            }
            hybridPlugins[pluginId] = pluginClass.init()
        }
        
        let plugin = hybridPlugins[pluginId]!
        
        let name = "\(method)WithParams:with:"
        //SUtil.log("[\(SUtil.getClassName(plugin)) \(name)]", level:.INFO)
        NiSLogger.Instance().Log("[\(NiSLib.GetClassName(plugin)) \(name)]")
        let selMethod = NSSelectorFromString(name)

//        if self.responds(to: selMethod) {
            if let params = subParams {
                plugin.perform(selMethod, with: params) { (isOK:Bool, result:[String:Any]?) in
                    var jsonString = ""
                    var isOk = isOK

                    var jsonData: Data? = nil
                    if let result = result {
                        jsonData = try? JSONSerialization.data(withJSONObject: result, options: [])
                    }
                    if let jsonData = jsonData {
                        jsonString = String(data: jsonData, encoding: .utf8) ?? ""
                    }

                    if jsonString.count <= 0 {
                        isOk = false
                    }

                    let callBack = String(format: CALLBACK_PLUGIN_JS, isOk ? "true" : "false", callBackKey ?? "", jsonString)
                    // let callBack = String(format: CALLBACK_PLUGIN_JS, isOk ? "true" : "false", pluginId ?? "", method ?? "", jsonString)

                    DispatchQueue.main.async {
                        self.evaluateJavaScript(callBack, completionHandler: { object, error in
                            if error != nil {
                                // by Nine99 : SUtil.log(String(describing: error))
                                NiSLogger.Instance().Log(String(describing: error))
                            }
                        })
                    }
                }
            }
//        } else {
//            SUtil.log(" >>>>>>>>> 플러그인 함수가 존재 하지 않습니다. [\(SUtil.getClassName(plugin)) \(name)]", level:.ERROR)
//        }
    }
    
    func dictionaryForString(_ value: String?) -> [String : Any]? {
        // by Nine99 : SUtil.log()
        if (value?.count ?? 0) < 1 {
            return [:]
        }
        let jsonData: Data? = value?.removingPercentEncoding?.data(using: .utf8)
        var result: Any? = nil
        if let jsonData = jsonData {
            result = try? JSONSerialization.jsonObject(with: jsonData, options: .mutableContainers)
            return result as? [String : Any]
        } else {
            return nil
        }
    }
    
    func isLoadingBar(_ params: [String : Any]?) -> Bool {
        // by Nine99 : SUtil.log()
        let isLoadingBar = params?["isLoadingBar"] as? String
        var isBar = false
        if isLoadingBar != nil && (isLoadingBar == "true") {
            isBar = true
        }
        return isBar
    }
    
    // MARK: WKUIDelegate
    public func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
        // by Nine99 : SUtil.log()
        
        return sUiDelegate?.webView?(webView, createWebViewWith: configuration, for: navigationAction, windowFeatures: windowFeatures)
    }
    
    @available(iOS 9.0, *)
    public func webViewDidClose(_ webView: WKWebView) {
        // by Nine99 : SUtil.log()
        
        sUiDelegate?.webViewDidClose?(webView)
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptAlertPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping () -> Void) {
        // by Nine99 : SUtil.log()
        
        guard let method = sUiDelegate?.webView?(webView, runJavaScriptAlertPanelWithMessage: message, initiatedByFrame: frame, completionHandler: completionHandler) else {
            // sUiDelegate에서 딜리게이트 메소드 정의가 없을 경우 기본 팝업 호출
            // by Nine99 : SAlert
//            SAlert.shared.show(title: "알림", message: message, buttons: ["확인"]) { (index) in
//                SUtil.log(index)
//                completionHandler()
//            }
            return
        }
        
        return method
    }
    
    public func webView(_ webView: WKWebView, runJavaScriptConfirmPanelWithMessage message: String, initiatedByFrame frame: WKFrameInfo, completionHandler: @escaping (Bool) -> Void) {
        // by Nine99 : SUtil.log()
        
        guard let method = sUiDelegate?.webView?(webView, runJavaScriptConfirmPanelWithMessage: message, initiatedByFrame: frame, completionHandler: completionHandler) else {
            // sUiDelegate에서 딜리게이트 메소드 정의가 없을 경우 기본 팝업 호출
            // by Nine99 : SAlert
//            SAlert.shared.show(title: "알림", message: message, buttons: ["취소", "확인"]) { (index) in
//                SUtil.log(index)
//                return completionHandler(index == 0 ? false : true)
//            }
            return
        }
        
        return method
    }

    // MARK: WKNavigationDelegate
    public func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didStartProvisionalNavigation: navigation)
        // by Nine99 : SLoadingBar
        NiSLoadingBar.Instance().show()
    }
    
    public func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didCommit: navigation)
    }
    
    public func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didFinish: navigation)
        // by Nine99 : SLoadingBar
        NiSLoadingBar.Instance().hide()
        
        // 통신이후 웹뷰에 바뀐 쿠키값을 쿠키스토리지에 적용
        if #available(iOS 11.0, *) {
            SWebView.configuaration?.websiteDataStore.httpCookieStore.getAllCookies({ (cookies) in
                for cookie in cookies {
                    let value = "\(cookie.name)=\(cookie.value)"
                    let jar = HTTPCookieStorage.shared
                    let _url = webView.url
                    let cookieHeaderField = ["Set-Cookie" : value]
                    let cookies = HTTPCookie.cookies(withResponseHeaderFields: cookieHeaderField, for: _url!)
                    jar.setCookies(cookies, for: _url, mainDocumentURL: _url)
                }
            })
        }
    }
    
    public func webView(_ webView: WKWebView, didReceiveServerRedirectForProvisionalNavigation navigation: WKNavigation!) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didReceiveServerRedirectForProvisionalNavigation: navigation)
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        // by Nine99 : SUtil.log()
        let targetUrl = navigationAction.request.url
        if let scheme = targetUrl?.scheme,
            scheme == HYBRID_SCHEME {
            
            if let function = targetUrl?.host,
                function == HYBRID_PATH_PLUGIN,
                let query = targetUrl?.query,
                let params = parseSchemeData(query) {
                
                // 플러그인 실행
                executePlugIn(params)
            }
            
            return decisionHandler(.cancel)
        }
        else {
            guard let method = sNavigationDelegate?.webView?(webView, decidePolicyFor: navigationAction, decisionHandler: decisionHandler) else {
                return decisionHandler(.allow)
            }
            return method
        }
    }
    
    public func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        // by Nine99 : SUtil.log()
        guard let method = sNavigationDelegate?.webView?(webView, decidePolicyFor: navigationResponse, decisionHandler: decisionHandler) else {
            return decisionHandler(.allow)
        }
        return method
    }
    
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        // by Nine99 : SUtil.log()
        
        guard let method = sNavigationDelegate?.webView?(webView, didReceive: challenge, completionHandler: completionHandler) else {
            return completionHandler(.performDefaultHandling, nil)
        }
        
        return method
    }
    
    public func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didFailProvisionalNavigation: navigation, withError: error)
        
        // by Nine99 : SLoadingBar
        NiSLoadingBar.Instance().hide()
    }
    
    public func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        // by Nine99 : SUtil.log()
        sNavigationDelegate?.webView?(webView, didFail: navigation, withError: error)
        
        // by Nine99 : SLoadingBar
        NiSLoadingBar.Instance().hide()
    }
    
    @available(iOS 9.0, *)
    public func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        // by Nine99 : SUtil.log()
        
        sNavigationDelegate?.webViewWebContentProcessDidTerminate?(webView)
    }
    
    // MARK: WKScriptMessageHandler
    public func userContentController(_ userContentController: WKUserContentController, didReceive message: WKScriptMessage) {
        // by Nine99 : SUtil.log(message)
        NiSLogger.Instance().Log(message.debugDescription)
        if SConfig.shared.isWebViewCookieEnabled {
            let cookies = (message.body as AnyObject).components(separatedBy: "; ")
            for cookie in cookies {
                let comps = cookie.components(separatedBy: "=")
                if comps.count < 2 {
                    continue
                }

                var localCookie: HTTPCookie? = nil
                for c in HTTPCookieStorage.shared.cookies(for: self.url!) ?? [] {
                    if (c.name == comps[0]) {
                        localCookie = c
                        break
                    }
                }

                if localCookie != nil {
                    var props = localCookie?.properties
                    props?[HTTPCookiePropertyKey.value] = comps[1]
                    var updatedCookie: HTTPCookie? = nil
                    if let props = props {
                        updatedCookie = HTTPCookie(properties: props)
                    }
                    if let updatedCookie = updatedCookie {
                        HTTPCookieStorage.shared.setCookie(updatedCookie)
                    }
                }
            }
        }

        //* 현재 미사용
        if message.name == HYBRID_FUNC_NAME {
            let param = message.body as? Dictionary<String, Any>
            
            guard let paramDic = param else { return }

            if paramDic["function"] as? String == HYBRID_PATH_PLUGIN {
                // 플러그인 실행
                self.evaluateJavaScript("blueTitle()") { (result, error) in
                    if let error = error {
                        // by Nine99 : SUtil.log(error as CVarArg)
                        NiSLogger.Instance().Log(error.localizedDescription)
                    } else if let result = result {
                        // by Nine99 : SUtil.log(result as! CVarArg)
                        NiSLogger.Instance().Log("\(result)")
                    }
                }
            }
            else if paramDic["function"] as? String == HYBRID_PATH_REQUEST {
                // 네트워크 요청

                // by Nine99 : SNetwork
//                SNetwork.shared.request(url: "", method: "POST", header: nil, body: nil, showLoading: true, successBlock: { (code, resDic) in
//                    // by Nine99 : SUtil.log(resDic)
//                    NiSLogger.GetInstance().Log(resDic)
//                }) { (errorCode, error) in
//                    // by Nine99 : SUtil.log(errorCode, String(describing: error))
//                    NiSLogger.GetInstance().Log(errorCode, String(describing: error))
//                }
            }
        }
        // */
    }
    
    // MARK : contentView와 self(SWebView)를 동일한 크기로 적용
//    @available(iOS 9.0, *)
//    public func constraint(toView contentView: UIView) {
//        self.translatesAutoresizingMaskIntoConstraints = false
//        self.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
//        self.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
//        self.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
//        self.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
//    }
    
/*
    /// Handle SSL connections by default. We aren't doing SSL pinning or custom certificate handling.
    public func webView(_ webView: WKWebView, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        SUtil.log("didReceive challenge")
        
        let whiteStaticList = ["www.google.nl", "www.yahoo.com"]
        let whiteList = whiteStaticList.filter { challenge.protectionSpace.host.hasPrefix($0) }
        if whiteList.count > 0 {
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:challenge.protectionSpace.serverTrust!))
            return
        }
        
        /**
         * We started listening to this delegate method to avoid of `SSL Pinning`
         * and `man-in-the-middle` attacks. Is required have certificate in
         * local project e.g. `example.com.der`
         */
        if (challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust) {
            if let serverTrust = challenge.protectionSpace.serverTrust {
                var secresult = SecTrustResultType.invalid
                let status = SecTrustEvaluate(serverTrust, &secresult)
                if(errSecSuccess == status) {
                    if let serverCertificate = SecTrustGetCertificateAtIndex(serverTrust, 0) {
                        let serverCertificateData = SecCertificateCopyData(serverCertificate)
                        let data = CFDataGetBytePtr(serverCertificateData);
                        let size = CFDataGetLength(serverCertificateData);
                        let cert1 = NSData(bytes: data, length: size)
                        let file_der = Bundle.main.path(forResource: "example.com", ofType: "der")
                        
                        if let file = file_der {
                            if let cert2 = NSData(contentsOfFile: file) {
                                if cert1.isEqual(to: cert2 as Data) {
                                    completionHandler(URLSession.AuthChallengeDisposition.useCredential, URLCredential(trust:serverTrust))
                                    return
                                }
                            }
                        }
                    }
                }
            }
        }
        //Pinning failed
        completionHandler(URLSession.AuthChallengeDisposition.cancelAuthenticationChallenge, nil)
    }
*/
    
    /*
    // Disables zooming
    func viewForZoomingInScrollView(scrollView: UIScrollView) -> UIView? {
        return nil
    }
     */
    
    // MARK: 쿠키 저장 관련
    func addCookieInScript(_ contentController: WKUserContentController) {
        // by Nine99 : SUtil.log()
        var script = "var cookieNames = document.cookie.split('; ').map(function(cookie) { return cookie.split('=')[0] } );\n"
        for cookie in HTTPCookieStorage.shared.cookies ?? [] {
            if (cookie.value as NSString).range(of: "'").location != NSNotFound {
                continue
            }
            script += "if (cookieNames.indexOf('\(cookie.name)') == -1) { document.cookie='\(javascriptString(with: cookie))'; };\n"
        }
        let cookieInScript = WKUserScript(source: script, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(cookieInScript)
    }
    
    func addCookieOutScript(_ contentController: WKUserContentController) {
        // by Nine99 : SUtil.log()
        let cookieOutScript = WKUserScript(source: "window.webkit.messageHandlers.updateCookies.postMessage(document.cookie);", injectionTime: .atDocumentStart, forMainFrameOnly: false)
        contentController.addUserScript(cookieOutScript)
        contentController.add(self, name: "updateCookies")
        contentController.add(self, name: HYBRID_FUNC_NAME)
    }
    
    func javascriptString(with cookie: HTTPCookie?) -> String {
        // by Nine99 : SUtil.log()
        var string = "\(cookie?.name ?? "")=\(cookie?.value ?? "");domain=\(cookie?.domain ?? "");path=\(cookie?.path ?? "/")"
        if cookie?.isSecure ?? false {
            string = string + (";secure=true")
        }
        
        return string
    }
}
