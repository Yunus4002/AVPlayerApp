//
//  MainVC.swift
//  AVPlayerApp
//
//  Created by Asadbek Muzaffarov on 04/02/24.
//

import UIKit

import AVKit


class MainVC: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    var data = [Category]()
    
    var avPlayerController = AVPlayerViewController()
    var playerView: AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        setUpCollectionView()
        
        fetchingJSONData { result in
            self.data = result
            print(self.data)
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        
    }

    func setUpCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(VideoCVC.nib(), forCellWithReuseIdentifier: VideoCVC.identifier)
        
    }
    
    func fetchingJSONData(handler: @escaping (_ result: [Category]) -> (Void)) {
        guard let fileLocation = Bundle.main.url(forResource: "simple", withExtension: "json") else {return}
        
        do {
            let data = try Data(contentsOf: fileLocation)
            let json = try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed)
            print(json)
            let decode = try JSONDecoder().decode(JsonModel.self, from: data)
            
            // Closure Calling
            handler(decode.categories)
        } catch {
            print("Parsing Error")
        }
    }
    
    
    
    func videoUrl(url: String) {
        guard let url = URL(string: url) else {return}
        self.playerView = AVPlayer(url: url)
//        playerView?.play()
        avPlayerController.player = playerView
        
        present(avPlayerController, animated: true)
    }
    
    

 

}


extension MainVC: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let videoData = data[indexPath.section].videos[indexPath.row]
        
        videoUrl(url: videoData.sources)
    }
    
}

extension MainVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data[section].videos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: VideoCVC.identifier, for: indexPath) as? VideoCVC else {return UICollectionViewCell() }
        
        let videoData = data[indexPath.section].videos[indexPath.row]
        
        cell.titleLabel.text = videoData.title
        cell.imageView.downloaded(from: videoData.thumb)
        return cell
    }
    
}
extension MainVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 190)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 24, bottom: 5, right: 24)
    }
    
}
