//
//  BookmarkCoreDataService.swift
//  Unknown
//
//  Created by sean on 2022/10/06.
//

import Foundation
import CoreData

class BookmarkCoreDataService{
    private let container: NSPersistentContainer
    private let entityName: String = "BookmarkedMovieEntity"
    
    @Published var bookmarkedMovieEntities: [BookmarkedMovieEntity] = []
    
    static let instance = BookmarkCoreDataService()
    
    private init(){
        container = NSPersistentContainer(name: "BookmarkContainer")
        
        container.loadPersistentStores { description, error in
            if let error = error {
                print("error loading container: \(error)")
            }
            print("description: \(description)")
            print("success loading container")
        }
        
        getBookmarks()
    }
    
    // MARK: - PUBLIC
    func updateBookmark(movie: Movie){
        
        if let savedBookmarkedMovie = bookmarkedMovieEntities.first(where: { $0.movieID == movie.id }){
            remove(entity: savedBookmarkedMovie)
        }else{
            add(movie: movie)
        }
     
    }
    
    func isBookmarked(movie : Movie) -> Bool{
        if let _ = bookmarkedMovieEntities.first(where: { $0.movieID == movie.id }){
            return true
        }else{
            return false
        }
    }
    
    // MARK: - PRIVATE
    private func getBookmarks(){
        let request = NSFetchRequest<BookmarkedMovieEntity>(entityName: entityName)
        do{
            bookmarkedMovieEntities = try container.viewContext.fetch(request)
        }catch let error{
            print("error fetching portfolios: \(error.localizedDescription)")
        }
    }
    
    private func add(movie: Movie){
        let newPortfolio = BookmarkedMovieEntity(context: container.viewContext)
        newPortfolio.movieID = Int32(movie.id)
        applyChanges()
    }
    
    private func saveData(){
        do{
            try container.viewContext.save()
        }catch let error {
            print("error savind data: \(error.localizedDescription)")
        }
    }
    
    private func applyChanges(){
        saveData()
        getBookmarks()
    }
    
  
    private func remove(entity: BookmarkedMovieEntity){
        container.viewContext.delete(entity)
        applyChanges()
    }
    
}
