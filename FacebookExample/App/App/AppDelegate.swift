//
//  AppDelegate.swift
//  App
//
//  Created by minsone on 2021/04/25.
//

import UIKit
import FBSDKShareKit
import ExternalLibrary
//import FBSDKCoreKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        Settings.appID = "3837547866363547"
//        Settings.displayName = "externalLibraryApp"

        ExternalLibraryAdapter.fbShareDialog = FBShareDialogImpl.self
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

final class FBShareDialogImpl: NSObject, FBShareDialogInterface, SharingDelegate {
    var dialog: ShareDialog?
    weak var delegate: FBSharingDelegate?
    
    required init(fromViewController: UIViewController, link: FBShareLinkContent, delegate: FBSharingDelegate) {
        super.init()

        let shareContent = ShareLinkContent()
        link.contentURL.map { shareContent.contentURL = $0 }
        self.delegate = delegate
        self.dialog = ShareDialog(fromViewController: fromViewController, content: shareContent, delegate: self)
    }
    
    init(fromViewController: UIViewController, photo: FBSharePhotoContent, delegate: FBSharingDelegate) {
        
    }
    
    func show() -> Bool {
        return dialog?.show() ?? false
    }
    
    func sharer(_ sharer: Sharing, didCompleteWithResults results: [String : Any]) {
        delegate?.sharerDidCompleteWithResults(results: results)
    }
    func sharer(_ sharer: Sharing, didFailWithError error: Error) {
        delegate?.sharerDidFailWithError(error: error)
    }
    func sharerDidCancel(_ sharer: Sharing) {
        delegate?.sharerDidCancel()
    }
    
}
