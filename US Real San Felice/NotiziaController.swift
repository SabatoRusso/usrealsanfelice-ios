//
//  NotiziaController.swift
//  US Real San Felice
//
//  Created by Sabato Russo on 02/01/17.
//  Copyright © 2017 Russo Sabato. All rights reserved.
//

import UIKit
import Kingfisher

class NotiziaController: UIViewController {

    @IBOutlet var img: UIImageView!
    @IBOutlet var testoNotizia: UITextView!
    var notizia:Notizia = Notizia();
    override func viewDidLoad() {
        super.viewDidLoad()
        let attrStr = try! NSAttributedString(
            data: notizia.testo.data(using: String.Encoding.unicode, allowLossyConversion: true)!,
            options: [ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType],
            documentAttributes: nil)
         self.testoNotizia.attributedText = attrStr
        self.title = notizia.titolo
        let url_notizia = URL(string: self.notizia.urlImmagine)
        self.img.kf.setImage(with: url_notizia, placeholder: nil,
                                 options: [.transition(ImageTransition.fade(1))])
        
      
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
