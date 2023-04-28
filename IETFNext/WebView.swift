//
//  WebView.swift
//  IETFNext
//
//  Created by Tom Pusateri on 11/29/22.
//

import SwiftUI
import WebKit

#if os(macOS)
struct WebView: NSViewRepresentable {
    @Binding var download: Download?
    @Binding var localFileURL: URL?

    @State var html: String = ""

    func loadDownloadFile(from:Download) {
        if let mimeType = from.mimeType {
            if mimeType == "application/pdf" {
                if let filename = from.filename {
                    do {
                        let documentsURL = try FileManager.default.url(for: .documentDirectory,
                                                                       in: .userDomainMask,
                                                                       appropriateFor: nil,
                                                                       create: false)
                        html = ""
                        localFileURL = documentsURL.appendingPathComponent(filename)
                    } catch {
                        html = "Error reading pdf file: \(from.filename!)"
                    }
                }
            } else {
                if let contents = contents2Html(from:from) {
                    html = contents
                } else {
                    html = "Error reading \(from.filename!)"
                }
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeNSView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateNSView(_ nsView : WKWebView , context : Context) {
        nsView.navigationDelegate = context.coordinator
        if html.count != 0 {
            nsView.loadHTMLString(html, baseURL: nil)
        } else if let url = localFileURL {
            nsView.loadFileURL(url, allowingReadAccessTo:url)
        }
    }

    class Coordinator : NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            // open all links not described here in Safari
            if (url.host == "datatracker.ietf.org" &&
                    (url.path.starts(with: "/meeting") || url.path.starts(with: "/doc/html/"))) ||
                (url.host == "www.ietf.org") ||
                (url.scheme == "file") ||
                (url.scheme == "about") {
                decisionHandler(.allow)
                return
            }
            NSWorkspace.shared.open(url)
            decisionHandler(.cancel)
        }
    }
}
#else
struct WebView: UIViewRepresentable {
    @Binding var html: String
    @Binding var localFileURL: URL?

    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    func makeUIView(context: Context) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.dataDetectorTypes = [.link]

        return WKWebView(frame: .zero, configuration:webConfiguration)
    }

    func updateUIView(_ uiView : WKWebView , context : Context) {
        uiView.navigationDelegate = context.coordinator
        if html.count != 0 {
            uiView.loadHTMLString(html, baseURL: nil)
        } else if let url = localFileURL {
            uiView.loadFileURL(url, allowingReadAccessTo:url)
        }
    }

    class Coordinator : NSObject, WKNavigationDelegate {
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
            guard let url = navigationAction.request.url else {
                decisionHandler(.allow)
                return
            }

            // open all links not described here in Safari
            if (url.host == "datatracker.ietf.org" &&
                    (url.path.starts(with: "/meeting") || url.path.starts(with: "/doc/html/"))) ||
                // useful for rfc graph display but no way to get back
                //(url.host == "www.rfc-editor.org") && (url.path.starts(with: "/rfc")) ||
                (url.host == "www.ietf.org") ||
                (url.scheme == "file") ||
                (url.scheme == "about") {
                decisionHandler(.allow)
                return
            }
            UIApplication.shared.open(url)
            decisionHandler(.cancel)
        }
    }
}
#endif
