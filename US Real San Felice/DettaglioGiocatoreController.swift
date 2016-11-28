//
//  DettaglioGiocatoreController.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 26/11/16.
//  Copyright © 2016 Russo Sabato. All rights reserved.
//

import UIKit
import Kingfisher
class DettaglioGiocatoreController: UIViewController {

    @IBOutlet var imgGiocatore: UIImageView!
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var numero: UILabel!
    @IBOutlet var nomeGiocatore: UILabel!
    var giocatore:Giocatore!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
           nomeGiocatore.text  = giocatore.cognome + " " + giocatore.nome
         let url_avatar = URL(string: giocatore.urlAvatar)
          imgGiocatore.kf.setImage(with: url_avatar)
        
        numero.layer.masksToBounds = true
        numero.layer.cornerRadius = 17.5
        numero.text = giocatore.numeroMaglia
        loadDettagli ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    
    
    
    func loadDettagli (){
        
        let label  = UILabel();
        label.text = "Portiere"
        scrollView.addSubview(label)
          scrollView.addSubview(label)
          scrollView.addSubview(label)
        
          scrollView.addSubview(label)
          scrollView.addSubview(label) 
        
        var view:UIView =  Bundle.main.loadNibNamed("ViewDettaglio", owner: self, options: nil)![0] as! UIView
        
        view.frame = CGRect(x: 0.0,y: 0.0, width: scrollView.frame.size.width, height: 600)
        scrollView.addSubview(view);
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
