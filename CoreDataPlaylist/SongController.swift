//
//  SongController.swift
//  CoreDataPlaylist
//
//  Created by Jordan Nelson on 2/13/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import Foundation
import CoreData

class SongController {
    
    static let sharedInstance = SongController()
    
    var mySongs: [Song] {
        
        let request = NSFetchRequest(entityName: "Song")
        
        let moc = Stack.sharedStack.managedObjectContext
        
        do {
            // WE know the returned managed objects will be songs
            return try moc.executeFetchRequest(request) as! [Song]
        } catch {
            return []
        }
    }
    
    func saveToPersistentStore() {
        let moc = Stack.sharedStack.managedObjectContext
        do {
            try moc.save()
        } catch {
            print("Error saving \(error)")
        }
    }
    
    func addSong(title: String, artist: String) {
         let _ = Song(name: title, artist: artist)
        saveToPersistentStore()
    }
    
    // REMOVES Songs from the array
    func removeSong(song: Song) -> () {
        
        // MOC Off of song object, could have used stack
        // This would work if using multiple moc
        if let moc = song.managedObjectContext {
            moc.deleteObject(song)
            saveToPersistentStore()
        }
    }
    
    
    
}

