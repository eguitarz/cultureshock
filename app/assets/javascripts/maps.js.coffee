convertSymbol = (name)->
  if name && name.substr(0,1).match /[a-zA-Z]/
    return name.toLowerCase()[0]
  else
    return 'circle'

convertColor = (sex)->
  if sex == '女'
    return '#f86767'
  else
    return '#1087bf'

$(document).on 'page:change', ->
  L.mapbox.accessToken = 'pk.eyJ1IjoiZWd1aXRhcnoiLCJhIjoiM0h4WFlDYyJ9.6gw0kHIYT7hX8C3eLfbgxA'
  map = L.mapbox.map('map', 'eguitarz.le8ak54c')

  CONTACTS_URL = '/contacts.json'
  $.get(CONTACTS_URL).done (contacts)->
    contacts.forEach (c)->
      longitude = c.longitude || 0
      longitude += Math.random()*10 % 0.5
      latitude = c.latitude || 90
      latitude += Math.random()*10 % 0.5
      L.mapbox.featureLayer({
        type: 'Feature',
        geometry: {
            type: 'Point',
            coordinates: [
              longitude,
              latitude
            ]
        },
        properties: {
            title: c.name,
            description: c.introduction,
            'marker-size': 'large',
            'marker-color': convertColor(c.sex),
            'marker-symbol': convertSymbol(c.name)
        }
      }).addTo(map);