//
//  NSManagedObjectContext.swift
//  Pokemon
//
//  Created by Indah Nurindo on 14/07/2566 BE.
//

import UIKit
import CoreData

//NSManagedObjectModel memungkinkan CoreData untuk memetakan dari record dalam persistent store ke managed object yang digunakan dalam aplikasi. Model berisi kumpulan object entity description (contoh NSEntityDescription). Entity description mewakili entitas dalam skema (yang dapat Anda anggap sebagai tabel dalam database). Setiap object NSEntityDescription akan memiliki properties (atau field).

extension NSManagedObjectContext {
    static var current: NSManagedObjectContext{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
