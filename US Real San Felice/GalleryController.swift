//
//  GalleryController.swift
//  US Real San Felice
//
//  Created by Russo Sabato (Italdata spa) on 30/11/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit
import NYTPhotoViewer


class GalleryController:UIViewController, NYTPhotosViewControllerDelegate{
    
     var photosGallery  : [ImageGallery] = []

    
    func updateImagesOnPhotosViewController(_ photosViewController: NYTPhotosViewController, afterDelayWithPhotos: [ImageGallery]) {
        let delayTime = DispatchTime.now() + Double(5 * Int64(NSEC_PER_SEC)) / Double(NSEC_PER_SEC)
        // photos[0].attributedCaptionSummary = NSAttributedString(string: frase.text! , attributes: [NSForegroundColorAttributeName: UIColor.grayColor()])
        DispatchQueue.main.asyncAfter(deadline: delayTime) {
            /* for photo in self.photosGallery {
             if photo.image == nil {
             photo.image = UIImage(named: PrimaryImageName)
             photosViewController.updateImageForPhoto(photo)
             }
             }*/
        }
        
    }
    
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    
    func downloadImage(url: URL , idx:Int) {
        print("Download Started")
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            DispatchQueue.main.async() { () -> Void in
                
                let im = UIImage(data: data)
                
                self.photosGallery[idx].image = im;
                
            }
        }
    }
    
    
    
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, didNavigateTo photo: NYTPhoto, at photoIndex: UInt) {
        print("Did Navigate To Photo: \(photo) identifier: \(photoIndex)")
        
        
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, actionCompletedWithActivityType activityType: String?) {
        print("Action Completed With Activity Type: \(activityType)")
    }
    
    func photosViewControllerDidDismiss(_ photosViewController: NYTPhotosViewController) {
        print("Did dismiss Photo Viewer: \(photosViewController)")
    }
}
