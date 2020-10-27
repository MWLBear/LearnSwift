
import ObjectMapper
import RxSwift


public enum RxObjectMapperError:Error{
    case parsingError
}


public extension Observable where Element:Any{
    
    
    func mapObject<T>(type:T.Type)->Observable<T> where T:Mappable{
        
        let mapper = Mapper<T>()
        
        return self.map { elemet -> T in
            guard let parseElement = mapper.map(JSONObject: elemet) else{
                throw RxObjectMapperError.parsingError
            }
            return parseElement
        }
    }
    
    func mapArry<T>(type:T.Type) -> Observable<[T]> where T:Mappable{
        
        let mapper = Mapper<T>()
        
        return self.map { (element) -> [T] in
            guard let parsedArry = mapper.mapArray(JSONObject: element) else{
                throw RxObjectMapperError.parsingError
            }
            return parsedArry
        }
        
    }
    
    
}


