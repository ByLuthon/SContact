//
//  CardsHViewController.swift
//  SCard
//
//  Created by Luthon Hagvinprice on 2018-01-04.
//  Copyright © 2018 Luthon Hagvinprice. All rights reserved.
//
/*
import UIKit
import CoreData

class CardsHViewController: UIViewController  {
    
    // STEP 1
    // Assing IBoutlet to UICollectionView
    // CHANGE MY VIEW TO collectionView
    @IBOutlet var myView: UICollectionView!
    
    // Video cell is equal to cardscollectioncell
    private var activeCell : VideoCell!
    // STEP 2
    
    // ADD call setupView on ViewDidload
    override func viewDidLoad() {
        super.viewDidLoad()
        // setupView()
        
    }
    
    
    // Step 3
    // set up gesture recongnizer
    func setupView(){
        // Setting up swipe gesture recognizers
        // CARDSHVIEWCONTROLLER = CARDSHOMEVIEWCONTROLLER
        let swipeUp : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CardsHViewController.userDidSwipeUp))
        swipeUp.direction = .up
        
        view.addGestureRecognizer(swipeUp)
        
        let swipeDown : UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(CardsHViewController.userDidSwipeDown))
        swipeDown.direction = .down
        
        view.addGestureRecognizer(swipeDown)
    }
    
    // STEP 4
    
    func getCellAtPoint(point: CGPoint) -> VideoCell? {
        // Function for getting item at point. Note optionals as it could be nil
        let indexPath = myView.indexPathForItem(at: point)
        var cell : VideoCell?
        
        if indexPath != nil {
            cell = myView.cellForItem(at: indexPath!) as? VideoCell?
        } else {
            cell = nil
        }
        
        return cell
    }
    
    // STEP 4
    
    // CAST is equal to  ARRAY of contacts chANGE CATS TO CONTACTS
    @objc func userDidSwipeUp(gesture : UISwipeGestureRecognizer){
        let point = gesture.location(in: myView)
        let duration = animationDuration()
        
        if(activeCell == nil){
            activeCell = getCellAtPoint(point)
            
            UIView.animateWithDuration(duration, animations: {
                self.activeCell.myCellView.transform = CGAffineTransformMakeTranslation(0, -self.activeCell.frame.height)
            });
        } else {
            // Getting the cell at the point
            let cell = getCellAtPoint(point: point)
            
            // If the cell is the previously swiped cell, or nothing assume its the previously one.
            if cell == nil || cell == activeCell {
                // To target the cell after that animation I test if the point of the swiping exists inside the now twice as tall cell frame
                let cellFrame = activeCell.frame
                let rect = CGRectMake(cellFrame.origin.x, cellFrame.origin.y - cellFrame.height, cellFrame.width, cellFrame.height*2)
                if CGRectContainsPoint(rect, point) {
                    // If swipe point is in the cell delete it
                    
                    let indexPath = myView.indexPathForCell(activeCell)
                    // CHANGE CATS TO CONTACT
                    cats.removeAtIndex(indexPath!.row)
                    myView.deleteItemsAtIndexPaths([indexPath!])
                    
                }
                // If another cell is swiped
            } else if activeCell != cell {
                // It's not the same cell that is swiped, so the previously selected cell will get unswiped and the new swiped.
                UIView.animateWithDuration(duration, animations: {
                    self.activeCell.myCellView.transform = CGAffineTransformIdentity
                    cell!.myCellView.transform = CGAffineTransformMakeTranslation(0, -cell!.frame.height)
                }, completion: {
                    (Void) in
                    self.activeCell = cell
                })
                
            }
        }
        
        
    }
    
    // REVERT DOWN
    @objc func userDidSwipeDown(){
        // Revert back
        if(activeCell != nil){
            let duration = animationDuration()
            
            UIView.animateWithDuration(duration, animations: {
                self.activeCell.myCellView.transform = CGAffineTransformIdentity
            }, completion: {
                (Void) in
                self.activeCell = nil
            })
        }
    }
    
    func animationDuration() -> Double {
        return 0.5
    }
    
}
 */
