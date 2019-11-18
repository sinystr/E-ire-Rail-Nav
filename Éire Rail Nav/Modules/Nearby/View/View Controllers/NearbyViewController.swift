import FloatingPanel
import Foundation
import MapKit
import UIKit
import JGProgressHUD

@objc class NearbyViewController: UIViewController, FloatingPanelControllerDelegate, NearbyViewProtocol {
    @IBOutlet var mapView: MKMapView!
    let nearbyDistance: CLLocationDistance = 20000
    let irelandMapDistance: CLLocationDistance = 400000
    var loadingIndicator:JGProgressHUD?

    @objc public var presenter: NearbyPresenterProtocol?
    private var nearbyEntitiesView: NearbyEntitiesViewProtocol?
    private var fpc: FloatingPanelController!

    override func viewDidLoad() {
        fpc = FloatingPanelController()
        fpc.surfaceView.backgroundColor = UIColor.clear
        fpc.delegate = self
        let nearbyEntitiesViewController = NearbyEntitiesViewController(nibName: "NearbyEntitiesViewController", bundle: nil)
        nearbyEntitiesViewController.nearbyView = self
        fpc.set(contentViewController: nearbyEntitiesViewController)
        fpc.track(scrollView: nearbyEntitiesViewController.tableView!)
        nearbyEntitiesView = nearbyEntitiesViewController
    }

    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: animated)
        fpc.addPanel(toParent: self)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        fpc?.removePanelFromParent(animated: false)
    }

    func showOnMap(stations: [StationModel]) {
        for station in stations {
            let annotation = MKPointAnnotation()
            annotation.title = station.name
            annotation.coordinate = CLLocationCoordinate2D(latitude: station.latitude, longitude: station.longtitude)
            mapView.addAnnotation(annotation)
        }
    }

    func showNearbyMap(){
        let location = LocationManager.getCurrentLocation()
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                        latitudinalMeters: nearbyDistance, longitudinalMeters: nearbyDistance)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showIrelandMap(){
        let location = CLLocation(latitude: 52.3623828, longitude: -7.8074785)
        let coordinateRegion = MKCoordinateRegion(center: location.coordinate,
                                                        latitudinalMeters: irelandMapDistance, longitudinalMeters: irelandMapDistance)
        mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func showLoadingIndicator() {
        self.loadingIndicator = JGProgressHUD(style: .extraLight)
        self.loadingIndicator!.textLabel.text = "Loading"
        self.loadingIndicator!.show(in: self.view)
    }

    func hideLoadingIndicator() {
        self.loadingIndicator?.dismiss()
    }

    // MARK: Display data methods

    func showNearbyRoutes(_ routes: [RouteModel], andStations stations: [StationModel]) {
        nearbyEntitiesView?.showNearbyRoutes(routes, andStations: stations)
        showOnMap(stations: stations)
        self.showNearbyMap();
    }

    func showAllRoutes(_ routes: [RouteModel]) {
        nearbyEntitiesView?.showAllRoutes(routes)
    }

    func showAllStations(_ stations: [StationModel]) {
        showOnMap(stations: stations)
        self.showIrelandMap()
        nearbyEntitiesView?.showAllStations(stations)
    }

    // MARK: Actions

    func showAllRoutesAction() {
        presenter?.showAllRoutesAction()
    }

    func showAllStationsAction() {
        presenter?.showAllStationsAction()
    }

    func addRouteAction() {
        presenter?.addRouteAction()
    }

    func showRouteDetailsAction(_ route: RouteModel) {
        presenter?.showRouteDetailsAction(route)
    }

    func showStationDetailsAction(_ station: StationModel) {
        presenter?.showStationDetailsAction(station)
    }

    func showNearbyRoutesAndStationsAction() {
        presenter?.showNearbyRoutesAndStationsAction()
    }
}
