pieData = []
lineData = []
mapData = {}
casesData = null
searchData = null
total_count = 0

initDashboard = ->
  pieData = [
    {
      label: "SETTLEMENTS"
      value: 0
    }
    {
      label: "JURY VERDICTS"
      value: 0
    }
  ]

  lineData = [
    key: "Case"
    values: [
    ]
  ]

  mapData = {}

  total_count = 0

$(document).ready ->
  $(document).on "click", "#btnFilterReset", ->
    $("#f_state").val("")
    $("#f_court").val("")
    $("#f_injury").val("")
    $("#f_region").val("")
    $("#f_insuer").val("")
    $("#btnFilterSearch").click()

  $(document).on "click", "#btnFilterSearch", ->
    initDashboard()

    ajaxData = {
        state: $("#f_state").val()
        court: $("#f_court").val()
        injury_type: $("#f_injury").val()
        region: $("#f_region").val()
        insurer: $("#f_insuer").val()
      }

    $("#f_state option").each ->
      unless $(this).val() is ""
        mapData[$(this).val()] =
          fillKey: "Group1"
          average: 0

    $.ajax
      url: "/insights/filter_cases"
      method: "get"
      data: ajaxData
      success: (response) ->
        console.log response
        casesData = response
        initData()
      error: ->
        console.log "Something failed"


initData = ->
  total_count = casesData.totals
  
  max_limit = 100000
  increments = 1000
  searchData = {}
  $.each casesData.lines, (k, v) ->
    k = parseFloat(k)
    if k > max_limit
      k = max_limit
    k = Math.round(k / increments)
    if searchData.hasOwnProperty(k)
      searchData[k] += v
    else
      searchData[k] = v

  $.each searchData, (k, v) ->
    lineData[0].values.push([parseInt(k) * increments, v])

  # pie Data
  pieData[0].value = casesData.pie.Settlement if casesData.pie.hasOwnProperty("Settlement")
  pieData[1].value = casesData.pie.Verdict if casesData.pie.hasOwnProperty("Verdict")

  # rearrange Map Data
  $.each casesData.map, (k, v) ->
    mapData[k].average = parseFloat(v).toFixed(2)
    mapData[k].fillKey = "Group2"

  renderChart()

renderChart = ->
  if total_count == 0
    $("#chart_container").hide()
    $("#notice").show()
    return
  else
    $("#notice").hide()
    $("#chart_container").show()

  $("#stackedArea_chart svg").empty()
  $("#pie_chart svg").empty()
  $("#map_chart").empty()

  colors = d3.scale.category20()
  keyColor = (d, i) ->
    colors d.key

  commasFormatter = d3.format(",.0f")
  chart_line = null
  chart_line = nv.models.stackedAreaChart().margin(right: 100).x((d) ->
      d[0]
    ).y((d) ->
      d[1]
    )
    .rightAlignYAxis(false)
    .transitionDuration(500)
    .showControls(false)
    .clipEdge(true)
    .interpolate("monotone")
  
  #chart_line.xAxis.tickFormat d3.format(",.2f")
  chart_line.xAxis.tickFormat (d) ->
    unless d is 0
      "$" + commasFormatter(d)
    else
      ""

  chart_line.yAxis.tickFormat (d) ->
    unless d is 0
      commasFormatter(d)
    else
      ""

  chart_line.tooltips(true).tooltipContent((key, x, y, e, graph) ->
      "<p>" + x + "</p>"
    )
  d3.select("#stackedArea_chart svg").datum(lineData).call chart_line


  chart_pie = nv.models.pieChart().x((d) -> #Configure how big you want the donut hole size to be.
    d.label
  ).y((d) ->
    d.value
  ).showLabels(true).labelThreshold(.05).labelType("percent").donut(true).donutRatio(0.35).tooltips(false)
  d3.select("#pie_chart svg").datum(pieData).transition().duration(350).call chart_pie


  cur_format = d3.format(",.2f")
  
  map = new Datamap(
    element: document.getElementById("map_chart")
    scope: "usa"
    geographyConfig:
      # highlightBorderColor: "#bada55"
      popupTemplate: (geography, data) ->
        "<div class=\"hoverinfo\">" + geography.properties.name + " <br/>$" + cur_format(parseFloat(data.average)) + " "
      highlightBorderWidth: 3
    fills:
      "Group1": "#C8C8C8"
      "Group2": "#A9C0DE"
      "Group3": "#CA5E5B"
      defaultFill: "#C8C8C8"
    data: mapData

  )