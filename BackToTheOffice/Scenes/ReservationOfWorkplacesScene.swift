//
//  ReservationOfWorkplacesScene.swift
//  BackToTheOffice
//
//  Created by Roman Egorov on 22.01.2021.
//  Copyright © 2021 Roman Egorov. All rights reserved.
//

import SpriteKit
import  GameplayKit
import UIKit

class ReservationOfWorkplacesScene: SKScene {
    
    var isLoaded = false
    
    var tempSelectedNode = SKNode()
    var tempBeganNodePosition = CGPoint.zero
    
    var isEditModeOn = false {
        didSet {
            if isEditModeOn {
                
                print("EditModeOn")
                camera?.childNode(withName: "workplace")?.isHidden = false
            } else {
                print("EditModeOff")
                camera?.childNode(withName: "workplace")?.isHidden = true
            }
            
        }
    }
    
    var trashIsActiv = false {
        didSet {
            
            if trashIsActiv {
                trashNode.isHidden = false
                trashNode.removeAllActions()
                trashNode.run(SKAction.scale(to: CGSize(width: 50, height: 50), duration: 1))
                
            } else {
                trashNode.removeAllActions()
                trashNode.run(SKAction.scale(to: CGSize(width: 10, height: 10), duration: 1)) { [unowned self] in
                    trashNode.isHidden = true
                }
            }
        }
    }
    
    var isContactTrashAndSelectedNode = false {
        didSet {
            
            if isContactTrashAndSelectedNode {
                print("True")
                let trashActivAction = SKAction.scale(to: CGSize(width: 100,
                                                                 height: 100),
                                                      duration: 0.4)
                trashActivAction.timingMode = .easeInEaseOut
                
                trashNode.removeAllActions()
                trashNode.run(trashActivAction)
            } else {
                print("False")
                let trashNoActivAction = SKAction.scale(to: CGSize(width: 50,
                                                                   height: 50),
                                                        duration: 0.4)
                trashNoActivAction.timingMode = .easeInEaseOut
                
                trashNode.removeAllActions()
                trashNode.run(trashNoActivAction)
            }
        }
    }
    
    var lastRotation: CGFloat = 0
    
    var screenSize: CGSize {
        return view?.bounds.size ?? CGSize()
    }
    
    var cameraNode = SKCameraNode()
    
    var objectPlan = SKSpriteNode()
    
    var trashNode = SKSpriteNode()
    
    override func didMove(to view: SKView) {
        
        setupGestureRecognizer()
        
        guard !isLoaded else { return }
        
        backgroundColor = .white
        
        setupCamera()
        
        addObjectPlan()
        
        addWorkplaceInStartPosition()
        
        addTrash()
    }
    
    private func setupCamera () {
        cameraNode.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
        addChild(cameraNode)
        camera = cameraNode
    }
    private func setupGestureRecognizer() {
        let pinchGesture = UIPinchGestureRecognizer(target: self, action: #selector(pinch))
        view?.addGestureRecognizer(pinchGesture)
        pinchGesture.delegate = self
        
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(long))
        view?.addGestureRecognizer(longPressGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(rotation))
        view?.addGestureRecognizer(rotationGestureRecognizer)
        rotationGestureRecognizer.delegate = self
    }
    @objc func pinch (_ sender: UIPinchGestureRecognizer) {
        
        camera?.run(SKAction.scale(by: 1 / sender.scale, duration: 0))
        
        camera!.enumerateChildNodes(withName: "workplace") { node, _ in
            node.run(SKAction.scale(by: sender.scale, duration: 0))
        }
        
        sender.scale = 1
        
        guard sender.state == .ended else { return }
        
        print("end pinch")
        
        guard let unwrappedCameraXScale = camera?.xScale else { return }
        let cameraXScale = 1 / unwrappedCameraXScale
        
        if cameraXScale < 1 {
            
            let saveScaleAction = SKAction.scale(to: 1, duration: 0.3)
            saveScaleAction.timingMode = .easeInEaseOut
            camera?.run(saveScaleAction)
            
            camera!.enumerateChildNodes(withName: "workplace") { node, _ in
                node.run(saveScaleAction)
            }
        } else if cameraXScale > 3 {
            
            let cameraSaveScaleAction = SKAction.scale(to: 1 / 3, duration: 0.3)
            let workplaceSaveScaleAction = SKAction.scale(to: 3, duration: 0.3)
            cameraSaveScaleAction.timingMode = .easeInEaseOut
            workplaceSaveScaleAction.timingMode = .easeInEaseOut
            
            camera?.run(cameraSaveScaleAction)
            
            camera!.enumerateChildNodes(withName: "workplace") { node, _ in
                node.run(workplaceSaveScaleAction)
            }
            print(1 / (camera?.xScale ?? 0))
        }
    }
    @objc func long (_ sender: UILongPressGestureRecognizer) {
        let longTouchLocation = sender.location(in: self.view)
        
        //Тут надо сконвертить из координат View в координаты сцены, т.к. atPoint работает в координатах сцены, а
        // workplaceNode привязана к камере
        let convertedTouchLocation = convertPoint(fromView: longTouchLocation)
        
        let selectedNode = atPoint(convertedTouchLocation)
        
        if isEditModeOn {
            //Долгое нажатие на рабочее место в режиме редактирования
            switch sender.state {
            case .began:
                print("*began")
                
                tempSelectedNode = selectedNode
                
                tempBeganNodePosition = selectedNode.position
                
                if selectedNode.name == "workplace" || selectedNode.name == "workplaceOnThePlan" {
                    selectedNode.removeFromParent()
                    
                    selectedNode.zRotation = 0
                    
                    selectedNode.position = convertedTouchLocation
                    selectedNode.xScale = 1
                    selectedNode.yScale = 1
                    
                    addChild(selectedNode)
                    
                    trashIsActiv = true
                }
                
            case .changed:
                
                if selectedNode.name == "workplace" || selectedNode.name == "workplaceOnThePlan" {
                    selectedNode.position = convertedTouchLocation
                    
                    //Перед тем, как проверять, пересекла ли перемещаемая нода корзину, надо сконвертить в координаты cameraNode, т.к. корзина прилеплена на камере
                    
                    let convertedSelectedNodePosition = convert(selectedNode.position, to: cameraNode)
                    
                    if (trashNode.position.x - trashNode.size.width / 2) ... (trashNode.position.x + trashNode.size.width / 2)  ~= convertedSelectedNodePosition.x && (trashNode.position.y - trashNode.size.height / 2) ... (trashNode.position.y + trashNode.size.height / 2)  ~= convertedSelectedNodePosition.y {
                        
                        if !isContactTrashAndSelectedNode {
                            isContactTrashAndSelectedNode = true
                        }
                        
                    } else {
                        
                        if isContactTrashAndSelectedNode {
                            isContactTrashAndSelectedNode = false
                        }
                    }
                }
            case .ended:
                print("*ended")
                endPositionCheck (selectedNode: tempSelectedNode)
                
                trashIsActiv = false
                
            default:
                print("fail")
                
            }
        } else {
            //Долгое нажатие на рабочее место c отключенным режимом редактирования
            print("Select user profile")
            switch sender.state {
            case .began:
                print("Select user profile began .changed")
            case .changed:
                print("Select user profile long .changed")
            case .ended:
                print("Select user profile long .ended")
            default:
                break
            }
        }
    }
    @objc func rotation (_ sender: UIRotationGestureRecognizer) {
        let rotation = sender.rotation
        var originalRotation: CGFloat = 0
        
        switch sender.state {
        case .began:
            sender.rotation = lastRotation
            originalRotation = sender.rotation
        case .changed:
            camera?.zRotation = originalRotation + sender.rotation
            
            camera!.enumerateChildNodes(withName: "workplace") { node, _ in
                node.zRotation = -(originalRotation + sender.rotation)
            }
            
            trashNode.zRotation = -(originalRotation + sender.rotation)
            
            
        case .ended:
            lastRotation = rotation
        default:
            break
        }
        
    }
    
    private func endPositionCheck (selectedNode: SKNode) {
        print("endPositionCheck")
        //Если рабочее место, после перетаскивания находится на плане
        if (objectPlan.position.x - objectPlan.size.width / 2) ... (objectPlan.position.x + objectPlan.size.width / 2)  ~= selectedNode.position.x && (objectPlan.position.y - objectPlan.size.height / 2) ... (objectPlan.position.y + objectPlan.size.height / 2)  ~= selectedNode.position.y {
            print("positionOKGGG")
            
            if selectedNode.name == "workplace" {
                (selectedNode as? SKSpriteNode)?.size = CGSize(width: 15,
                                                               height: 15)
                selectedNode.run(SKAction.scale(by: 1, duration: 0)) { [unowned self] in
                    selectedNode.removeAllActions()
                    selectedNode.name = "workplaceOnThePlan"
                    selectedNode.alpha = 1
                    
                    addWorkplaceInStartPosition()
                    let newWorkplaceNode = cameraNode.childNode(withName: "workplace")
                    newWorkplaceNode?.zRotation = -(camera?.zRotation ?? 0)
                    newWorkplaceNode?.run(SKAction.scale(by: 1 / (camera?.xScale ?? 1), duration: 0))
                    
                    newWorkplaceNode?.isHidden = false
                    
                }
            }
           else if selectedNode.name == "workplaceOnThePlan" && isContactTrashAndSelectedNode {
                let downScaleAction = SKAction.scale(to: CGSize(width: 5,
                                                                height: 5),
                                                     duration: 1)
                downScaleAction.timingMode = .easeIn
                
                selectedNode.run(downScaleAction) {
                    selectedNode.removeFromParent()
                }
            }
           else if selectedNode.name == "workplaceOnThePlan" {
            (selectedNode as? SKSpriteNode)?.size = CGSize(width: 15,
                                                           height: 15
            )
            
            print("plan-plan")
           }
        } else {
            
            //Если рабочее место, после перетаскивания находится не на плане
            if selectedNode.name == "workplace" {
                
                let convertPositionToCamera = convert(selectedNode.position, to: cameraNode)
                selectedNode.removeFromParent()
                selectedNode.position = convertPositionToCamera
                cameraNode.addChild(selectedNode)
                let moveToStartPositionAction = SKAction.move(to: CGPoint(x: 0,
                                                                          y: screenSize.height / 2.4),
                                                              duration: 0.4)
                moveToStartPositionAction.timingMode = .easeInEaseOut
                selectedNode.run(moveToStartPositionAction)
                selectedNode.zRotation = -(camera?.zRotation ?? 0)
                (selectedNode as? SKSpriteNode)?.size = CGSize(width: 15,
                                                               height: 15)
                selectedNode.run(SKAction.scale(by: 1 / (camera?.xScale ?? 1), duration: 0))
            }
            else if selectedNode.name == "workplaceOnThePlan" {
                
                if isContactTrashAndSelectedNode {
                    let downScaleAction = SKAction.scale(to: CGSize(width: 5,
                                                                    height: 5),
                                                         duration: 1)
                    downScaleAction.timingMode = .easeIn
                    
                    selectedNode.run(downScaleAction) {
                        selectedNode.removeFromParent()
                    }
                    
                } else {
                    print("return to plan")
                    
                    (selectedNode as? SKSpriteNode)?.size = CGSize(width: 15,
                                                                   height: 15)
                    
                    let moveToBeganNodePositionAction = SKAction.move(to: tempBeganNodePosition,
                                                                      duration: 0.4)
                    moveToBeganNodePositionAction.timingMode = .easeInEaseOut
                    selectedNode.run(moveToBeganNodePositionAction)
                    
                }
            }
        }
    }
    
    private func addObjectPlan () {
        objectPlan = SKSpriteNode(texture: SKTexture(imageNamed: "objectPlan1"))
        
        let objectPlanInitialAspectRatio: CGFloat = objectPlan.size.height / objectPlan.size.width
        
        objectPlan.size.width = screenSize.width
        objectPlan.size.height = objectPlan.size.width * objectPlanInitialAspectRatio
        
        objectPlan.position = CGPoint(x: size.width / 2,
                                      y: size.height / 2)
        objectPlan.zPosition = 1
        
        addChild(objectPlan)
        
        //Создаем тень для плана
        
        let objectPlanShadow = SKSpriteNode(imageNamed: "objectPlanShadow")
        objectPlanShadow.size = CGSize(width: objectPlan.size.width + 65,
                                             height: objectPlan.size.height + 65)
        objectPlanShadow.zPosition = objectPlan.zPosition - 1
        objectPlan.addChild(objectPlanShadow)
        
    }
    private func addWorkplaceInStartPosition () {
        
        let workplaceNode = SKSpriteNode(texture: SKTexture(imageNamed: "workplace"),
                                         size: CGSize(width: 15,
                                                      height: 15))
        workplaceNode.zPosition = 4
        workplaceNode.position = CGPoint(x: 0,
                                         y: screenSize.height / 2.4)
        workplaceNode.alpha = 0.4
        workplaceNode.name = "workplace"
        workplaceNode.isHidden = true
        
        let scaleDownAction = SKAction.scale(by: 0.8, duration: 1.5)
        scaleDownAction.timingMode = .easeInEaseOut
        
        workplaceNode.run(SKAction.repeatForever(SKAction.sequence([scaleDownAction, scaleDownAction.reversed()])))
        cameraNode.addChild(workplaceNode)
    }
    
    private func addTrash () {
        trashNode = SKSpriteNode(texture: SKTexture(imageNamed: "trash"), size: CGSize(width: 10,
                                                                                       height: 10))
        trashNode.zPosition = 3
        trashNode.position = CGPoint(x: screenSize.width / 2.8,
                                     y: -screenSize.height / 4.2)
        trashNode.name = "trash"
        trashNode.isHidden = true
        
        cameraNode.addChild(trashNode)
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let previousTouchLocation = touches.first?.previousLocation(in: self),
              let touchLocation = touches.first?.location(in: self)
        else { return }
        
        let offsetX = touchLocation.x - previousTouchLocation.x
        let offsetY = touchLocation.y - previousTouchLocation.y
        
        camera?.position.x -= offsetX
        camera?.position.y -= offsetY
    }
    
}

extension ReservationOfWorkplacesScene: UIGestureRecognizerDelegate {
    
    //Разрешаем одновременную работу двух распознавателей жестов
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        true
    }
    
    
    
}

