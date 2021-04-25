//
//  FBShareDialogAdapter.swift
//  App
//
//  Created by minsone on 2021/04/25.
//

import Foundation
import FBSDKShareKit
import ExternalLibrary

final class FBShareDialogAdapter: NSObject, FBShareDialogInterface, SharingDelegate {
    var dialog: ShareDialog?
    weak var delegate: FBSharingDelegate?
    
    required init(fromViewController: UIViewController, link: FBShareLinkContent, delegate: FBSharingDelegate) {
        super.init()

        self.delegate = delegate

        let shareContent = ShareLinkContent()
        link.contentURL.map { shareContent.contentURL = $0 }
        self.dialog = ShareDialog(fromViewController: fromViewController,
                                  content: shareContent,
                                  delegate: self)
    }
    
    init(fromViewController: UIViewController, photo: FBSharePhotoContent, delegate: FBSharingDelegate) {
        super.init()
        
        self.delegate = delegate

        let sharePhoto = SharePhoto()
        sharePhoto.image = photo.image
        sharePhoto.isUserGenerated = photo.isUserGenerated
        let content = SharePhotoContent()
        content.photos = [sharePhoto]
        
        self.dialog = ShareDialog(fromViewController: fromViewController,
                                  content: content,
                                  delegate: self)
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
