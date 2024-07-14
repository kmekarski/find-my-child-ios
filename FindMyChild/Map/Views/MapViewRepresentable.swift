//
//  MapViewRepresentable.swift
//  FindMyChild
//
//  Created by klaudiuszmekarski on 12/06/2024.
//

import SwiftUI
import MapKit

struct MapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    
    var mapVM: MapViewModel
    var homeVM: HomeViewModel
    
    init(mapVM: MapViewModel, homeVM: HomeViewModel) {
        self.mapVM = mapVM
        self.homeVM = homeVM
    }
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsCompass = false
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapVM.currentState {
        case .initial:
            let children = homeVM.children
            let childrenData = homeVM.childrenData
            context.coordinator.addAnnotations(children: children, childrenData: childrenData)
            mapVM.go(to: .annotationsAdded)
        case .annotationsAdded:
            break
        }
    }
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension MapViewRepresentable {
    
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        var parent: MapViewRepresentable
        
        // MARK: - Lifecycle
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard let childAnnotation = annotation as? ChildAnnotation else { return nil }
            let childAnnotationView = ChildAnnotationView(annotation: childAnnotation, reuseIdentifier: "childAnnotation")
            return childAnnotationView
        }
        
        func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
            let selectedAnnotations = mapView.selectedAnnotations
            for annotation in selectedAnnotations {
                mapView.deselectAnnotation(annotation, animated: false)
            }
            
            if let childAnnotationView = view as? ChildAnnotationView,
               let childAnnotation = childAnnotationView.annotation as? ChildAnnotation {
                parent.homeVM.selectedChild = childAnnotation.child
            }
        }
        
        func addAnnotations(children: [Child], childrenData: [ChildData]) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            childrenData.indices.forEach { index in
                let child = children[index]
                if let childCoordinate = childrenData[index].coordinate {
                    let childAnnotation = ChildAnnotation(child: child, coordinate: childCoordinate)
                    parent.mapView.addAnnotation(childAnnotation)
                }
            }
        }
    }
}

class ChildAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let child: Child
    
    init(child: Child, coordinate: CLLocationCoordinate2D) {
        self.child = child
        self.coordinate = coordinate
    }
}

class ChildAnnotationView: MKAnnotationView {
    private var hostingController: UIHostingController<ChildMapPinView>?
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        self.annotation = annotation
        if let annotation = annotation as? ChildAnnotation {
            let customView = ChildMapPinView(child: annotation.child, isSelected: false)
            let hostingController = UIHostingController(rootView: customView)
            self.hostingController = hostingController
            self.frame.size.width = 100
            self.frame.size.height = 96
            self.addSubview(hostingController.view)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        hostingController?.view.removeFromSuperview()
        hostingController = nil
    }
}
