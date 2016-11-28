//
//  ConvocatiController.swift
//  US Real San Felice
//
//  Created by Russo Sabato (Italdata spa) on 28/11/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//
import UIKit
import Kingfisher
import  Alamofire
import SwiftyJSON

class ConvocatiController: UIViewController ,UITableViewDataSource,UITableViewDelegate {

    
    
    @IBOutlet weak var avversariLabel: UILabel!
    @IBOutlet weak var note: UITextView!
     @IBOutlet var tableConvocati: UITableView!
    var giocatori :[Giocatore] = [];
    var giocaSelct:Giocatore!;
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
    
        self.tableConvocati.dataSource = self;
        self.tableConvocati.delegate = self;
        
        
        let nib = UINib(nibName: "GiocatoreViewCell", bundle: nil)
        tableConvocati.register(nib, forCellReuseIdentifier: "row_giocatore")
         loadConvocati ()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
       
        
        
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        
        
        return  self.giocatori.count;
        
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableConvocati.dequeueReusableCell(withIdentifier: "row_giocatore",for: indexPath as IndexPath) as? GiocatoreViewCell
        
        let row =   indexPath.row
        
        cell?.nomeGiocatore.text = giocatori[row].cognome + " " + giocatori[row].nome
        
        let url_avatar = URL(string: giocatori[row].urlAvatar)
        cell?.avatarGiocatore.kf.setImage(with: url_avatar)
        cell?.ruoloGiocatore.text = giocatori[row].ruolo
        cell?.numeroGiocatore.text = giocatori[row].numeroMaglia
        cell?.numeroGiocatore.layer.masksToBounds = true
        cell?.numeroGiocatore.layer.cornerRadius = 15
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = UIColor(netHex:0x222955)
        cell?.selectedBackgroundView = backgroundView;
        return cell!;
        
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
        
    }

    
    
    func loadConvocati () {
        
        Alamofire.request(Config.pathConvocati).validate().responseJSON { response in
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                
                self.note.text = json["note"].string!;
                self.avversariLabel.text = json["avv"].string!;
                for (_,subJson):(String, JSON) in json["convocati"] {
                    let giocatore:Giocatore = Giocatore();
                    
                    giocatore.nome = subJson["nome"].string!
                    giocatore.cognome = subJson["cognome"].string!
                    giocatore.urlAvatar = subJson["path_img"].string!
                    giocatore.numeroMaglia = subJson["num_maglia"].string!
                    giocatore.ruolo = subJson["ruolo"].string!
                    giocatore.nascita = subJson["dat_nas"].string!
                    giocatore.comune = subJson["com_nasc"].string!
                    giocatore.peso = subJson["peso"].string!
                    giocatore.altezza = subJson["altezza"].string!
                    
                    self.giocatori.append(giocatore);
                    
                    
                }
                
                
                self.giocatori.reverse();
                self.tableConvocati!.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        //  self.performSegueWithIdentifier("go_to_prodotti"   , sender:self)
        let row = indexPath.row
        self.giocaSelct = giocatori[row];
        self.performSegue(withIdentifier: "go_dettaglio2_giocatore"   , sender:self)
        
    }
   
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let nav = segue.destination as! DettaglioGiocatoreController
        nav.giocatore = giocaSelct;
    }

}
