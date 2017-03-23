//
//  ClassificaController.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 11/12/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit
import Kingfisher
import  Alamofire
import SwiftyJSON

class ClassificaController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet var tableClassifica: UITableView!
     var squadre :[Squadra] = [];
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        self.tableClassifica.dataSource = self;
        self.tableClassifica.delegate = self;
        
        
        let nib = UINib(nibName: "ClassificaViewCell", bundle: nil)
        tableClassifica.register(nib, forCellReuseIdentifier: "classifica_row")
        loadClassifica ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        
        return  self.squadre.count;
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableClassifica.dequeueReusableCell(withIdentifier: "classifica_row",for: indexPath as IndexPath) as? ClassificaViewCell
        
        let row =   indexPath.row
        
        cell?.posizione.text = String(squadre[row].posizione)
        cell?.squadra.text = squadre[row].nome;
       
        
        if cell?.squadra.text == "Real San Felice" {
           
            cell?.backgroundColor =  UIColor(netHex:0xFECA1E)
            cell?.scudetto.image = UIImage(named:"logohome");
        }
        else{
            let backgroundView = UIView()
            backgroundView.backgroundColor = UIColor(netHex:0x222955)
            cell?.backgroundView = backgroundView;
             cell?.scudetto.image = UIImage(named:"scudetto_vuoto");
        }
        
      
       
         cell?.punti.text = squadre[row].punti;
         cell?.punti.layer.masksToBounds = true
         cell?.punti.layer.cornerRadius = 15.0
       
        return cell!;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }
    
    
    func loadClassifica () {
        
        Alamofire.request(Config.pathClassifica).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                var i = 1;
                for (_,subJson):(String, JSON) in json {
                    let squadra:Squadra = Squadra();
                    
                    squadra.nome = subJson["squadra"].string!
                    squadra.posizione = i;
                    squadra.punti = subJson["punti"].string!
                  
                    
                    self.squadre.append(squadra);
                    i += 1 ;
                    
                }
                
                
              
                self.tableClassifica!.reloadData()
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
