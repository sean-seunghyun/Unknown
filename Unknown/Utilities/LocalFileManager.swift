//
//  LocalFileManager.swift
//  Unknown
//
//  Created by sean on 2022/09/23.
//

import Foundation
import SwiftUI

class LocalFileManager{
    
    static let instance = LocalFileManager()
    
    private init(){
        
    }
    
    func get(folderName: String, imageName: String) -> UIImage?{
        guard
            let imagePath:String = getPathForImage(folderName: folderName, imageName: imageName)?.path,
            FileManager.default.fileExists(atPath: imagePath)
        else { return nil }
        
        return UIImage(contentsOfFile: imagePath)
    }
    
    func add(image: UIImage, folderName: String, imageName: String){
        createFolderIfNeeded(folderName: folderName)
        guard
            let imageData = image.jpegData(compressionQuality: 100),
            let imageURL = getPathForImage(folderName: folderName, imageName: imageName) else { return }
        do {
            try imageData.write(to: imageURL)
        } catch let error {
            print("error saving imageData: \(error)")
        }
        
    }
    
    private func getPathForFolder(folderName: String) -> URL? {
        return FileManager
            .default
            .urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(folderName)
    }
    
    private func getPathForImage(folderName: String, imageName: String) -> URL?{
        guard let folderPath = getPathForFolder(folderName: folderName) else { return nil }
        
        return folderPath.appendingPathComponent(imageName + ".jpg")
    }
    
    private func createFolderIfNeeded(folderName: String){
        if let folderPath = getPathForFolder(folderName: folderName){
            
            if !FileManager.default.fileExists(atPath: folderPath.path){
                do{
                    try FileManager
                        .default
                        .createDirectory(at: folderPath, withIntermediateDirectories: true, attributes: nil)
                    print("folder created!")
                } catch let error {
                    print("error creating folder: \(error.localizedDescription)")
                }
            }
        }
        
    }
    
    
    
}
