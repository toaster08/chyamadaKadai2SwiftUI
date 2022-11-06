//
//  ContentView.swift
//  chyamadaKadai2UI
//
//  Created by 山田　天星 on 2022/11/06.
//

import SwiftUI

struct ContentView: View {
    
    enum Expression: Identifiable, CaseIterable {
        case addition
        case subtraction
        case multiplication
        case division
        
        var id: String { symbolString }
        
        var symbolString: String {
            switch self {
            case .addition:
                return "+"
            case .subtraction:
                return "-"
            case .multiplication:
                return "×"
            case .division:
                return "÷"
            }
        }
        
        func calculate(lhs: Int, rhs: Int) -> Int {
            switch self {
            case .addition:
                return (lhs + rhs)
            case .subtraction:
                return (lhs - rhs)
            case .multiplication:
                return (lhs * rhs)
            case .division:
                guard rhs != 0 else {
                    return 0
                }
                return (lhs / rhs)
            }
        }
    }
    
    @State private var numberTextList = [String](repeating: "", count: 2)
    
    @State private var resultString = ""
    @State private var selectedExpression = Expression.addition
    
    var body: some View {
        
        VStack(spacing: 30) {
            ForEach(numberTextList.indices, id: \.self) { index in
                TextField("", text: $numberTextList[index])
            }
            .textFieldStyle(.roundedBorder)
            .keyboardType(.numberPad)
            .font(.largeTitle)
            .multilineTextAlignment(.trailing)
            
            Picker("test", selection: $selectedExpression) {
                ForEach(Expression.allCases) {
                    expr in
                    Text(expr.symbolString).tag(expr)
                }
            }
            .colorMultiply(.yellow)
            .pickerStyle(.segmented)
            .padding()
            
            Button("Button") {
                print(#function)
                let number1 = Int(numberTextList[0]) ?? 0
                let number2 = Int(numberTextList[1]) ?? 0
                
                let result = selectedExpression.calculate(lhs: number1, rhs: number2)
                resultString = String(result)
            }
            .font(.largeTitle)
            .frame(width: 200, height: 60, alignment: .center)
            .foregroundColor(.white)
            .background(.cyan)
            .cornerRadius(15)
            
            HStack {
                Text("結果")
                Spacer()
                Text(resultString)
            }
            .font(.title)
            
            Spacer()
        }
        .frame(width: 250, height: 60, alignment: .trailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
