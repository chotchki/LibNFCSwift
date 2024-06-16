//
//  File.swift
//  
//
//  Created by Christopher Hotchkiss on 6/16/24.
//

import Foundation
@testable import LibNFCSwiftAsync

@MainActor
final class SlideshowTests: XCTestCase {
    func testSlideshowNoAlbum() async {
        let clock = TestClock()

        let store = TestStore(
                initialState: Slideshow.State(
                        slideShowAlbumId: Shared(nil),
                        viewSizeForImage: Shared(CGSize(width: 100, height: 100))
                )
        ) {
            Slideshow()
        } withDependencies: {
            $0.continuousClock = clock
        }

        await store.send(.startSlideshow)
        await clock.advance(by: .seconds(Slideshow.imageDuration))
        await store.receive(\.loadAlbumMetadata)
        await store.receive(\.loadNextImage)
        await store.receive(.loadError("Unable to load configured album.")){
            $0.viewError = "Unable to load configured album."
        }
        
        await store.send(.viewTapped)
        await store.receive(.delegate(.returnToPriorScreen))

        await store.finish()
    }
