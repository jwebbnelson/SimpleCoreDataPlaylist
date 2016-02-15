//
//  ListViewController.swift
//  CoreDataPlaylist
//
//  Created by Jordan Nelson on 2/14/16.
//  Copyright © 2016 Jordan Nelson. All rights reserved.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var artistField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func addButtonTapped(sender: AnyObject) {
        if titleField.text?.isEmpty != true || artistField.text?.isEmpty != true {
            if let title = titleField.text, let artist = artistField.text {
                SongController.sharedInstance.addSong(title, artist: artist)
                tableView.reloadData()
            }
        }
    }
}

extension ListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("songCell", forIndexPath: indexPath)
        
        let song = SongController.sharedInstance.mySongs[indexPath.row]
        
        cell.textLabel?.text = song.name
        cell.detailTextLabel?.text = song.artist

        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SongController.sharedInstance.mySongs.count
    }
    
    // DELEGATE
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "My Playlist"
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let song = SongController.sharedInstance.mySongs[indexPath.row]
            SongController.sharedInstance.removeSong(song)
            // Delete the row from the table view
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
}
