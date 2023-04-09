//
//  ContentView.swift
//  vinteUm
//
//  Created by Alexandre Florenço on 08/04/23.
//

import SwiftUI
var baralho: [Int] = ([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]).shuffled()

struct ContentView: View {
    @State var countCartas = 0
    
    var body: some View {
        ZStack{
            CustomBackground()
                .edgesIgnoringSafeArea(.all)
            
            VStack{
                ZStack{
                    add
                }.padding(.top, 80.0)
                
                Spacer()
                
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 70))]){
                    ForEach(baralho[0..<countCartas], id: \.self){ carta in
                        Carta(isFaceUp: true, conteudo: String(carta))
                    }
                }
                .padding(.horizontal)
                
                Spacer()
                
                Button{
                    baralho = baralho.shuffled()
                    countCartas = 0
                    
                } label: {
                    Image(systemName: "arrow.counterclockwise.circle")
                        .font(.largeTitle)
                }
                .padding(30)
                
            }
        }
    }
    
    @State private var showModalWin = false
    @State private var showModalLose = false
    var add: some View {
        Button{
            if baralho[0..<countCartas].reduce(0, +) < 21{
                countCartas += 1
            }
            else if baralho[0..<countCartas].reduce(0, +) == 21{
                showModalWin = true
                countCartas = 0
                baralho = baralho.shuffled()
            }
            else{
                showModalLose = true
                countCartas = 0
                baralho = baralho.shuffled()
            }
            
        } label: {
            ZStack{
                Carta(isFaceUp: false, conteudo: "")
                    .frame(width: 200.0)
                Text("🍎")
                    .font(.largeTitle)
            }
        }
        .sheet(isPresented: $showModalWin) {
            ModalView(conteudoModal: "VOCÊ VENCEU!", corModal: .blue)
        }
        
        .sheet(isPresented: $showModalLose) {
            ModalView(conteudoModal: "VOCÊ PERDEU!", corModal: .red)
        }

    }
        
}

struct CustomBackground: View {
    var body: some View {
        Color.init(red: 240/255, green: 240/255, blue: 240/255)
    }
}


struct Carta: View{
    var isFaceUp: Bool
    var conteudo: String
    var body: some View {
        if isFaceUp{
            ZStack{
                RoundedRectangle(cornerRadius: 10)
                    .fill()
                    .foregroundColor(.white)
                
                RoundedRectangle(cornerRadius: 10)
                    .strokeBorder(lineWidth: 3)
                    .foregroundColor(.blue)
                
                Text(conteudo)
                    .font(.largeTitle)
                    .foregroundColor(.blue)
                
            }
            .padding(2)
            .aspectRatio(2/3, contentMode: .fit)
        }
        else {
            RoundedRectangle(cornerRadius: 10)
                .aspectRatio(2/3, contentMode: .fit)
                .foregroundColor(.blue)
            
        }
    }
}

struct ModalView: View {
    @Environment(\.presentationMode) var presentationMode
    var conteudoModal: String
    var corModal: Color
    
    var body: some View {
        VStack {
            Text(conteudoModal)
                .font(.largeTitle)
                .padding()
            
            Button{
                self.presentationMode.wrappedValue.dismiss()
                
            } label: {
                Image(systemName: "checkmark.circle")
                    .font(.largeTitle)
            }
            .padding()
        }
        .foregroundColor(corModal)
    }
}
































struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
