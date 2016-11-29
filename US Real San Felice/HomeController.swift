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

class HomeController: UIViewController {

   
    @IBOutlet var viewUltimaPartita: UIView!
    @IBOutlet var labelRisultato: UILabel!
    
    
    
    var partita:Partita = Partita();
    
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
                
               
                
               case .failure(let error):
                print(error)
            }
        }
    }

}

