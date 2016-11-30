//
//  ViewController.swift
//  US Real San Felice
//
//  Created by Russo Sabato (Italdata spa) on 24/11/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit
import Kingfisher
import  Alamofire
import SwiftyJSON
import Spring
import NYTPhotoViewer
class HomeController: UIViewController ,NYTPhotosViewControllerDelegate{

    @IBOutlet var labelOspite: UILabel!
    @IBOutlet var labelLocale: UILabel!
   
    @IBOutlet var viewUltimaPartita: SpringView!
    @IBOutlet var labelRisultato: UILabel!
    
    @IBOutlet var labelDataGiornata: UILabel!
    
     fileprivate var photosGallery  : [ImageGallery] = []
    fileprivate var  partita:Partita = Partita();
    
    override func viewDidLoad() {
        super.viewDidLoad()
            self.navigationController?.isNavigationBarHidden = true
        labelRisultato.layer.masksToBounds = true
        labelRisultato.layer.cornerRadius = 5
        viewUltimaPartita.layer.masksToBounds = true
        viewUltimaPartita.layer.cornerRadius = 5
        loadUltimaPartita ()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        super.viewWillDisappear(animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func loadUltimaPartita () {
        
        Alamofire.request(Config.pathUltimaPartita).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.partita.ospiti = json["ospiti"].string!;
                self.partita.locali = json["locali"].string!;
                self.partita.gol_loc = json["gol_loc"].string!;
                self.partita.gol_osp = json["gol_osp"].string!;
                self.partita.data = json["data"].string!;
                self.partita.giornata = json["giornata"].string!;
                
                self.labelRisultato.text = self.partita.gol_loc + " - " + self.partita.gol_osp
                self.labelOspite.text = self.partita.ospiti;
                self.labelLocale.text = self.partita.locali;
                self.labelDataGiornata.text = self.partita.giornata + " Giornata " + self.partita.data;
                self.viewUltimaPartita.animation = "squeezeDown"
                self.viewUltimaPartita.isHidden = false;
                self.viewUltimaPartita.animate()
                var i = 0;
                for (index,subJson):(String, JSON) in json["imgs"] {
                  let title = NSAttributedString(string: self.labelDataGiornata.text! , attributes: [NSForegroundColorAttributeName: UIColor.white])
                    
                    
                 self.photosGallery.append(ImageGallery(image: nil,imageData: nil,attributedCaptionTitle: title))
                   // p.attributedCaptionSummary = NSAttributedString(string: photo.frase , attributes: //[NSForegroundColorAttributeName: UIColor.grayColor()])
                    let url = URL(string: subJson.string!)
                    self.downloadImage(url: url! ,idx: i);
                    i = i + 1;
                }
                
               case .failure(let error):
                print(error)
            }
        }
    }
    
    
    
    @IBAction func vediGallery(_ sender: Any) {
        
        let photosViewController = NYTPhotosViewController(photos: self.photosGallery, initialPhoto: self.photosGallery[0] )
        photosViewController.delegate = self
        
        present(photosViewController, animated: true, completion: nil)
        updateImagesOnPhotosViewController(photosViewController, afterDelayWithPhotos: photosGallery)
        
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
    
    
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, referenceViewFor photo: NYTPhoto) -> UIView? {
        
        /*if photo as? ExamplePhoto == photosGallery[NoReferenceViewPhotoIndex] {
         return nil
         }
         */
        
        return nil;
        
    }
    
    func photosViewController(_ photosViewController: NYTPhotosViewController, loadingViewFor photo: NYTPhoto) -> UIView? {
       /* if photo as! ImageGallery == photosGallery[CustomEverythingPhotoIndex] {
            let label = UILabel()
            label.text = "Custom Loading..."
            label.textColor = UIColor.green
            return label
        }*/
        
        return nil
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

