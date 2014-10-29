pieData = []
lineData = []
mapData = {}
casesData = null
searchData = null
total_count = 0
total_average = null
filter_average = null
avg_k = null
avg_k_f = null
avg_v = null
avg_vmax = 0
avg_index = 0
avg_index_f = 0

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
  avg_k_f = null
  avg_v = null
  avg_vmax = 0
  avg_index = 0
  avg_index_f = 0
  total_count = 0

$(document).ready ->
  $(document).on "click", "#btnFilterReset", ->
    $("#f_state").val("")
    $("#f_court").val("")
    $("#f_injury").val("")
    $("#f_region").val("")
    $("#f_insuer").val("")
    $("#f_judge").val("")
    $("#btnFilterSearch").click()

  $(document).on "click", "#btnFilterSearch", ->
    initDashboard()

    ajaxData = {
        state: $("#f_state").val()
        court: $("#f_court").val()
        injury_type: $("#f_injury").val()
        region: $("#f_region").val()
        insurer: $("#f_insuer").val()
        judge: $("#f_judge").val()
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
  total = 0
  $.each casesData.lines, (k, v) ->
    k = parseFloat(k)
    if k > max_limit
      k = max_limit
    total += k * v
    k = Math.round(k / increments)
    if searchData.hasOwnProperty(k)
      searchData[k] += v
    else
      searchData[k] = v

    avg_vmax = v if v > avg_vmax

  # average lines
  avg_k_f = Math.round(total / total_count)
  avg_v = 0

  $.each searchData, (k, v) ->
    # put line data
    k = parseInt(k) * increments
    lineData[0].values.push([k, v])

    if k >= avg_k_f and avg_index_f is 0
      avg_index_f = lineData[0].values.length

    if avg_k? and k >= avg_k and avg_index is 0
      avg_index = lineData[0].values.length

  if not avg_k?
    avg_k = avg_k_f
    avg_index = avg_index_f

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


  xScale = chart_line.xAxis.scale()
  yScale = chart_line.yAxis.scale()
  lineFunc = d3.svg.line().x((d) ->
    xScale d.x
  ).y((d) ->
    yScale d.y
  ).interpolate("linear")

  x1 = lineData[0].values[avg_index - 1]
  if avg_index is 1
    y1 = x1
  else
    y1 = lineData[0].values[avg_index - 2]

  # cp = checkLineIntersection(xScale(x1[0]), yScale(x1[1]), xScale(y1[0]), yScale(y1[1]), xScale(avg_k), yScale(0), xScale(avg_k), yScale(avg_vmax))
  cp = checkLineIntersection(x1[0], x1[1], y1[0], y1[1], avg_k, 0, avg_k, avg_vmax)

  avg_lines = [
    {
      x: cp.x
      y: 0
    }
    {
      x: cp.x
      y: cp.y
    }
  ]

  d3.select("#stackedArea_chart svg g")
    .append("svg:path")
    .attr("d", lineFunc(avg_lines))
    .attr("stroke", "white")
    .attr("stroke-width", 2)
    .attr("fill", "none")

  if avg_k_f isnt avg_k
    x1 = lineData[0].values[avg_index_f - 1]
    if avg_index_f is 1
      y1 = x1
    else
      y1 = lineData[0].values[avg_index_f - 2]
    
    cp = checkLineIntersection(x1[0], x1[1], y1[0], y1[1], avg_k_f, 0, avg_k_f, avg_vmax)
    avg_lines = [
      {
        x: cp.x
        y: 0
      }
      {
        x: cp.x
        y: cp.y
      }
    ]

    d3.select("#stackedArea_chart svg g")
      .append("svg:path")
      .attr("d", lineFunc(avg_lines))
      .attr("stroke", "black")
      .attr("stroke-width", 2)
      .attr("fill", "none")    

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

checkLineIntersection = (line1StartX, line1StartY, line1EndX, line1EndY, line2StartX, line2StartY, line2EndX, line2EndY) ->
  
  # if the lines intersect, the result contains the x and y of the intersection (treating the lines as infinite) and booleans for whether line segment 1 or line segment 2 contain the point
  denominator = undefined
  a = undefined
  b = undefined
  numerator1 = undefined
  numerator2 = undefined
  result =
    x: null
    y: null
    onLine1: false
    onLine2: false

  denominator = ((line2EndY - line2StartY) * (line1EndX - line1StartX)) - ((line2EndX - line2StartX) * (line1EndY - line1StartY))
  return result  if denominator is 0
  a = line1StartY - line2StartY
  b = line1StartX - line2StartX
  numerator1 = ((line2EndX - line2StartX) * a) - ((line2EndY - line2StartY) * b)
  numerator2 = ((line1EndX - line1StartX) * a) - ((line1EndY - line1StartY) * b)
  a = numerator1 / denominator
  b = numerator2 / denominator
  
  # if we cast these lines infinitely in both directions, they intersect here:
  result.x = line1StartX + (a * (line1EndX - line1StartX))
  result.y = line1StartY + (a * (line1EndY - line1StartY))
  
  #
  #                    // it is worth noting that this should be the same as:
  #                    x = line2StartX + (b * (line2EndX - line2StartX));
  #                    y = line2StartX + (b * (line2EndY - line2StartY));
  #                    
  
  # if line1 is a segment and line2 is infinite, they intersect if:
  result.onLine1 = true  if a > 0 and a < 1
  
  # if line2 is a segment and line1 is infinite, they intersect if:
  result.onLine2 = true  if b > 0 and b < 1
  
  # if line1 and line2 are segments, they intersect if both of the above are true
  result