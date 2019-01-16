//
//  ViewController.swift
//  PhotoJournal
//
//  Created by Kevin Waring on 1/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    private var imagePickerViewController: UIImagePickerController!
    
    var phtot = PhotoJournalModel.getPhotoJournal()
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
        phtot = PhotoJournalModel.getPhotoJournal()
    }



}
extension ViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return phtot.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PostCell", for: indexPath) as? PostCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = phtot[indexPath.row]
        cell.titleLabel.text = photoToSet.title
        cell.dateLabel.text = photoToSet.dateFormattedString
        cell.imageView.image = UIImage(data: photoToSet.imageData)
        
        return cell
    }
    
    
}

