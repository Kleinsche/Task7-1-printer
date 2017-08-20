//
//  drawView.swift
//  Task7-1
//
//  Created by 🍋 on 16/7/28.
//  Copyright © 2016年 🍋. All rights reserved.
//

import UIKit

class drawView: UIView {

    @IBOutlet weak var widthSlider: UISlider!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    fileprivate var path = CGMutablePath()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self) // 获取触摸的点
        CGPathMoveToPoint(path, nil, point.x, point.y)
    }
    
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point = touches.first!.location(in: self) // 获取触摸的点
        CGPathAddLineToPoint(path, nil, point.x, point.y)
        setNeedsDisplay() // 重绘界面
    }
    
    
    override func draw(_ rect: CGRect) {
        
        let context = UIGraphicsGetCurrentContext()
        context?.addPath(path)
        context?.setLineWidth(CGFloat(self.widthSlider.value))
        context?.strokePath()
    }
    
    @IBAction func clear() {
        self.path = CGMutablePath()
        setNeedsDisplay()
    }
    
    @IBAction func save() {
        UIGraphicsBeginImageContext(self.bounds.size) // 开始截取画图板
        self.layer.render(in: UIGraphicsGetCurrentContext()!)
        let img = UIGraphicsGetImageFromCurrentImageContext() // 截取到的图像
        UIGraphicsEndImageContext() // 结束截取
        UIImageWriteToSavedPhotosAlbum(img!, nil, nil, nil) // 把截取到的图像保存到相册中
        let alert = UIAlertView(title: "提示", message: "已保存至相册", delegate: self, cancelButtonTitle: "确定")
        alert.alertViewStyle = UIAlertViewStyle.default
        alert.show()
        
    }
    

}
