//
//  ViewController.swift
//  Feature
//
//  Created by minsone on 2021/04/25.
//

import Foundation
import UIKit
import ExternalLibrary

public class ViewController: UIViewController, FBSharingDelegate {
    private var dialog: FBShareDialogInterface?

    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        AppLogService.Firebase.logEvent()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        var shareContent = FBShareLinkContent()
        shareContent.contentURL = URL(string: "https://developers.facebook.com")
        let dialog = ExternalLibraryAdapter.fbShareDialog?.init(fromViewController: self, link: shareContent, delegate: self)
        self.dialog = dialog
        _ = dialog?.show()
    }
    
    public func sharerDidCompleteWithResults(results: [String : Any]) {
        defer { dialog = nil }
        print(#function)
    }
    
    public func sharerDidFailWithError(error: Error) {
        defer { dialog = nil }
        print(#function, error.localizedDescription)
    }
    
    public func sharerDidCancel() {
        defer { dialog = nil }
        print(#function)
    }
}
