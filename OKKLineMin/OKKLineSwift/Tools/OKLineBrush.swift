//
//  OKKLineSwift
//
//  Copyright © 2016年 Herb - https://github.com/Herb-Sun/OKKLineSwift
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.

import UIKit
import CoreGraphics


class OKLineBrush {
    
    public var indicatorType: OKIndicatorType
    private var context: CGContext
    private var firstValueIndex: Int?
    private let configuration = OKConfiguration.sharedConfiguration
    
    public var calFormula: ((Int, OKKLineModel) -> CGPoint?)?
    
    init(indicatorType: OKIndicatorType, context: CGContext) {
        self.indicatorType = indicatorType
        self.context = context
        
        context.setWidthWithRound(configuration.theme.indicatorLineWidth)
        
        var useColor : CGColor?
        switch indicatorType {
        case .DIF:
            useColor = (configuration.theme.DIFColor.cgColor)
        case .DEA:
            useColor = (configuration.theme.DEAColor.cgColor)
        case .KDJ_K:
            useColor = (configuration.theme.KDJ_KColor.cgColor)
        case .KDJ_D:
            useColor = (configuration.theme.KDJ_DColor.cgColor)
        case .KDJ_J:
            useColor = (configuration.theme.KDJ_JColor.cgColor)
        case .BOLL_MB:
            useColor = (configuration.theme.BOLL_MBColor.cgColor)
        case .BOLL_UP:
            useColor = (configuration.theme.BOLL_UPColor.cgColor)
        case .BOLL_DN:
            useColor = (configuration.theme.BOLL_DNColor.cgColor)
        default: break
        }
        
        if let color = useColor {
            context.setStrokeColor(color)
        }
    }
    
    public func draw(drawModels: [OKKLineModel]) {
        
        for (index, model) in drawModels.enumerated() {
            
            if let point = calFormula?(index, model) {
                
                if firstValueIndex == nil {
                    firstValueIndex = index
                }
                
                if firstValueIndex == index {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
        }
        context.strokePath()
    }
}
