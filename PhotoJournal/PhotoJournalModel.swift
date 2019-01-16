//
//  PhotoJournalModel.swift
//  PhotoJournal
//
//  Created by Kevin Waring on 1/15/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation

final class PhotoJournalModel {
    static let fileName = "PhotoJournalList.plist"
    private static var photoJournal = [Post]()
    private init() {}
    
    static func savePhotoJournal() {
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: fileName )
        do{
            let data = try PropertyListEncoder().encode(photoJournal)
            try data.write(to: path , options: Data.WritingOptions.atomic)
        } catch {
            print("property list encoding \(error)")
        }
    }
    
    static func getPhotoJournal() -> [Post] {
        let path = DataPersistanceManager.filepathToDocumentsDirectory(filename: fileName).path
        //var photoJournal: Post
        if FileManager.default.fileExists(atPath: path) {
            if let data = FileManager.default.contents(atPath: path) {
                do {
                    photoJournal = try PropertyListDecoder().decode([Post].self, from: data)
                }catch {
                    print("property list decoding error: \(error)")
                }
            } else {
                print("getPhotoJournal - data is nil")
            }
        } else {
            print("\(fileName) does not exist")
        }
        return photoJournal
    }
    
    static func addPhoto(photo: Post) {
        photoJournal.append(photo)
        savePhotoJournal()
    }
    
    
}
