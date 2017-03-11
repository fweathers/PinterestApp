import PinterestSDK

enum PinterestConstants: String {
    case appId = "4887068688768843748"
}

enum ConfigurationState {
    case configured
    case notConfigured
}

enum Result<T, E: Error> {
    case success(T)
    case failure(E)
}

enum PinterestError: Error {
    case authenticationFailure
    case invalidJson
}

class PinterestClient {
    static private(set) var configurationState: ConfigurationState = .notConfigured
    
    static func configureClient() {
        guard configurationState != .configured else { return }
        PDKClient.configureSharedInstance(withAppId: PinterestConstants.appId.rawValue)
        configurationState = .configured
    }
    
    //PDKClient.configureSharedInstance(withAppId: )
    func authenticate(presentor vc: UIViewController,
                      completion: @escaping (Result<PDKUser?, PinterestError>) -> Void) {
        let permissions = [PDKClientReadPublicPermissions,
                           PDKClientWritePublicPermissions,
                           PDKClientReadRelationshipsPermissions,
                           PDKClientWriteRelationshipsPermissions]
        
        PDKClient.sharedInstance().authenticate(withPermissions: permissions,
                                                from: vc,
                                                withSuccess: { response in
                                                    let user = response?.user()
                                                    completion(.success(user))
        },
                                                andFailure: { error in
                                                    completion(.failure(.authenticationFailure))
        })
    }
    
    func getBoards(completion: @escaping (Result<[Board], PinterestError>) -> Void) {
        let fields =  Set(["id", "image", "description", "name"])
        PDKClient.sharedInstance()
            .getAuthenticatedUserBoards(withFields: fields, success: { result in
                guard let json = result?.parsedJSONDictionary["data"] as? [[String: Any]]
                    else {
                        completion(.failure(.invalidJson))
                        return
                }
                
                completion(.success(json.flatMap { Board(dictionary: $0) }))

            }, andFailure: { error in
                print(error?.localizedDescription ?? "get failed: boards")
                completion(.failure(.invalidJson))
            })
    }
    
    func getPins(for id: String, completion: @escaping (Result<[Pin], PinterestError>) -> Void) {
        let fields = Set(["id", "note", "image"])
        
        PDKClient.sharedInstance().getBoardPins(id, fields: fields, withSuccess: { response in
            
            guard let json = response?.parsedJSONDictionary["data"] as? [[String: Any]] else {
                completion(.failure(.invalidJson))
                return
            }

            completion(.success(json.flatMap { Pin(dictionary: $0) }))

        }, andFailure: { error in
            print(error?.localizedDescription ?? "get failed: pins")
            completion(.failure(.invalidJson))
        })
    }

}
