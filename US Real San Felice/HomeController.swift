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
    
    @IBOutlet var viewNews: SpringView!
    
    @IBOutlet var imgNews: UIImageView!
    
    
    @IBOutlet var titleNews: UILabel!
    
     
    fileprivate var  partita:Partita = Partita();
    let notizia:Notizia = Notizia();
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.isNavigationBarHidden = true
        labelRisultato.layer.masksToBounds = true
        labelRisultato.layer.cornerRadius = 5
        viewUltimaPartita.layer.masksToBounds = true
        viewUltimaPartita.layer.cornerRadius = 5
        loadUltimaPartita ();
        loadUltimaNotizia();
        
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
    
    func loadUltimaNotizia() {
        
        Alamofire.request(Config.pathUltimaNotizia).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                var json = JSON(value)
                
                json = json[0];
                
                self.notizia.titolo  = json["titolo"].string!
                self.notizia.testo   = json["testo"].string!
                self.notizia.urlImmagine = json["img"].string!
                self.notizia.data = json["data"].string!
                
                self.titleNews.text = self.notizia.titolo;
                
                let url_notizia = URL(string: self.notizia.urlImmagine)
                self.imgNews.kf.setImage(with: url_notizia, placeholder: nil,
                                    options: [.transition(ImageTransition.fade(1))])
                self.viewNews.animation = "squeezeDown"
                self.viewNews.isHidden = false;
                self.viewNews.animate()
                
                
                
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    
    @IBAction func goNotizia(_ sender: Any) {
         self.performSegue(withIdentifier: "go_notizia"   , sender:self)
        
    }
    
    @IBAction func vediGallery(_ sender: Any) {
        
        if(self.photosGallery.count != 0){
       
            let photosViewController = NYTPhotosViewController(photos: self.photosGallery, initialPhoto: self.photosGallery[0] )
        photosViewController.delegate = self
        
        present(photosViewController, animated: true, completion: nil)
        updateImagesOnPhotosViewController(photosViewController, afterDelayWithPhotos: photosGallery)
        
        }
    }
    
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if  segue.identifier == "go_notizia" {
        let nav = segue.destination as! NotiziaController
            nav.notizia = self.notizia;
            
        }
        
        //let nav = segue.destination as! DettaglioGiocatoreController
       // nav.giocatore = giocaSelct;
    }
    
    

    
    
    
    
    

}

