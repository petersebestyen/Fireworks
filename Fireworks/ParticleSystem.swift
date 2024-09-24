//
//  ParticleSystem.swift
//  Fireworks
//
//  Created by Péter Sebestyén on 2024.09.24.
//

import SwiftUI

class ParticleSystem: ObservableObject {
    let image                       = Image("spark")
    var particles                   = Set<Particle>()
    var lastUpdate                  = Date()
    var lastCreationDate            = Date()
    
    @Published var xPosition        = 50.0
    @Published var yPosition        = 0.0
    @Published var xPositionRange   = 100.0
    @Published var yPositionRange   = 0.0

    @Published var angle            = 90.0
    @Published var angleRange       = 5.0

    @Published var speed            = 50.0
    @Published var speedRange       = 25.0
    
    @Published var opacity          = 50.0
    @Published var opacityRange     = 50.0
    @Published var opacitySpeed     = -10.0

    @Published var scale            = 100.0
    @Published var scaleRange       = 50.0
    @Published var scaleSpeed       = 10.0
    
    @Published var birthRate        = 10.0
    @Published var lifeTime         = 500.0
    @Published var lifeTimeRange    = 25.0
    
    func update(date: Date) {
        let elapsedTime = date.timeIntervalSince1970 - lastUpdate.timeIntervalSince1970
        lastUpdate = date
        
        for particle in particles {
            if particle.deathDate < date {
                particles.remove(particle)
                continue
            }
            
            particle.x += particle.speed * cos(particle.angle) / 100 * elapsedTime
            particle.y += particle.speed * sin(particle.angle) / 100 * elapsedTime
            particle.scale += scaleSpeed / 50 * elapsedTime
            particle.opacity += opacitySpeed / 50 * elapsedTime
        }
        // particles.insert(createPartical())
        let birthSpeed = 1 / birthRate
        let elapsedSinceCreation = date.timeIntervalSince1970 - lastCreationDate.timeIntervalSince1970
        let amountToCreate = Int(elapsedSinceCreation / birthSpeed)
        
        for i in 0..<amountToCreate {
            particles.insert(createPartical())
            
            if i == 0 {
                lastCreationDate = date
            }
        }
    }
    
    private func createPartical() -> Particle {
        let angleDegrees = angle + Double.random(in: -angleRange / 2...angleRange / 2)
        let angleRadians = angleDegrees * .pi / 180
        
        return Particle(x: xPosition / 100 + Double.random(in: -xPositionRange / 200...xPositionRange / 200),
                        y: yPosition / 100 + Double.random(in: -yPositionRange / 200...yPositionRange / 200),
                        angle: angleRadians,
                        speed: speed + Double.random(in: -speedRange / 2...speedRange / 2),
                        scale: scale / 100 + Double.random(in: -scaleRange / 200...scaleRange / 200),
                        opacity: opacity / 100 + Double.random(in: -opacityRange / 200...opacityRange / 200),
                        deathDate: Date() + lifeTime / 100 + Double.random(in: -lifeTimeRange / 200...lifeTimeRange / 200)
        )
    }
}
