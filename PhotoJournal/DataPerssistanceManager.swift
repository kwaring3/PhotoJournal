//
//  DataPerssistanceManager.swift
//  PhotoJournal
//
//  Created by Kevin Waring on 1/15/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import Foundation

final class DataPersistanceManager{
    //path to documents directory
    //".../Documents"
    static func documentsDirectory() -> URL {
        return FileManager.default.urls(for: .documentDirectory,  in: .userDomainMask)[0]
    }
    //filepath using filename to documents directory
    //"...Documents/PhotoJournalist.plist"
    static func filepathToDocumentsDirectory(filename: String) -> URL {
        return documentsDirectory().appendingPathComponent(filename)
    }
}
