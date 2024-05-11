//
//  PredatorDetail.swift
//  JPApexPredators
//
//  Created by Bogusz Kaszowski on 06/05/2024.
//

import SwiftUI
import MapKit

struct PredatorDetail: View {
    let predator: ApexPredator

    @State var position: MapCameraPosition

    var body: some View {
        GeometryReader { geo in
            ScrollView {
                ZStack(alignment: .bottomTrailing) {
                    Image(predator.type.rawValue)
                        .resizable()
                        .scaledToFit()
                        .overlay {
                            LinearGradient(stops: [
                                Gradient.Stop(color: .clear, location: 0.8),
                                Gradient.Stop(color: .black, location: 1)
                            ],
                                           startPoint: .top, endPoint: .bottom)
                        }
                    
                    Image(predator.image)
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width / 1.5)
                        .scaleEffect(x: -1)
                        .shadow(color: .black, radius: 7)
                        .offset(y: 10)
                        
                }
                VStack(alignment: .leading) {
                    Text(predator.name)
                        .font(.largeTitle)
                    
                    // current location
                    NavigationLink {
                        Image(predator.image)
                            .resizable()
                            .scaledToFit()
                    } label: {
                        Map(position: $position){
                            Annotation(
                                predator.name,
                                coordinate: predator.location) {
                                    Image(systemName: "mappin.and.ellipse")
                                        .font(.largeTitle)
                                        .imageScale(.large)
                                        .symbolEffect(.pulse)
                                }
                                .annotationTitles(.hidden)
                        }
                            .frame(height: 125)
                            .clipShape(.rect(cornerRadius: 15))
                            .overlay(alignment: .trailing) {
                                Image(systemName: "greaterthan")
                                    .imageScale(.large)
                                    .font(.title3)
                                    .padding(.trailing, 5)
                            }
                            .overlay(alignment: .topLeading) {
                                Text("Current Location")
                                    .padding([.leading, .bottom], 5)
                                    .padding(.trailing, 8)
                                    .background(.black.opacity(0.33))
                                    .clipShape(.rect(bottomTrailingRadius: 15))
                            }
                            .clipShape(.rect(cornerRadius: 15))
                    }
                    
                    // list of movie
                    Text("Appears in:")
                        .font(.title3)
                    
                    ForEach(predator.movies, id: \.self) { movie in
                        Text("•" + movie)
                            .font(.subheadline)
                    }
                    
                    Text("Movie Moments")
                        .font(.title)
                        .padding(.top, 15)
                    
                    ForEach(predator.movieScenes) { scene in
                        Text(scene.movie)
                            .font(.title2)
                            .padding(.vertical, 1)
                        Text(scene.sceneDescription)
                            .padding(.bottom, 15)
                    }
                    

                    Text("Read More:")
                        .font(.caption)
                    Link(predator.link, destination: URL(string: predator.link)!)
                        .font(.caption)
                        .foregroundStyle(.blue)
                
                }
                .padding()
                .padding(.bottom, 10)
                .frame(width: geo.size.width, alignment: .leading)
                
                    
                
              
            }
            .ignoresSafeArea()
            .toolbarBackground(.automatic)
        }
    }
    
        
}

#Preview {
    NavigationStack {
        PredatorDetail(predator: Predators().apexPredators[10], position: .camera(MapCamera(centerCoordinate: Predators().apexPredators[10].location, distance: 30000)))
            .preferredColorScheme(/*@START_MENU_TOKEN@*/.dark/*@END_MENU_TOKEN@*/)
    }
}
