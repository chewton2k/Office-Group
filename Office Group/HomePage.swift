//
//  HomePage.swift
//  Office Group
//
//  Created by Charlton Shih on 8/12/24.
//

import SwiftUI

struct HomePage: View {
    var body: some View {
        ScrollView{
            VStack {
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 160)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .padding(10)
                    
                Image("megamillion")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 180)
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 160)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .padding(10)
                    
                Image("power")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 330, height: 180)
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 160)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .padding(10)
                    
                    Image("superlotto")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 330, height: 180)
                }
                
                ZStack{
                    Rectangle()
                        .frame(width: 350, height: 160)
                        .foregroundColor(Color(.secondarySystemBackground))
                        .padding(10)
                    
                    Image("fantasy5")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 330, height: 180)
                }

                    
            }.padding()
            
        }
    }
}

#Preview {
    HomePage()
}
