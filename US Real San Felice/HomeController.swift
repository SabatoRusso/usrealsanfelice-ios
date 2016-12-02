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


class HomeController:  GalleryController{

    @IBOutlet var labelOspite: UILabel!
    @IBOutlet var labelLocale: UILabel!
   
    @IBOutlet var viewUltimaPartita: SpringView!
    @IBOutlet var labelRisultato: UILabel!
    
    @IBOutlet var labelDataGiornata: UILabel!
    
     
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
                
                for (_,subJson):(String, JSON) in json["imgs"] {
                  let title = NSAttributedString(string: self.labelDataGiornata.text! , attributes: [NSForegroundColorAttributeName: UIColor.white])
                    
                    let imageGal:ImageGallery = ImageGallery(image: nil,imageData: nil,attributedCaptionTitle: title)
                    imageGal.attributedCaptionSummary = NSAttributedString(string: self.partita.locali + " VS " + self.partita.ospiti + " (" + self.partita.gol_loc + "-" + self.partita.gol_osp + ")"  , attributes: [NSForegroundColorAttributeName: UIColor.gray])
                    self.photosGallery.append(imageGal);
                   
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
    
    

    
    
    
    
    

}

