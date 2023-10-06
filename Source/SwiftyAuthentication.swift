import AuthenticationServices



public class SwiftyAuthentication: NSObject {
    public struct SwiftyUser {
        let firstName: String?
        let lastName: String?
        let email: String?
        let userId: String
        let identityToken: Data?
        let password: String?
    }
    
    
    public typealias callback = ((_ result: Result<SwiftyUser, Error>) -> Void)    
    private var appleLoginCallback: callback?

    
    public func signInWithApple(_ scope: [ASAuthorization.Scope] = [.fullName, .email] , completion: @escaping callback) {
        appleLoginCallback = completion
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = scope
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
    }
}



extension SwiftyAuthentication: ASAuthorizationControllerDelegate, ASAuthorizationControllerPresentationContextProviding {
    
    public func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        let keyWindow = UIApplication.shared.keyWindow?.rootViewController
        let presentingViewController = (UIApplication.shared.connectedScenes.first as? UIWindowScene)?.windows.first?.rootViewController ?? keyWindow
        return presentingViewController!.view.window!
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
        appleLoginCallback?(.failure(error))
    }
    
    public func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        var userId: String?
        var email: String?
        var givenName: String?
        var familyName: String?
        var identityToken: Data?
        var password: String?
        var fullName = ""
        
        switch authorization.credential {
            case let appleIdCredential as ASAuthorizationAppleIDCredential:
                userId = appleIdCredential.user
                email = appleIdCredential.email
                givenName = appleIdCredential.fullName?.givenName
                familyName = appleIdCredential.fullName?.familyName
                identityToken = appleIdCredential.identityToken
                break
                
            case let passwordCredential as ASPasswordCredential:
                userId = passwordCredential.user
                password = passwordCredential.password
                break
                
            default:
                appleLoginCallback?(.failure(SwiftyAuthenticationError.InvalidAuthenticationResponse))
                break
        }
        
        guard let userId else {
            appleLoginCallback?(.failure(SwiftyAuthenticationError.InvalidUserId))
            return
        }
        if let email {
            KeyChain.shared.save(key: userId, type: .email, data: email.inData)
        }
        
        if let givenName {
            fullName = "\(givenName) "
            KeyChain.shared.save(key: userId, type: .givenName, data: givenName.inData)
        }
        
        if let familyName {
            fullName += familyName
            KeyChain.shared.save(key: userId, type: .familyName, data: familyName.inData)
        }
        
        let emailFromKeychain = KeyChain.shared.load(key: userId, type: .email)
        let givenNameFromKeychain = KeyChain.shared.load(key: userId, type: .givenName)
        let familyNameFromKeychain = KeyChain.shared.load(key: userId, type: .familyName)
        
        let swiftyUser = SwiftyUser(
            firstName: givenName ?? givenNameFromKeychain,
            lastName: familyName ?? familyNameFromKeychain,
            email: email ?? emailFromKeychain,
            userId: userId,
            identityToken: identityToken,
            password: password)
        
        appleLoginCallback?(.success(swiftyUser))

    }
    
}


private extension String {
    ///Convert string to date
    var inData: Data? {
        return self.data(using: .utf8)
    }
}


enum SwiftyAuthenticationError: Error {
    case InvalidUserId, InvalidAuthenticationResponse
}

extension SwiftyAuthenticationError: LocalizedError {
    var errorDescription: String? {
        switch self {
            case .InvalidUserId:
                return "Apple authentication service did not return the user."
            case .InvalidAuthenticationResponse:
                return "Unknown credentials received from the Apple authentication service."
        }
    }
}
