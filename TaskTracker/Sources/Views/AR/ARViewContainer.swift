import SwiftUI
import RealityKit
import ARKit

struct ARViewContainer: UIViewRepresentable {
    var isDone: Bool

    func makeUIView(context: Context) -> ARView {
        let arView = ARView(frame: .zero)

        let config = ARWorldTrackingConfiguration()
        config.planeDetection = [.horizontal]
        arView.session.run(config)

        show3DText(on: arView)

        return arView
    }

    func updateUIView(_ uiView: ARView, context: Context) {
        // Мұнда қажет болса ARView жаңартуларын жасаңыз
    }

    private func show3DText(on arView: ARView) {
        let text = isDone ? "🎉 Жарайсың!" : "👎 Келесіде жақсырақ!"

        let mesh = MeshResource.generateText(
            text,
            extrusionDepth: 0.05,
            font: .systemFont(ofSize: 0.15, weight: .bold),
            containerFrame: .zero,
            alignment: .center,
            lineBreakMode: .byWordWrapping
        )

        let material = SimpleMaterial(color: isDone ? .green : .red, isMetallic: false)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])

        modelEntity.position = SIMD3(x: 0, y: 0, z: -0.5)

        let anchor = AnchorEntity(world: .zero)
        anchor.addChild(modelEntity)
        arView.scene.addAnchor(anchor)

        modelEntity.scale = SIMD3(repeating: 0)
        modelEntity.move(to: Transform(scale: SIMD3(repeating: 0.3)), relativeTo: anchor, duration: 1.0)
    }
}
