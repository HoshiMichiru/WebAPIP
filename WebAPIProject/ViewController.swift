//
//  ViewController.swift
//  WebAPIProject
//
//  Created by 星みちる on 2019/07/19.
//  Copyright © 2019 星みちる. All rights reserved.
//

import UIKit

class ViewController: UIViewController{

    @IBOutlet weak var CollectionView: UICollectionView!
    
    //画面に表示する音楽の情報が入る変数
    var CollectionData: [[String:Any]] = []{
        didSet{
            //変数collectionDataの値が変わったら、画面を更新する
            
            CollectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url: URL = URL(string: "http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa/wsSearch?term=marron5&limit=20")!
        let task: URLSessionTask = URLSession.shared.dataTask(with: url, completionHandler: {data, response, error in
            do {
                let items = try JSONSerialization.jsonObject(with: data!) as! NSDictionary
                
                var result: [[String: Any]] = []
                
                for(key, data) in items {
                    if (key as! String == "results"){
                        let resultArray = data as! NSArray
                        for (eachMusic) in resultArray{
                            let dicMusic:NSDictionary = eachMusic as! NSDictionary
                            
                            print(dicMusic["trackName"]!)
                            print(dicMusic["artworkUrl100"]!)
                            
                            let data: [String: Any] = ["name": dicMusic["trackName"]!, "imageUrl": dicMusic["artworkUrl100"]!]
                            
                            result.append(data)
                        }
                    }
                }
                
                DispatchQueue.main.async() { () -> Void in
                    self.CollectionData = result
                }
                
            } catch {
                print(error)
            }
        })
        task.resume()
        
        //collectionViewのセルに、「CustomCollecctionViewCell.xib」を使用する設定を書く
        //UINibNameは別ウィンドウでデザインしたふファイル
        //フォーせるウィズリソースアイデンティファーは名前を登録
        
        CollectionView.register(UINib(nibName: "CustomCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "cell")
    
    
    //おまじない
        CollectionView.dataSource = self
        CollectionView.delegate = self
    
    
    }

    
}

//拡張するよ
extension ViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    //CollectionViewに表示する要素の数
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return CollectionData.count
        
    }
    //CollectionViewに表示するセルの設定
    //ラベルや画像の設定を書く
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        //1.collectionViewから名前と行番号を元にセルを取得
        let cell =   collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)as! CustomCollectionViewCell
        
//        2.取得したセルに色々設定する
        //ラベルの設定
//        ・・カスタムビューの中にあるラベルの値を変えたいので↓のような表記になる
        cell.label.text = "こんにちは"
        
//        3.出来上がったセルを返す
        return cell
    
    }
    

    
    
}


var test = "こんにちは"{
    didSet{
    //変数の値が書き換わったら
    print("変数の値が書き換わった")
}

    willSet{
    //書き換わりそう
}
}
