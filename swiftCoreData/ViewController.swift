//
//  ViewController.swift
//  swiftCoreData
//
//  Created by Jorge Macias on 11/21/14.
//  Copyright (c) 2014 Diincasa. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    var people = [NSManagedObject]()
    @IBOutlet weak var labelUserName: UITextField!
    @IBOutlet weak var labelPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loadButtonTapped(sender: UIButton) {
        let appDelegate = UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"Users")
        //fetchRequest.predicate = NSPredicate(format: "username= %@",labelUserName.text)
        var error: NSError?
        let fetchedResults = managedContext.executeFetchRequest(fetchRequest,
            error: &error) as [NSManagedObject]?
        if let results = fetchedResults {
            people = results
            println("people: \(people.count)")
            for i in 0..<people.count {
                let person=people[i]
                println(person.valueForKey("username") as String?)
                labelUserName.text=person.valueForKey("username") as String?
                println(person.valueForKey("password") as String?)
                labelPassword.text=person.valueForKey("password") as String?
            }
        } else {
            println("Could not fetch \(error), \(error!.userInfo)")
        }
    }

    @IBAction func saveButtonTapped(sender: UIButton) {
        let appDelegate =
        UIApplication.sharedApplication().delegate as AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity =  NSEntityDescription.entityForName("Users",
            inManagedObjectContext:
            managedContext)
        let newUser = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext:managedContext)
        newUser.setValue("Test", forKey: "username")
        newUser.setValue("1234", forKey: "password")
        var error: NSError?
        if !managedContext.save(&error) {
            println("Could not save \(error), \(error?.userInfo)")
        }
        println(newUser)
        println("Object Saved")
    }
}

