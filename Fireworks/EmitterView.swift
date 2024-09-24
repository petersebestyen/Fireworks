//
//  EmitterView.swift
//  Fireworks
//
//  Created by Péter Sebestyén on 2024.09.24.
//

import SwiftUI

struct EmitterView: View {
    var particleSystem: ParticleSystem
    
    var body: some View {
        TimelineView(.animation) { timeline in
            Canvas { context, size  in
                let baseTransform = context.transform
                particleSystem.update(date: timeline.date)
                
                for particle in particleSystem.particles {
                    let xPos = particle.x * size.width
                    let yPos = particle.y * size.height
                    
                    context.translateBy(x: xPos, y: yPos)
                    context.scaleBy(x: particle.scale, y: particle.scale)
                    context.opacity = particle.opacity
                    context.draw(particleSystem.image, at: .zero)
                    context.transform = baseTransform
                }
            }
        }
    }
}

#Preview {
    EmitterView(particleSystem: ParticleSystem())
}
