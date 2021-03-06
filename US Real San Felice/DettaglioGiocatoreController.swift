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
    
    @IBOutlet weak var figurina: UIView!
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
        numero.layer.cornerRadius = 15.0
        numero.text = giocatore.numeroMaglia
        loadDettagli ()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
       
    }
    
    
  
    
    
    func loadDettagli (){
        
      
        
        let view:ViewDettagli =  Bundle.main.loadNibNamed("ViewDettaglio", owner: self, options: nil)![0] as! ViewDettagli
        
        view.frame = CGRect(x: 0.0,y: 0.0, width: scrollView.frame.size.width, height: 300)
        scrollView.contentSize.height =  view.frame.size.height;
        scrollView.addSubview(view);
        view.labelRuolo.text = giocatore.ruolo;
        view.nascitaLabel.text = giocatore.nascita;
        view.comuneLabel.text = giocatore.comune;
        view.alezzaLabel.text = "Altezza " + giocatore.altezza;
        view.pesoLabel.text = "Peso " + giocatore.peso;
    }
    

    @IBAction func shareImage(_ sender: Any) {
       
        let renderer = UIGraphicsImageRenderer(size: figurina.bounds.size)
        let image = renderer.image { ctx in
            figurina.drawHierarchy(in: figurina.bounds, afterScreenUpdates: false)
        }
        
      
        
        let messageStr:String  = ""
           
        var shareItems:Array = [image, messageStr] as [Any]
        
        let activityViewController:UIActivityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.excludedActivityTypes = [UIActivityType.print, UIActivityType.postToWeibo, UIActivityType.copyToPasteboard, UIActivityType.addToReadingList, UIActivityType.postToVimeo]
        
        self.present(activityViewController, animated: true, completion: nil)

        
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
