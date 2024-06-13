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
    
    @EnvironmentObject var mapStateManager: MapStateManager
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
        mapView.showsCompass = false
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        switch mapStateManager.current {
        case .initial:
            context.coordinator.addAnnotations()
            mapStateManager.go(to: .annotationsAdded)
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
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        var polylines: [MKPolyline] = []
        var polylineRenderers: [MKPolylineRenderer] = []
        var overlayCopies: [MKOverlay] = []
        
        // MARK: - Lifecycle
        
        init(parent: MapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
            let center = CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude)
            let span = MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
            let region = MKCoordinateRegion(
                center: center,
                span: span)
            
            if self.currentRegion == nil {
                parent.mapView.setRegion(region, animated: true)
            }
            
            self.currentRegion = region
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
            guard !(annotation is MKUserLocation) else { return nil }
            guard let title = annotation.title else { return nil }

            let customPinView: UIView

            if title == "customPin" {
                customPinView = UIHostingController(rootView: CustomMapPinView()).view
            } else {
                customPinView = UIHostingController(rootView: CustomMapPinView()).view
            }

            let annotationView = MKAnnotationView(annotation: annotation, reuseIdentifier: "customPin")
            annotationView.addSubview(customPinView)

            return annotationView
        }

        
        func mapView(_ mapView: MKMapView, rendererFor overlay: MKOverlay) -> MKOverlayRenderer {
            if let polyline = overlay as? MKPolyline {
                let polyLineRenderer = MKPolylineRenderer(overlay: polyline)
                polyLineRenderer.strokeColor = .blue
                polyLineRenderer.lineWidth = 7
                polylineRenderers.append(polyLineRenderer)
                return polyLineRenderer
            }
            return MKOverlayRenderer(overlay: overlay)
        }
        
        func addAnnotations(coordinate: CLLocationCoordinate2D? = CLLocationCoordinate2D(latitude: 52, longitude: 21)) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let annotation = MKPointAnnotation()
            if let coordinate = coordinate {
                annotation.coordinate = coordinate
                annotation.title = "customPin"
                parent.mapView.addAnnotation(annotation)
            }
        }
    }
}
