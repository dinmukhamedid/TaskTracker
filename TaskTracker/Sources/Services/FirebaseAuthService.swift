import FirebaseAuth

class FirebaseAuthService {
    static let shared = FirebaseAuthService()

    func signUp(email: String, password: String, completion: @escaping (Result<AuthUser, Error>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else { return }
            completion(.success(AuthUser(uid: user.uid, email: user.email)))
        }
    }

    func signIn(email: String, password: String, completion: @escaping (Result<AuthUser, Error>) -> Void) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            guard let user = result?.user else { return }
            completion(.success(AuthUser(uid: user.uid, email: user.email)))
        }
    }

    func signOut() throws {
        try Auth.auth().signOut()
    }
}
