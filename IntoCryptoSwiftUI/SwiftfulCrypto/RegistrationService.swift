//
//  RegistrationService.swift
//  SwiftfulCrypto
//
//  Created by lulwah on 18/01/2023.
//
import Combine
import Foundation
import FirebaseDatabase
import Firebase

struct RegistrationCredentials {
    var email: String
    var password: String
    var Name: String
    
}

protocol RegistrationService {
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error>
}

enum RegistrationKeys: String {
    case Name
}

final class RegistrationServiceImpl: RegistrationService {
    
    func register(with credentials: RegistrationCredentials) -> AnyPublisher<Void, Error> {
        
        Deferred {

            Future { promise in
                
                Auth.auth().createUser(withEmail: credentials.email,
                                       password: credentials.password) { res, error in
                    
                    if let err = error {
                        promise(.failure(err))
                    } else {
                        
                        if let uid = res?.user.uid {
                            
                            let values = [RegistrationKeys.Name.rawValue: credentials.Name ] as [String : Any]
                            
                            Database
                                .database()
                                .reference()
                                .child("users")
                                .child(uid)
                                .updateChildValues(values) { error, ref in
                                    
                                    if let err = error {
                                        promise(.failure(err))
                                    } else {
                                        promise(.success(()))
                                    }
                                }
                        }
                    }
                }
            }
        }
        .receive(on: RunLoop.main)
        .eraseToAnyPublisher()
    }
    
}
