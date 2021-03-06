//
//  CommonService.swift
//  WeatherApp
//
//  Created by Abhisek K. on 12/06/21.
//

import Foundation
import Alamofire


//MARK: - Encodable
extension Encodable {
    
    var asDictionary : [String: Any]? {
        guard let data = try? JSONEncoder().encode(self) else { return nil }
    
        guard let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String:Any] else { return nil }
        return json
    }
}


protocol DecodeProtocol {
    func getDecodeData<T:Codable>(objectType:T.Type, responseData: DataResponse<Any>?) -> Swift.Result<T?,NetworkError>
}

protocol APIService : DecodeProtocol{
    func callServer<T:Codable>(networkModel:NetworkRequestModel, _ objectType: T.Type,completion: @escaping (Swift.Result<T?,NetworkError>) -> Void) -> DataRequest
}

protocol CityWeatherService : APIService{
    func getCityWeather<T: Codable>(with name:String,  objectType:T.Type, completion: @escaping (Swift.Result<T?,NetworkError>) -> Void)
}



extension DecodeProtocol{
    func getDecodeData<T:Codable>(objectType:T.Type, responseData: DataResponse<Any>?) -> Swift.Result<T?,NetworkError>{
        
        guard let data = responseData?.data else { return .failure(.noData) }
        
        do {
           
            // Decode data to object
            let jsonDecoder = JSONDecoder()
            let decodedData = try jsonDecoder.decode(T.self, from: data)
            return .success(decodedData)
        }
        catch {
            
            debugPrint(error)
            
            return .failure(.decodingFailed)
        }
    }
    
    func getNetworkRequestModel(url:URLBuilder, postParam:Codable? = nil, headerParam:[String: String]? = nil,requestType:HTTPMethod = .get) -> NetworkRequestModel{
        return NetworkRequestModel(url: ServiceUrl.getUrl(url).url, postParams: postParam?.asDictionary, headerParams: headerParam, requestType: requestType)
    }
}

extension APIService{
    
    func callServer<T:Codable>(networkModel:NetworkRequestModel, _ objectType: T.Type,completion: @escaping (Swift.Result<T?,NetworkError>) -> Void) -> DataRequest{
        
        debugPrint(networkModel.urlString)
        let urlStr = networkModel.urlString.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? .init()
        let request = URLRequest.init(url: URL.init(string: urlStr)!)
        
        return Alamofire.request(request).responseJSON { (response) in
            debugPrint(response)
            completion(getDecodeData(objectType: T.self, responseData: response))
        }
    }
}
