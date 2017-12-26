//
//  DetailViewController.swift
//  Homework5 Server Communication
//
//  Created by Channat Tem on 12/27/17.
//  Copyright © 2017 JANSA. All rights reserved.
//

import UIKit
import Kingfisher
import Photos
class DetailViewController: UIViewController {

    var image: String?
    var descriptionArticle: String?
    var titleArticle: String?
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.kf.setImage(with: URL(string: image!), placeholder: #imageLiteral(resourceName: "frog"))
        titleLabel.text = titleArticle
        descriptionLabel.text = descriptionArticle
        
        //TODO: Add long press for 5 seconds
        let imageLongPressGesture = UILongPressGestureRecognizer(target: self, action: #selector(imageLongPressed))
        imageLongPressGesture.minimumPressDuration = 0.5
        imageLongPressGesture.delegate = self
        imageView.isUserInteractionEnabled = true
        imageView.addGestureRecognizer(imageLongPressGesture)
    }
}

/*  TODO: with UIGestureReconizer
 *  to make it long press and save to photo libary
 */
extension DetailViewController: UIGestureRecognizerDelegate, UIImagePickerControllerDelegate {
    @objc func imageLongPressed(press: UILongPressGestureRecognizer) {
        let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
        if press.state == .began {
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
            alert.addAction(UIAlertAction(title: "Save", style: .default, handler: { (action) in
                switch photoAuthorizationStatus {
                case .authorized :
                    UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(self.saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
                case .notDetermined:
                    PHPhotoLibrary.requestAuthorization({ (newStatus) in
                        if newStatus == PHAuthorizationStatus.authorized {
                            DispatchQueue.main.async {
                                UIImageWriteToSavedPhotosAlbum(self.imageView.image!, self, #selector(self.saveImage(_:didFinishSavingWithError:contextInfo:)), nil)
                            }
                        }
                    })
                case .restricted: break
                case .denied: break
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc func saveImage(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        } else {
            let alert = UIAlertController(title: "Saved!", message: "Image saved successfully", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default))
            present(alert, animated: true)
        }
    }
    
}
