//
//  SwiftUIView.swift
//  FoodPin
//
//  Created by Makaveli Ohaya on 5/9/20.
//  Copyright © 2020 Makaveli Ohaya. All rights reserved.
//

import SwiftUI
import SDWebImageSwiftUI
import WebKit

struct ContentView: View {
    
    @ObservedObject var obs = observer()
    
    var body: some View {
        
        NavigationView{
            
            List(obs.datas){i in
                
                Card(image: i.image, name: i.name, weburl: i.webUrl, rating: i.rating)
                
            }.navigationBarTitle("Near By Restaurants")
            
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

class observer : ObservableObject{
    
    @Published var datas = [datatype]()
    
    init() {
        
        let url1 = "https://developers.zomato.com/api/v2.1/geocode?lat=33.4921728&lon=-84.19737599999999"
        let api = "64d2d705881152ccb8e4cfa15f6dc722"
        
        let url = URL(string: url1)
        var request = URLRequest(url: url!)
    
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        request.addValue(api, forHTTPHeaderField: "user-key")
        request.httpMethod = "GET"
        
        let sess = URLSession(configuration: .default)
        sess.dataTask(with: request) { (data, _, _) in
            
            do{
                
                let fetch = try JSONDecoder().decode(Type.self, from: data!)
                print(fetch)
                
                for i in fetch.nearby_restaurants{
                    
                    
                    DispatchQueue.main.async {
                        
                        self.datas.append(datatype(id: i.restaurant.id, name: i.restaurant.name, image: i.restaurant.thumb, rating: i.restaurant.user_rating.aggregate_rating, webUrl: i.restaurant.url))
                    }

                }
            }
            catch{
                
                print(error)
                
            }
            
        }.resume()

    }
}

struct datatype : Identifiable {
    
    var id : String
    var name : String
    var image : String
    var rating : String
    var webUrl : String
}

struct Type : Decodable {
    
    var nearby_restaurants : [Type1]
}

struct Type1 : Decodable{
    
    
    var restaurant : Type2
}


struct Type2 : Decodable {
    
    var id : String
    var name : String
    var url : String
    var thumb : String
    var user_rating : Type3
}
struct Type3 : Decodable {
    
    var aggregate_rating : String
}

struct Card : View {
    
    var image = ""
    var name = ""
    var weburl = ""
    var rating = ""
    
    var body : some View{

        NavigationLink(destination: register(url: weburl, name: name)) {
            
            HStack{
                
                AnimatedImage(url: URL(string: image)!).padding(.all).frame(width: 100, height: 100).cornerRadius(10)
                
                VStack(alignment: .leading) {
                    
                    Text(name).fontWeight(.heavy)
                    Text(rating)
                }.padding(.vertical, 10)
                
            }
        }
    }
}
struct register : View {
    
    var url = ""
    var name = ""
    
    var body : some View{
        
        WebView(url: url).navigationBarTitle(name)
    }
}

struct WebView : UIViewRepresentable {
    
    var url = ""
    
    func makeUIView(context: UIViewRepresentableContext<WebView>) -> WKWebView {
        
        let web = WKWebView()
        web.load(URLRequest(url: URL(string: url)!))
        return web
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
        
    }
}
