//
//  DetailViewController.swift
//  PhotoJournal
//
//  Created by Kevin Waring on 1/15/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var indexNum: Int!
    public var photoHolder: Post?
private var imagePicker: UIImagePickerController!
    private var descriptionText = "Description..."
    
    @IBOutlet var tapGesture: UITapGestureRecognizer!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var imageView: UIImageView!
    var imageSelected: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //updateUI()
        setupImagePickerViewController()
        setupTextViews()
        if let data = photoHolder {
            titleTextView.text = data.title
            imageView.image = UIImage.init(data: data.imageData)
            titleTextView.textColor = .black
            
            
        }
        
    }
//    private func updateUI() {
//        let photoJournal = PhotoJournalModel.getPhotoJournal(){
//            let image = UIImage(data: photoJournal.imageData)
//            imageView.image = image
//        }else{
//            print("blah")
//        }
//    }
    
    private func setupTextViews() {
        titleTextView.text = descriptionText
        titleTextView.textColor = .lightGray
        titleTextView.delegate = self
    }
    private func setupImagePickerViewController() {
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            //cameraButton.isEnabled = false
        }
    }
    
    private func showImagePickerController() {
        present(imagePicker, animated: true, completion: nil)
    }
    @IBAction func photoLibraryButtonPressed(_ sender: UIBarButtonItem) {
        imagePicker.sourceType = .photoLibrary
        showImagePickerController()
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func tapped(_ sender: UITapGestureRecognizer) {
        titleTextView.resignFirstResponder()
    }
    @IBAction func saveButton(_ sender: UIBarButtonItem) {
        guard let textTitle = titleTextView.text else {
            fatalError("nil")}
            let date = Date()
            let isoDateFormatter = ISO8601DateFormatter()
            isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
            let timeStamp = isoDateFormatter.string(from: date)
        
        if let imageData = imageSelected.jpegData(compressionQuality: 0.5){
            let photo = Post.init(createdAt: timeStamp, title: textTitle, imageData: imageData)
            PhotoJournalModel.addPhoto(photo: photo)
            dismiss(animated: true, completion: nil)
            
        } else {
            dismiss(animated: true, completion: nil)
        }
    }
    
//    private func savePhotoJournal(image: UIImage ) {
//        // PhotoJournal: createdAt, description, imageData
//        if let imageData = image.jpegData(compressionQuality: 0.5) {
//            let photoJournal = Post.init(createdAt: "", title: "", imageData: imageData)
//            PhotoJournalModel.savePhotoJournal(photoJournal: photoJournal)
//        }
//
//    }

}
extension DetailViewController:
UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            imageView.image = image
            //savePhotoJournal(image: image)
            imageSelected = image
        } else {
            print("nil")
        }
        dismiss(animated: true, completion: nil)
    }
}
extension DetailViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if titleTextView.text == descriptionText {
            titleTextView.text = ""
            titleTextView.textColor = .black
        }
    }
}

