//
//  ProssimoTurnoController.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 11/12/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit
import  Alamofire
import SwiftyJSON


class ProssimoTurnoController: UIViewController {

    @IBOutlet var containerScroll: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        loadProssimoTurno();
        // Do any additional setup after loading the view.
    }

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func aggiungiTitolo(data:String,giornata:String){
        let view2 = UIView(frame: CGRect(x: 0.0,y: 0.0, width: self.view.frame.size.width, height:  50))
        view2.backgroundColor = UIColor.yellow
        
        let view:TitoloPartita =  Bundle.main.loadNibNamed("ViewTitoloPartita", owner: self, options: nil)![0]  as! TitoloPartita
        
        view.frame = CGRect(x: 0.0,y: 0.0, width: view2.frame.size.width, height:  50)
        view.data.text = data;
        view.giornata.text = giornata + " GIORNATA";
        containerScroll.contentSize.height =  self.view.frame.size.height;
        
        view2.addSubview(view);
        containerScroll.addSubview(view2);
        
        

        
    }
    
    
    func aggiungiPartita(locale:String,ospite:String,idx:Int){
        let view2 = UIView(frame: CGRect(x: 0.0,y: (51 * CGFloat(idx)), width: self.view.frame.size.width, height:  50))
        view2.backgroundColor = UIColor.white

        
        let view:PartitaView =  Bundle.main.loadNibNamed("ViewPartita", owner: self, options: nil)![0] as! PartitaView
        
        view.frame = CGRect(x:0.0 ,y: 0.0, width: view2.frame.size.width, height:  view2.frame.size.height-1)
        view.casa.text = locale;
        view.fuoricasa.text = ospite;
       
        if (locale == "REAL SAN FELICE"){
            view.casa.backgroundColor = UIColor(netHex:0xFECA1E)
        }
        if (ospite == "REAL SAN FELICE"){
            view.fuoricasa.backgroundColor = UIColor(netHex:0xFECA1E)
        }
        
        view2.addSubview(view);
        containerScroll.addSubview(view2);
        
        
        
    }
    
    
    func loadProssimoTurno () {
        
        Alamofire.request(Config.pathProssimoTurno).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                self.aggiungiTitolo(data: json["DATA"].string!, giornata: json["GIORNATA"].string!);
                
                var i = 1;
                for (_,subJson):(String, JSON) in json["partite"] {
                    self.aggiungiPartita (locale:subJson["locali"].string!, ospite: subJson["ospiti"].string!,idx: i)
                    i = i+1;
                }
               
            case .failure(let error):
                print(error)
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
