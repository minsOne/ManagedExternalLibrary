//
//  FacebookAdapter.swift
//  ExternalLibrary
//
//  Created by minsone on 2021/04/25.
//

import Foundation
import UIKit

public struct FBShareLinkContent {
    public var contentURL: URL?
    public init() {}
}

public struct FBSharePhotoContent {
    public var image: UIImage
    public var isUserGenerated: Bool
}

public protocol FBSharingDelegate: class {
    func sharerDidCompleteWithResults(results: [String : Any])
    func sharerDidFailWithError(error: Error)
    func sharerDidCancel()
}

public protocol FBShareDialogInterface {
    init(fromViewController: UIViewController, link: FBShareLinkContent, delegate: FBSharingDelegate)
    init(fromViewController: UIViewController, photo: FBSharePhotoContent, delegate: FBSharingDelegate)
    func show() -> Bool
}

public class ExternalLibraryAdapter {
    public static var fbShareDialog: FBShareDialogInterface.Type?
}
