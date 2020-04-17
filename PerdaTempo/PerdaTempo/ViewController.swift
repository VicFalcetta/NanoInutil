//
//  ViewController.swift
//  PerdaTempo
//
//  Created by Victor Falcetta do Nascimento on 16/04/20.
//  Copyright © 2020 Victor Falcetta do Nascimento. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var timer = Timer()
    var tempo: Int = 0
    var tempoMusica: Int = 51
    var isPressionado = false
    var caixaImages: [UIImage] = []
    var musicaPlayer: AVAudioPlayer?
    @IBOutlet weak var labelTitulo: UILabel!
    
    @IBOutlet weak var voltarButton: UIButton!
    @IBOutlet weak var imagemDoBotao: UIImageView!
    @IBOutlet weak var botaoImg: UIButton!
    @IBOutlet weak var caixaMusica: UIImageView!
    
    @IBAction func voltarAction(_ sender: Any) {
        voltarButton.isHidden = true
        botaoImg.isHidden = false
        imagemDoBotao.isHidden = false
        caixaMusica.isHidden = true
        musicaPlayer?.stop()
        stopAnimation(imageView: caixaMusica)
        labelTitulo.text = "Um Botão"
    }
    @IBAction func botaoAction(_ sender: Any) {
        tocarMusica()
        labelTitulo.text = "Uma Bela Musica!"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        caixaImages = fillArray(total: 8, prefixo: "Caixa")
        // Do any additional setup after loading the view.
    }
    
    func fillArray(total:Int, prefixo: String) -> [UIImage] {
        var imageArray: [UIImage] = []
        
        for i in 1..<total {
            let nomeImg = "\(i)_\(prefixo).png"
            guard let imagem = UIImage(named: nomeImg) else { return caixaImages }
            
            imageArray.append(imagem)
        }
        return imageArray
    }
    
    func createAnimation(imageView: UIImageView, images: [UIImage], duration: Double) {
        UIView.animate(withDuration: duration, delay: 0.0, animations: {
            imageView.animationImages = images
            imageView.animationRepeatCount = 50
            imageView.animationDuration = duration
            imageView.startAnimating()
        })
    }
    
    func stopAnimation(imageView: UIImageView) {
        imageView.stopAnimating()
    }
    
    func tocarMusica() {
        let path = Bundle.main.path(forResource: "NeverMusic.mp3", ofType: nil)!
        let url = URL(fileURLWithPath: path)
        botaoImg.isHidden = true
        imagemDoBotao.isHidden = true
        caixaMusica.isHidden = false
        voltarButton.isHidden = false
        
        do {
            musicaPlayer = try AVAudioPlayer(contentsOf: url)
            musicaPlayer?.play()
        } catch {
            print("Deu erro.")
        }
        
        createAnimation(imageView: caixaMusica, images: caixaImages, duration: 1.0)
    }

}

