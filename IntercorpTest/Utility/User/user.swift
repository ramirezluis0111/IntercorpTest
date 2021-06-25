//
//  user.swift
//  IntercorpTest
//


import Foundation
import Firebase
import FBSDKLoginKit

class userRegister: ObservableObject {
    @Published var data: [String : Any]
    @Published var dataDownload = NSDictionary()
    
    @Published var downloadComplete: Bool = false
    @Published var userAuth: Bool = false
    @Published var completeAuth: Bool = false
    @Published var change: Bool = false
    
    init() {
        dataDownload = [
            "complete": "",
            "creationDate" : "",
            "data" : [
                "age" : "",
                "dateOfBirth" : "",
                "name" : "",
                "surname" : ""
            ],
        ]
        
        data = [
            "complete": "",
            "creationDate" : "",
            "data" : [
                "age" : "",
                "dateOfBirth" : "",
                "name" : "",
                "surname" : ""
            ],
        ]
    }
    
    func someEmpty() -> Bool {
        var complete = false
        let dataUp: [String: String] = data["data"] as! [String: String]

        for item in dataUp {
            if item.key !=  "creationDate" {
                if item.value.isEmpty {
                    complete = true
                }
            }
        }

        return complete
    }
    
    func updateValues(inputName: String,
                      inputSurname: String,
                      inputAge: String,
                      inputDateOfBirth: String) {
        
        let today = todayString()
        
        data = [
            "complete": "",
            "creationDate" : today,
            "data" : [
                "age" : inputAge,
                "dateOfBirth" : inputDateOfBirth,
                "name" : inputName,
                "surname" : inputSurname
            ],
        ]
    }
    
    func downloadUser() {
        var ref: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().child("users").child(userID!)
        
        ref.observeSingleEvent(of: .value, with: { [self] (snapshot) in
            let value = snapshot.value as? NSDictionary
            
            if value == nil {
                ref.setValue(data)
                change = true
            } else {
                dataDownload = value!
                if (value!["complete"] as! String == "OK") {
                    completeAuth = true
                }
                change = true
                downloadComplete = true
            }
            
            }) { (error) in
                print(error.localizedDescription)
            }
    }
    
    func completeRegister() {
        var ref: DatabaseReference!
        let userID = Auth.auth().currentUser?.uid
        
        ref = Database.database().reference().child("users").child(userID!)
        
        if !someEmpty() {
            ref.setValue(data)
            let child = ["/complete": "OK"]
            ref.updateChildValues(child as [AnyHashable : Any])
            
            userAuth = true
            completeAuth = true
            downloadComplete = true
            change = true
        }
        
    }
    
    func detectUser() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user?.email! != nil {
                self.userAuth = true
                self.downloadUser()
            } else {
                self.change = true
            }
        }
    }

    func loginButtonDidLogOut() {
        
        dataDownload = [
            "complete": "",
            "creationDate" : "",
            "data" : [
                "age" : "",
                "dateOfBirth" : "",
                "name" : "",
                "surname" : ""
            ],
        ]
        
        data = [
            "complete": "",
            "creationDate" : "",
            "data" : [
                "age" : "",
                "dateOfBirth" : "",
                "name" : "",
                "surname" : ""
            ],
        ]
        
        let loginManager = LoginManager()
        loginManager.logOut()
        
        try? Auth.auth().signOut()
        userAuth = false
    }
}
