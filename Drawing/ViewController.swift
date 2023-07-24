//
//  ViewController.swift
//  Drawing
//
//  Created by Jeanine Chuang on 2023/7/18.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        drawHangyodon() //漢盾
        //drawGreeceFlag() //希臘國旗
 
        //環形進度條
        //drawCircularProgressRing(percentage: 30, percentageColor: UIColor(red: 148/255, green: 203/255, blue: 209/255, alpha: 1), defaultColor: UIColor.lightGray, lineWidth: 30)
        
        //甜甜圈圖表
        //drawDonutChart(percentages:[30, 15, 40, 8, 12], fontSize:16, labelBGColor: .white, lineWidth: 80)
  
        //圓餅圖
        //drawPieChart(percentages:[30, 15, 40, 8, 12], fontSize:14, labelBGColor: .white)
        
        
    }
    
    /**
     * 圓餅圖
     */
    func drawPieChart(percentages:[Double], fontSize: Double, labelBGColor:UIColor){
        let mainViewWidth = view.frame.width
        let aDegree = Double.pi / 180
        let radius: Double = mainViewWidth / 4.0 //半徑
        let chartX = mainViewWidth/2-radius*2
        let chartY = radius*3
        var startDegree: Double = 270
        let viewChart = UIView(frame: CGRect(x:chartX , y:chartY , width: 2*radius, height: 2*radius))
        
        
        //繪製切片
        for percentage in percentages {
            let endDegree = startDegree + 360 * percentage / 100
            let percentagePath = UIBezierPath()
            percentagePath.move(to: view.center)
            percentagePath.addArc(withCenter: view.center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
            let percentageLayer = CAShapeLayer()
            percentageLayer.path = percentagePath.cgPath
            percentageLayer.fillColor  = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 0.5).cgColor
            viewChart.layer.addSublayer(percentageLayer)
            let label = createLabel(percentage: percentage, startDegree: startDegree)
            viewChart.addSubview(label)
            startDegree = endDegree
        }
        view.addSubview(viewChart)
        
        //繪製標籤
        func createLabel(percentage: Double, startDegree: Double) -> UILabel {
            let textCenterDegree = startDegree + 360 * percentage / 2 / 100
            let textPath = UIBezierPath(arcCenter: view.center, radius: radius+10, startAngle: aDegree * textCenterDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
            let label = UILabel(frame: CGRect(x: chartX, y: chartY, width: 50, height: 30))
            label.backgroundColor = labelBGColor
            label.alpha = 0.7
            label.font = .systemFont(ofSize: fontSize)
            label.text = "\(percentage)%"
            label.sizeToFit()
            label.center = textPath.currentPoint
            let labelDegree = textCenterDegree - 270
            label.transform = CGAffineTransform(rotationAngle: .pi / 180 * labelDegree)
            return label
        }
    }
    
    /**
     * 甜甜圈圖表
     */
    func drawDonutChart(percentages: [Double], fontSize:Int, labelBGColor:UIColor, lineWidth: Double){
        let mainViewWidth = view.frame.width
        let aDegree = Double.pi / 180
        let radius: Double = mainViewWidth / 4.0 //半徑
        var startDegree: Double = 270
        
        //viewChart
        let viewWidth = 2*(radius+lineWidth)
        let viewChart = UIView(frame: CGRect(x: mainViewWidth/2-radius-lineWidth, y: radius*2+lineWidth, width: viewWidth, height: viewWidth))
        let center = CGPoint(x: lineWidth + radius, y: lineWidth + radius)
        
        //繪製區段
        //var percentages: [Double] = [30, 30, 40]
        for percentage in percentages {
            let endDegree = startDegree + 360 * percentage / 100
            let percentagePath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
            let percentageLayer = CAShapeLayer()
            percentageLayer.path = percentagePath.cgPath
            percentageLayer.strokeColor  = UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 0.5).cgColor
            percentageLayer.lineWidth = lineWidth
            percentageLayer.fillColor = UIColor.clear.cgColor
            viewChart.layer.addSublayer(percentageLayer)
            let label = createLabel(percentage: percentage, startDegree: startDegree)
            viewChart.addSubview(label)
            startDegree = endDegree
        }//for
        view.addSubview(viewChart)
        
        //繪製標籤
        func createLabel(percentage: Double, startDegree: Double) -> UILabel {
            let textCenterDegree = startDegree + 360 * percentage / 2 / 100
            let textPath = UIBezierPath(arcCenter: center, radius: radius, startAngle: aDegree * textCenterDegree, endAngle: aDegree * textCenterDegree, clockwise: true)
            let label = UILabel(frame: CGRect(x: 0, y: 0, width: 50, height: 30))
            label.backgroundColor = labelBGColor
            label.alpha = 0.7
            label.font = .systemFont(ofSize: CGFloat(fontSize))
            label.text = "\(percentage)%"
            label.sizeToFit()
            label.center = textPath.currentPoint
            return label
        }
    }
    
    /**
     * 環形進度條
     */
    func drawCircularProgressRing(percentage: CGFloat, percentageColor:UIColor, defaultColor:UIColor, lineWidth:Double){
        let mainViewWidth = view.frame.width
        let aDegree = Double.pi / 180
        let radius: Double = mainViewWidth / 4.0 //半徑
        let startDegree: Double = 270 //正上方
        
        //底層
        let circlePath = UIBezierPath(ovalIn: CGRect(x: lineWidth, y: lineWidth, width: radius*2, height: radius*2))
        let circleLayer = CAShapeLayer()
        circleLayer.path = circlePath.cgPath
        circleLayer.strokeColor = defaultColor.cgColor
        circleLayer.lineWidth = lineWidth
        circleLayer.fillColor = UIColor.clear.cgColor
        
        //進度層
        //let percentage: CGFloat = 60
        let endDegree = startDegree + 360 * percentage / 100
        let percentagePath = UIBezierPath(arcCenter: CGPoint(x: lineWidth + radius, y: lineWidth + radius), radius: radius, startAngle: aDegree * startDegree, endAngle: aDegree * endDegree, clockwise: true)
        let percentageLayer = CAShapeLayer()
        percentageLayer.path = percentagePath.cgPath
        percentageLayer.strokeColor  = percentageColor.cgColor
        percentageLayer.lineWidth = lineWidth
        percentageLayer.fillColor = UIColor.clear.cgColor

        //viewChart
        let viewWidth = 2*(radius+lineWidth)
        let viewChart = UIView(frame: CGRect(x:mainViewWidth/2-radius-lineWidth, y: lineWidth*2, width: viewWidth, height: viewWidth))
        viewChart.layer.addSublayer(circleLayer)
        viewChart.layer.addSublayer(percentageLayer)
        let label = UILabel(frame: viewChart.bounds)
        label.textAlignment = .center
        label.text = "\(percentage)%"
        viewChart.addSubview(label)
        
        view.addSubview(viewChart)
    }
    
    /**
     * 希臘國旗
     */
    func drawGreeceFlag(){
        //白底方塊
        let UNIT = 25.0 //63.45
        let COLOR = UIColor(red: 0, green: 20, blue: 137, alpha: 1)
        //var rect = CGRect(x: 0, y: 200, width: 750, height: 571)
        var rect = CGRect(x: 0, y: 200, width: 300, height: 23)
        let bgView = UIView(frame: rect)
        bgView.backgroundColor = UIColor.white

        //藍色長條
        var rectView = UIView(frame: rect)
        for count in stride(from: 0, to: 10, by: 2){
            rect = CGRect(x: 0, y: UNIT*Double(count), width: 750, height: UNIT)
            rectView = UIView(frame: rect)
            rectView.backgroundColor = COLOR
            bgView.addSubview(rectView)
        }

        //藍色正方 左上
        bgView.addSubview(drawFlagRect(x: 0, y: 0, width: Int(UNIT)*2, height: Int(UNIT)*2, color: COLOR))

        //藍色正方 左下
        bgView.addSubview(drawFlagRect(x: 0, y: Int(UNIT)*3, width: Int(UNIT)*2, height: Int(UNIT)*2, color: COLOR))

        //藍色正方 右上
        bgView.addSubview(drawFlagRect(x: Int(UNIT)*3, y: 0, width: Int(UNIT)*2, height: Int(UNIT)*2, color: COLOR))

        //藍色正方 右下
        bgView.addSubview(drawFlagRect(x: Int(UNIT)*3, y: Int(UNIT)*3, width: Int(UNIT)*2, height: Int(UNIT)*2, color: COLOR))

        //白色十字 直
        bgView.addSubview(drawFlagRect(x: Int(UNIT)*2, y: 0, width: Int(UNIT), height: Int(UNIT)*5, color: UIColor.white))

        //白色十字 橫
        bgView.addSubview(drawFlagRect(x: 0, y: Int(UNIT)*2, width: Int(UNIT)*5, height: Int(UNIT), color: UIColor.white))
        
        view.addSubview(bgView)
    }
    
    /**
     * 國旗方塊
     */
    func drawFlagRect(x:Int, y:Int, width:Int, height:Int, color:UIColor) -> UIView{
        
        let rect = CGRect(x:x, y:y, width:width, height:height)
        let rectView = UIView(frame: rect)
        rectView.backgroundColor = color
        
        return rectView
    }
    
    /**
     * 漢盾
     */
    func drawHangyodon(){
        let COLOR_1 = UIColor(red: 148/255, green: 203/255, blue: 209/255, alpha: 1)
        let COLOR_2 = UIColor(red: 83/255, green: 170/255, blue: 223/255, alpha: 1)
        let COLOR_3 = UIColor(red: 234/255, green: 183/255, blue: 207/255, alpha: 1)
        
        let drawView = UIView(frame: CGRect(x: 0, y: 200, width: view.frame.width, height: view.frame.height-200))
        
        // 頭
        let pathHead = UIBezierPath()
        pathHead.move(to: CGPoint(x: 91, y: 279))
        pathHead.addQuadCurve(to: CGPoint(x: 93, y: 213), controlPoint: CGPoint(x: 85, y: 252)) //頭左下
        pathHead.addQuadCurve(to: CGPoint(x: 187, y: 115), controlPoint: CGPoint(x: 104, y: 128)) //頭左上
        pathHead.addQuadCurve(to: CGPoint(x: 262, y: 116), controlPoint: CGPoint(x: 225, y: 109)) //頭上
        pathHead.addQuadCurve(to: CGPoint(x: 344, y: 234), controlPoint: CGPoint(x: 338, y: 130)) //頭右上
        pathHead.addQuadCurve(to: CGPoint(x: 317, y: 320), controlPoint: CGPoint(x: 344, y: 279)) //頭右下
        pathHead.addQuadCurve(to: CGPoint(x: 103, y: 298), controlPoint: CGPoint(x: 210, y: 284)) //嘴上
        pathHead.close()
        drawView.layer.addSublayer(drawLayer(path: pathHead, width: 0, color:COLOR_1))
        
        //左耳
        let pathLEar = UIBezierPath()
        pathLEar.move(to: CGPoint(x: 91, y: 218))
        pathLEar.addQuadCurve(to: CGPoint(x: 65, y: 222), controlPoint: CGPoint(x: 80, y: 208)) //耳左1
        pathLEar.addQuadCurve(to: CGPoint(x: 54, y: 251), controlPoint: CGPoint(x: 56, y: 235)) //耳左2
        pathLEar.addQuadCurve(to: CGPoint(x: 80, y: 290), controlPoint: CGPoint(x: 50, y: 283)) //耳左3
        pathLEar.addQuadCurve(to: CGPoint(x: 92, y: 287), controlPoint: CGPoint(x: 85, y: 289)) //耳左6
        pathLEar.close()
        drawView.layer.addSublayer(drawLayer(path: pathLEar, width: 0, color:COLOR_2))
        
        //右耳
        let pathREar = UIBezierPath()
        pathREar.move(to: CGPoint(x: 343, y: 234))
        pathREar.addQuadCurve(to: CGPoint(x: 367, y: 249), controlPoint: CGPoint(x: 364, y: 232)) //耳右1
        pathREar.addQuadCurve(to: CGPoint(x: 348, y: 305), controlPoint: CGPoint(x: 372, y: 281)) //耳右2
        pathREar.addQuadCurve(to: CGPoint(x: 326, y: 305), controlPoint: CGPoint(x: 338, y: 316)) //耳右3
        pathREar.close()
        drawView.layer.addSublayer(drawLayer(path: pathREar, width: 0, color:COLOR_2))
        
        //鰭
        let pathTop = UIBezierPath()
        pathTop.move(to:CGPoint(x: 171, y: 113))
        pathTop.addQuadCurve(to: CGPoint(x: 201, y: 81), controlPoint: CGPoint(x: 168, y: 75)) //鰭左1
        pathTop.addQuadCurve(to: CGPoint(x: 261, y: 78), controlPoint: CGPoint(x: 226, y: 45)) //鰭右1
        pathTop.addQuadCurve(to: CGPoint(x: 269, y: 119), controlPoint: CGPoint(x: 270, y: 88)) //鰭右2
        pathTop.close()
        drawView.layer.addSublayer(drawLayer(path: pathTop, width: 0, color:COLOR_2))
        
        //嘴
        let pathMouth = UIBezierPath()
        pathMouth.move(to: CGPoint(x: 103, y: 298))
        pathMouth.addQuadCurve(to: CGPoint(x: 319, y: 322), controlPoint: CGPoint(x: 210, y: 284)) //嘴上
        pathMouth.addQuadCurve(to: CGPoint(x: 312, y: 337), controlPoint: CGPoint(x: 330, y: 333)) //嘴右
        pathMouth.addQuadCurve(to: CGPoint(x: 126, y: 322), controlPoint: CGPoint(x: 206, y: 330)) //嘴下
        pathMouth.addQuadCurve(to: CGPoint(x: 101, y: 295), controlPoint: CGPoint(x: 85, y: 315)) //嘴左
        pathMouth.close()
        drawView.layer.addSublayer(drawLayer(path: pathMouth, width: 0, color:COLOR_3))
        
        //身體
        let pathBody = UIBezierPath()
        pathBody.move(to: CGPoint(x: 317, y: 334))
        pathBody.addQuadCurve(to: CGPoint(x: 340, y: 359), controlPoint: CGPoint(x: 335, y: 346)) //右手1
        pathBody.addQuadCurve(to: CGPoint(x: 309, y: 401), controlPoint: CGPoint(x: 350, y: 400)) //右手2
        pathBody.addQuadCurve(to: CGPoint(x: 306, y: 453), controlPoint: CGPoint(x: 312, y: 408)) //身體右
        pathBody.addQuadCurve(to: CGPoint(x: 332, y: 468), controlPoint: CGPoint(x: 324, y: 455)) //腳右1
        pathBody.addQuadCurve(to: CGPoint(x: 317, y: 490), controlPoint: CGPoint(x: 338, y: 490)) //腳右2
        pathBody.addQuadCurve(to: CGPoint(x: 293, y: 484), controlPoint: CGPoint(x: 319, y: 493)) //腳右3
        pathBody.addQuadCurve(to: CGPoint(x: 248, y: 485), controlPoint: CGPoint(x: 276, y: 505)) //腳右4
        pathBody.addQuadCurve(to: CGPoint(x: 199, y: 476), controlPoint: CGPoint(x: 229, y: 510)) //腳右5
        pathBody.addQuadCurve(to: CGPoint(x: 138, y: 486), controlPoint: CGPoint(x: 160, y: 508)) //腳左1
        pathBody.addQuadCurve(to: CGPoint(x: 99, y: 484), controlPoint: CGPoint(x: 110, y: 504)) //腳左2
        pathBody.addQuadCurve(to: CGPoint(x: 78, y: 490), controlPoint: CGPoint(x: 86, y: 491)) //腳左3
        pathBody.addQuadCurve(to: CGPoint(x: 66, y: 465), controlPoint: CGPoint(x: 45, y: 491)) //腳左4
        pathBody.addQuadCurve(to: CGPoint(x: 85, y: 455), controlPoint: CGPoint(x: 70, y: 460)) //腳左5
        pathBody.addQuadCurve(to: CGPoint(x: 92, y: 371), controlPoint: CGPoint(x: 77, y: 411)) //身體左1
        pathBody.addQuadCurve(to: CGPoint(x: 60, y: 355), controlPoint: CGPoint(x: 59, y: 380)) //身體左2
        pathBody.addQuadCurve(to: CGPoint(x: 94, y: 313), controlPoint: CGPoint(x: 62, y: 325)) //身體左3
        pathBody.close()
        drawView.layer.addSublayer(drawLayer(path: pathBody, width: 0, color:COLOR_1))
        
        //眼睛
        let pathLEye1 = UIBezierPath()
        pathLEye1.addArc(withCenter: CGPoint(x: 159, y: 225), radius: 47, startAngle: 0, endAngle: 180, clockwise: true) //左眼框
        drawView.layer.addSublayer(drawLayer(path: pathLEye1, width: 0, color:UIColor.white))
        //let pathLEye2 = UIBezierPath()
        //pathLEye2.addArc(withCenter: CGPoint(x: 183, y: 239), radius: 11, startAngle: 0, endAngle: 180, clockwise: true) //左眼珠
        //drawView.layer.addSublayer(drawLayer(path: pathLEye2, width: 0, color:UIColor.black))
        let pathREye1 = UIBezierPath()
        pathREye1.addArc(withCenter: CGPoint(x: 273, y: 239), radius: 46, startAngle: 0, endAngle: 180, clockwise: true) //右眼框
        drawView.layer.addSublayer(drawLayer(path: pathREye1, width: 0, color:UIColor.white))
        //let pathREye2 = UIBezierPath()
        //pathREye2.addArc(withCenter: CGPoint(x: 249, y: 244), radius: 11, startAngle: 0, endAngle: 180, clockwise: true) //右眼珠
        //drawView.layer.addSublayer(drawLayer(path: pathREye2, width: 0, color:UIColor.black))

        //描邊
        var path = UIBezierPath()
        
        path.move(to: CGPoint(x: 187, y: 116))
        path.addQuadCurve(to: CGPoint(x: 93, y: 213), controlPoint: CGPoint(x: 104, y: 128)) //頭左1
        path.addQuadCurve(to: CGPoint(x: 102, y: 302), controlPoint: CGPoint(x: 85, y: 252)) //頭左2

        path.move(to: CGPoint(x: 263, y: 118))
        path.addQuadCurve(to: CGPoint(x: 344, y: 234), controlPoint: CGPoint(x: 338, y: 130)) //頭右1
        path.addQuadCurve(to: CGPoint(x: 317, y: 320), controlPoint: CGPoint(x: 344, y: 279)) //頭右2

        path.move(to: CGPoint(x: 171, y: 113))
        path.addQuadCurve(to: CGPoint(x: 201, y: 81), controlPoint: CGPoint(x: 168, y: 75)) //鰭左
        path.addQuadCurve(to: CGPoint(x: 261, y: 78), controlPoint: CGPoint(x: 226, y: 45)) //鰭右1
        path.addQuadCurve(to: CGPoint(x: 269, y: 119), controlPoint: CGPoint(x: 270, y: 88)) //鰭右2
        
        path.move(to: CGPoint(x: 91, y: 218))
        path.addQuadCurve(to: CGPoint(x: 65, y: 222), controlPoint: CGPoint(x: 80, y: 208)) //耳左1
        path.addQuadCurve(to: CGPoint(x: 54, y: 251), controlPoint: CGPoint(x: 56, y: 235)) //耳左2
        path.addQuadCurve(to: CGPoint(x: 92, y: 292), controlPoint: CGPoint(x: 52, y: 295)) //耳左3
        
        path.move(to: CGPoint(x: 70, y: 243))
        path.addQuadCurve(to: CGPoint(x: 90, y: 242), controlPoint: CGPoint(x: 77, y: 240)) //耳左4
        path.move(to: CGPoint(x: 69, y: 264))
        path.addQuadCurve(to: CGPoint(x: 90, y: 265), controlPoint: CGPoint(x: 77, y: 263)) //耳左5
        
        path.move(to: CGPoint(x: 344, y: 234))
        path.addQuadCurve(to: CGPoint(x: 367, y: 249), controlPoint: CGPoint(x: 364, y: 232)) //耳右1
        path.addQuadCurve(to: CGPoint(x: 348, y: 305), controlPoint: CGPoint(x: 372, y: 281)) //耳右2
        path.addQuadCurve(to: CGPoint(x: 326, y: 305), controlPoint: CGPoint(x: 338, y: 316)) //耳右3
        path.addQuadCurve(to: CGPoint(x: 326, y: 305), controlPoint: CGPoint(x: 338, y: 316))
        
        path.move(to: CGPoint(x: 342, y: 260))
        path.addQuadCurve(to: CGPoint(x: 356, y: 264), controlPoint: CGPoint(x: 349, y: 261)) //耳右4
        path.move(to: CGPoint(x: 336, y: 281))
        path.addQuadCurve(to: CGPoint(x: 350, y: 285), controlPoint: CGPoint(x: 345, y: 282)) //耳右5

        path.move(to: CGPoint(x: 103, y: 298))
        path.addQuadCurve(to: CGPoint(x: 319, y: 322), controlPoint: CGPoint(x: 210, y: 284)) //嘴上
        path.addQuadCurve(to: CGPoint(x: 312, y: 337), controlPoint: CGPoint(x: 330, y: 333)) //嘴右
        path.addQuadCurve(to: CGPoint(x: 126, y: 322), controlPoint: CGPoint(x: 206, y: 330)) //嘴下
        path.addQuadCurve(to: CGPoint(x: 101, y: 295), controlPoint: CGPoint(x: 85, y: 315)) //嘴左
        
        path.move(to: CGPoint(x: 317, y: 334))
        path.addQuadCurve(to: CGPoint(x: 340, y: 359), controlPoint: CGPoint(x: 335, y: 346)) //右手1
        path.addQuadCurve(to: CGPoint(x: 311, y: 401), controlPoint: CGPoint(x: 350, y: 400)) //右手2
        
        path.move(to: CGPoint(x: 313, y: 368))
        path.addQuadCurve(to: CGPoint(x: 306, y: 453), controlPoint: CGPoint(x: 312, y: 408)) //身體右
        path.addQuadCurve(to: CGPoint(x: 332, y: 468), controlPoint: CGPoint(x: 324, y: 455)) //腳右1
        path.addQuadCurve(to: CGPoint(x: 317, y: 490), controlPoint: CGPoint(x: 338, y: 490)) //腳右2
        path.addQuadCurve(to: CGPoint(x: 293, y: 484), controlPoint: CGPoint(x: 319, y: 493)) //腳右3
        path.addQuadCurve(to: CGPoint(x: 248, y: 485), controlPoint: CGPoint(x: 276, y: 505)) //腳右4
        path.addQuadCurve(to: CGPoint(x: 199, y: 476), controlPoint: CGPoint(x: 229, y: 510)) //腳右5
        path.addQuadCurve(to: CGPoint(x: 138, y: 486), controlPoint: CGPoint(x: 160, y: 508)) //腳左1
        path.addQuadCurve(to: CGPoint(x: 99, y: 484), controlPoint: CGPoint(x: 110, y: 504)) //腳左2
        path.addQuadCurve(to: CGPoint(x: 78, y: 490), controlPoint: CGPoint(x: 86, y: 491)) //腳左3
        path.addQuadCurve(to: CGPoint(x: 66, y: 465), controlPoint: CGPoint(x: 55, y: 487)) //腳左4
        path.addQuadCurve(to: CGPoint(x: 85, y: 455), controlPoint: CGPoint(x: 70, y: 460)) //腳左5
        path.addQuadCurve(to: CGPoint(x: 92, y: 371), controlPoint: CGPoint(x: 77, y: 411)) //身體左1
        path.addQuadCurve(to: CGPoint(x: 60, y: 355), controlPoint: CGPoint(x: 59, y: 380)) //身體左2
        path.addQuadCurve(to: CGPoint(x: 94, y: 313), controlPoint: CGPoint(x: 62, y: 325)) //身體左3
        
        path.move(to: CGPoint(x: 181, y: 468))
        path.addQuadCurve(to: CGPoint(x: 210, y: 462), controlPoint: CGPoint(x: 195, y: 462)) //T1
        path.move(to: CGPoint(x: 197, y: 463))
        path.addQuadCurve(to: CGPoint(x: 199, y: 477), controlPoint: CGPoint(x: 195, y: 462)) //T2
        
        path.move(to: CGPoint(x: 193, y: 98))
        path.addQuadCurve(to: CGPoint(x: 203, y: 105), controlPoint: CGPoint(x: 196, y: 102)) //鰭點1
        drawView.layer.addSublayer(drawLayer(path: path, width: 10, color:UIColor.clear))

        path = UIBezierPath()
        path.move(to: CGPoint(x: 222, y: 88))
        path.addQuadCurve(to: CGPoint(x: 231, y: 100), controlPoint: CGPoint(x: 226, y: 91)) //鰭點2
        drawView.layer.addSublayer(drawLayer(path: path, width: 15, color:UIColor.clear))
        
        path = UIBezierPath()
        path.move(to: CGPoint(x: 135, y: 352))
        path.addQuadCurve(to: CGPoint(x: 161, y: 356), controlPoint: CGPoint(x: 138, y: 369)) //麟1
        path.move(to: CGPoint(x: 189, y: 355))
        path.addQuadCurve(to: CGPoint(x: 217, y: 360), controlPoint: CGPoint(x: 189, y: 375)) //麟2
        path.move(to: CGPoint(x: 241, y: 361))
        path.addQuadCurve(to: CGPoint(x: 266, y: 367), controlPoint: CGPoint(x: 246, y: 376)) //麟3
        path.move(to: CGPoint(x: 147, y: 383))
        path.addQuadCurve(to: CGPoint(x: 178, y: 388), controlPoint: CGPoint(x: 151, y: 402)) //麟4
        path.move(to: CGPoint(x: 218, y: 392))
        path.addQuadCurve(to: CGPoint(x: 245, y: 398), controlPoint: CGPoint(x: 224, y: 407)) //麟5
        path.move(to: CGPoint(x: 179, y: 415))
        path.addQuadCurve(to: CGPoint(x: 214, y: 415), controlPoint: CGPoint(x: 191, y: 433)) //麟6
        drawView.layer.addSublayer(drawLayer(path: path, width: 8, color:UIColor.clear))
        
        path = UIBezierPath()
        path.move(to: CGPoint(x: 124, y: 311))
        path.addCurve(to: CGPoint(x: 260, y: 320), controlPoint1: CGPoint(x: 162, y: 297), controlPoint2: CGPoint(x: 186, y: 340)) //嘴中1
        path.addQuadCurve(to: CGPoint(x: 299, y: 328), controlPoint: CGPoint(x: 286, y: 320)) //嘴中2
        drawView.layer.addSublayer(drawLayer(path: path, width: 8, color:UIColor.clear))
        
        path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 273, y: 239), radius: 46, startAngle: 0, endAngle: 180, clockwise: true) //右眼框
        drawView.layer.addSublayer(drawLayer(path: path, width: 8, color:UIColor.clear))
        
        path = UIBezierPath()
        path.addArc(withCenter: CGPoint(x: 159, y: 225), radius: 47, startAngle: 0, endAngle: 180, clockwise: true) //左眼框
        drawView.layer.addSublayer(drawLayer(path: path, width: 8, color:UIColor.clear))

        //揮手
        let handView = UIView()
        handView.layer.addSublayer(addHandBackground(color: COLOR_1))
        handView.layer.addSublayer(addHandOutline())
        drawView.addSubview(handView)
        
        //每一秒都將手的座標，往左移20
        //再利用.autoreverse反轉回原來的位置
        //.repeat命令漢頓的手不停往左移20再反轉回0
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            handView.frame = CGRect(x: -20, y: 0, width: 0, height: 0)
        }, completion: {_ in })
        
        //動眼
        let leftEyeView = UIView()
        leftEyeView.layer.addSublayer(addLeftEye())
        drawView.addSubview(leftEyeView)
        let rightEyeView = UIView()
        rightEyeView.layer.addSublayer(addRightEye())
        drawView.addSubview(rightEyeView)
        
        UIView.animate(withDuration: 1.0, delay: 0, options: [.repeat, .autoreverse], animations: {
            leftEyeView.frame = CGRect(x: -35, y: 0, width: 0, height: 0)
            rightEyeView.frame = CGRect(x: 35, y: 0, width: 0, height: 0)
        }, completion: {_ in })
    
        view.addSubview(drawView)
    }
    /**
     * 漢盾 左眼珠
     */
    func addLeftEye() -> CAShapeLayer {
        let pathLEye2 = UIBezierPath()
        pathLEye2.addArc(withCenter: CGPoint(x: 183, y: 239), radius: 11, startAngle: 0, endAngle: 180, clockwise: true) //左眼珠
        return drawLayer(path: pathLEye2, width: 0, color:UIColor.black)
    }
    /**
     * 漢盾 右眼珠
     */
    func addRightEye() -> CAShapeLayer {
        let pathREye2 = UIBezierPath()
        pathREye2.addArc(withCenter: CGPoint(x: 249, y: 244), radius: 11, startAngle: 0, endAngle: 180, clockwise: true) //右眼珠
        return drawLayer(path: pathREye2, width: 0, color:UIColor.black)
    }
    
    /**
     * 漢盾 手 背景色
     */
    func addHandBackground(color:UIColor) -> CAShapeLayer {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 75, y: 302))
        path.addQuadCurve(to: CGPoint(x: 106, y: 303), controlPoint: CGPoint(x: 90, y: 258)) //手上
        path.addQuadCurve(to: CGPoint(x: 117, y: 335), controlPoint: CGPoint(x: 138, y: 310)) //手右
        path.addQuadCurve(to: CGPoint(x: 87, y: 345), controlPoint: CGPoint(x: 107, y: 346)) //手下1
        path.addQuadCurve(to: CGPoint(x: 45, y: 344), controlPoint: CGPoint(x: 69, y: 361)) //手下2
        path.addQuadCurve(to: CGPoint(x: 51, y: 319), controlPoint: CGPoint(x: 25, y: 333)) //手左1
        path.addQuadCurve(to: CGPoint(x: 77, y: 298), controlPoint: CGPoint(x: 35, y: 287)) //手左2
        path.close()
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = 0
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = color.cgColor
        return layer

    }
    
    /**
     * 漢盾 手 邊框
     */
    func addHandOutline() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 75, y: 302))
        path.addQuadCurve(to: CGPoint(x: 106, y: 303), controlPoint: CGPoint(x: 90, y: 258)) //左手上
        path.addQuadCurve(to: CGPoint(x: 117, y: 335), controlPoint: CGPoint(x: 138, y: 310)) //左手右
        path.addQuadCurve(to: CGPoint(x: 87, y: 345), controlPoint: CGPoint(x: 107, y: 346)) //左手下1
        path.addQuadCurve(to: CGPoint(x: 45, y: 344), controlPoint: CGPoint(x: 69, y: 361)) //左手下2
        path.addQuadCurve(to: CGPoint(x: 51, y: 319), controlPoint: CGPoint(x: 25, y: 333)) //左手左1
        path.addQuadCurve(to: CGPoint(x: 77, y: 298), controlPoint: CGPoint(x: 35, y: 287)) //左手左2
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = 10
        layer.lineCap = .round
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
        
    }
    //繪製底色
    func drawLayer(path:UIBezierPath, width:CGFloat, color:UIColor) -> CAShapeLayer {
        
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = width
        layer.lineCap = .round
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = color.cgColor
        return layer
        
    }
    //繪製邊框
    func drawLine(startX:Int, startY:Int, endX:Int, endY:Int, pointX:Int, pointY:Int, width:CGFloat) -> CAShapeLayer {
        
        let path = UIBezierPath()
        path.move(to: CGPoint(x: startX, y: startY))
        path.addQuadCurve(to: CGPoint(x: endX, y: endY), controlPoint: CGPoint(x: pointX, y: pointY))
            
        let layer = CAShapeLayer()
        layer.path = path.cgPath
        layer.lineWidth = width
        layer.lineCap = .round
        layer.strokeColor = UIColor.black.cgColor
        layer.fillColor = UIColor.clear.cgColor
        return layer
        
    }

}

    

#Preview {
    UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController()!
}

