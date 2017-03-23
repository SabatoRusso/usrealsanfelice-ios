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
    
    var position = 0;
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
        print(position);
        let view2 = UIView(frame: CGRect(x: 0.0,y: (51 * CGFloat(position)), width: self.view.frame.size.width, height:  50))
        view2.backgroundColor = UIColor.yellow
        
        let view:TitoloPartita =  Bundle.main.loadNibNamed("ViewTitoloPartita", owner: self, options: nil)![0]  as! TitoloPartita
        
        view.frame = CGRect(x: 0.0,y: 0.0, width: view2.frame.size.width, height:  50)
       // view.data.text = data;
        view.giornata.text = giornata;
        containerScroll.contentSize.height =  self.view.frame.size.height;
        
        view2.addSubview(view);
        
        containerScroll.addSubview(view2);
        
        

        
    }
    
    
    func aggiungiPartita(locale:String,ospite:String,ris:String,idx:Int){
        let view2 = UIView(frame: CGRect(x: 0.0,y: (51 * CGFloat(position)), width: self.view.frame.size.width, height:  50))
        view2.backgroundColor = UIColor.white

        
        let view:PartitaView =  Bundle.main.loadNibNamed("ViewPartita", owner: self, options: nil)![0] as! PartitaView
        
        view.frame = CGRect(x:0.0 ,y: 0.0, width: view2.frame.size.width, height:  view2.frame.size.height-1)
        view.casa.text = locale;
        view.fuoricasa.text = ospite;
         view.ris.text = ris;
       
        if (locale == "REAL SAN FELICE"){
            view.casa.backgroundColor = UIColor(netHex:0xFECA1E)
        }
        if (ospite == "REAL SAN FELICE"){
            view.fuoricasa.backgroundColor = UIColor(netHex:0xFECA1E)
        }
        containerScroll.contentSize.height = (100 * CGFloat(idx));
        view2.addSubview(view);
        containerScroll.addSubview(view2);
        
        
        
    }
    
    
    func loadProssimoTurno () {
        
        Alamofire.request(Config.pathProssimoTurno).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                //
                
                var i = 0;
               
                for (_,subJson):(String, JSON) in json["partite"] {
                     var flag = false;
                    if((i%6) == 0){
                        
                        self.aggiungiTitolo(data: "", giornata: subJson["giornata"].string!);
                        self.position = self.position + 1;
                        flag = true;
                        
                    }
                    self.aggiungiPartita (locale:subJson["locali"].string!, ospite: subJson["ospiti"].string!,ris:subJson["ris"].string! ,idx: i)
                   
                   
                    if(flag == false) {
                    self.position = self.position + 1;
                    }
                     i = i+1;
                }
                print(i);
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
