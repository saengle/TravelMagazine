//
//  CityViewModel.swift
//  TravelMagazine
//
//  Created by 쌩 on 7/9/24.
//

import Foundation

class CityViewModel {
    
    var segmentInput = Observable(value: 0)
    var segFilteredList: [City] = []
    var searchedInput: Observable<String?> = Observable(value: "")
    var searchFilteredList: [City] = []
    var outputCities: Observable<[City]> = Observable(value: [])
    
    init() {
        segFilteredList = CityInfo.city
        searchFilteredList = CityInfo.city
        segmentInput.bind { value in
            self.segmentChanged(value)
        }
        searchedInput.bind { value in
            self.searchCity(value)
        }
    }
    private func segmentChanged(_ index: Int?) {
        switch index {
        case 0:
            segFilteredList = CityInfo.city
        case 1:
            segFilteredList = CityInfo.city.filter{$0.domestic_travel == true}
        case 2:
            segFilteredList = CityInfo.city.filter{$0.domestic_travel == false}
        default:
            print("segment has an Error")
        }
        makeOutputCities()
    }
    private func searchCity(_ keyWord: String?) {
        guard let keyWord = keyWord else { return }
        
        if keyWord.isEmpty {
            searchFilteredList = CityInfo.city
        } else {
            searchFilteredList = CityInfo.city.filter{$0.city_name.contains(keyWord) || $0.city_explain.contains(keyWord) || $0.city_english_name.lowercased().contains(keyWord.lowercased())}
        }
        makeOutputCities()
    }
    
    func makeOutputCities() {
        outputCities.value =  Array(Set(segFilteredList).intersection(Set(searchFilteredList)))
    }
}
