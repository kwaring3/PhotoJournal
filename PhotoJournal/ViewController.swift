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
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            // Delete the row from the data source
//            meals.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        } else if editingStyle == .insert {
//            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
//        }
//    }
    @IBAction func alertItemsSelected(_ sender: UIButton) {
        let alert = UIAlertController(title: "Options", message: "Please select any of the Following you would like to do with you Photo", preferredStyle: .actionSheet)
        let editAction = UIAlertAction(title: "Edit", style: .default) { (alert: UIAlertAction!) -> Void in
            
            let storyBoard = UIStoryboard.init(name: "Main", bundle: nil)
            guard let destinationViewController = storyBoard.instantiateViewController(withIdentifier: "DetailVC") as? DetailViewController else { return }
            
            destinationViewController.modalPresentationStyle = .currentContext
            destinationViewController.photoHolder = self.phtot[sender.tag]
            destinationViewController.indexNum = sender.tag
            self.present(destinationViewController, animated: true, completion: nil)
        }
        
        
        let removeAction = UIAlertAction(title: "Remove", style: .destructive) { (alert: UIAlertAction!) -> Void in
            PhotoJournalModel.removePost(index: sender.tag)
            self.phtot = PhotoJournalModel.getPhotoJournal()
            self.collectionView.reloadData()
            
            
        }
        let shareAction = UIAlertAction(title: "Share", style: .default) { (alert: UIAlertAction!) -> Void in
            
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
            
        }
        
        
        alert.addAction(editAction)
        alert.addAction(shareAction)
        alert.addAction(removeAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)

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
        cell.editButton.tag = indexPath.row
        return cell
    }
    
    
}


