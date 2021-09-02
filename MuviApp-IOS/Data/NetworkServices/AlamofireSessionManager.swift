//
//  AlamofireSessionManager.swift
//  MuviApp-IOS
//
//  Created by Uwais Alqadri on 02/09/21.
//

import Foundation
import Alamofire
import Moya

class AlamofireSessionManagerBuilder {
  var policies: [String: ServerTrustEvaluating]?
  var configuration = URLSessionConfiguration.default

//  init(includeSSLPinning: Bool = true) {
//    if includeSSLPinning {
//      let allPublicKeys = ServerTrustManager.pinPublicKeys(
//        publicKeys: publicKeys,
//        validateCertificateChain: true,
//        validateHost: true
//      )
//
//      self.policies = [
//        "google.co.id": allPublicKeys,
//      ]
//    }
//
//    configuration.timeoutIntervalForRequest =  60.0
//    configuration.timeoutIntervalForResource =  60.0
//  }

  private var publicKeys: [SecKey] {
    [
      ""//APIConfiguration.cert
    ].compactMap { (certstring) in
      if let certificateData = Data(base64Encoded: certstring) as CFData? {
        return SecCertificateCreateWithData(nil, certificateData)
      }
      return nil
    }.compactMap { (cert) in
      publicKey(for: cert)
    }
  }

  private func publicKey(for certificate: SecCertificate) -> SecKey? {
    var publicKey: SecKey?

    let policy = SecPolicyCreateBasicX509()
    var trust: SecTrust?
    let trustCreationStatus = SecTrustCreateWithCertificates(certificate, policy, &trust)

    if let trust = trust, trustCreationStatus == errSecSuccess {
      publicKey = SecTrustCopyPublicKey(trust)
    }

    return publicKey
  }
}

