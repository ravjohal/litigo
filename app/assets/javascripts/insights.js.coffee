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

    #searchData = {
    #    state: $("#f_state").val()
    #    court: $("#f_court").val()
    #    injury_type: $("#f_injury").val()
    #    region: $("#f_region").val()
    #    insurer: $("#f_insuer").val()
    #  }

    $("#f_state option").each ->
      unless $(this).val() is ""
        mapData[$(this).val()] =
          fillKey: "Group1"
          average: 0

    unless casesData?
      $.ajax
        url: "/insights/filter_cases"
        async: false
        method: "get"
        data: {}
        success: (response) ->
          casesData = response
        error: ->
          console.log "Something failed"

    searchData = []
    # search data
    searchData = casesData.filter((n) ->
        state = true
        _state = $("#f_state").val()
        unless _state is ""
          state = n.state is _state

        court = true
        _court = $("#f_court").val()
        unless _court is ""
          court = n.court is _court

        injury_type = true
        _injury_type = $("#f_injury").val()
        unless _injury_type is ""
          if n.hasOwnProperty("medical")
            injury_type = n.medical.injuries.count((ijr) -> ijr.injury_type is _injury_type) > 0
          else
            injury_type = false

        region = true
        _region = $("#f_region").val()
        unless _region is ""
          if n.hasOwnProperty("medical")
            region = n.medical.injuries.count((ijr) -> ijr.region is _region) > 0
          else
            region = false

        insurer = true
        _insurer = $("#f_insuer").val()
        unless _insurer is ""
          if n.hasOwnProperty("medical")
            insurer = n.incident.insurance_provider is _insurer
          else
            insurer = false

        state and court and injury_type and region and insurer
      )

    tData = []
    total_count = searchData.length

    searchData.forEach (c, i) ->
      # bar Data
      if c.hasOwnProperty("resolution")
        if c.resolution.resolution_type is "settlement"
          pieData[0].value += 1
        else
          pieData[1].value += 1

        # line Data
        if c.resolution.resolution_amount?
          tData.push { value: parseFloat(c.resolution.resolution_amount), state: c.state, total: 1 }

    # rearrange line Data
    linq = Enumerable.From(tData)
    gData = linq.GroupBy((v) ->
      v.value
    ).Select((v) ->
      value: v.Key()
      total: v.Sum((t) ->
        t.total | 0
      )
    ).ToArray()
    line_result = gData.sort((a, b) ->
      a.value - b.value
    )

    lineData[0].values.push([0, 0])
    line_result.forEach (c, i) ->
      x_val = c.value
      x_val = 0 if x_val < 0
      y_val = parseFloat(c.total / total_count * 100)
      y_val = 0 if y_val < 0
      lineData[0].values.push([x_val, y_val]);

    # rearrange Map Data
    linq = Enumerable.From(tData)
    gData = linq.GroupBy((v) ->
      v.state
    ).Select((v) ->
      state: v.Key()
      cnt: v.Count()
      total: v.Sum((t) ->
        t.value | 0
      )
    ).ToArray()

    gData.forEach (c, i) ->
      unless c.state is ""
        mapData[c.state].average = (c.total / c.cnt).toFixed(2)
        mapData[c.state].fillKey = "Group2"

    renderChart()



renderChart = ->
  if total_count == 0
    $("#chart_container").hide()
    $("#notice").show()
    return
  else
    $("#notice").hide()
    $("#chart_container").show()

  colors = d3.scale.category20()
  keyColor = (d, i) ->
    colors d.key

  commasFormatter = d3.format(",.0f")

  nv.addGraph ->
    chart_line = nv.models.stackedAreaChart().margin(right: 100).x((d) ->
        d[0]
      ).y((d) ->
        d[1]
      )
      .rightAlignYAxis(false)
      .transitionDuration(500)
      .showControls(false)
      .clipEdge(true)
    
    #Format x-axis labels with custom function.
    #chart_line.xAxis.tickFormat d3.format(",.2f")
    chart_line.xAxis.tickFormat (d) ->
      unless d is 0
        "$" + commasFormatter(d)
      else
        ""

    chart_line.yAxis.tickFormat (d) ->
      unless d is 0
        commasFormatter(d) + "%"
      else
        ""

    chart_line.tooltips(true).tooltipContent((key, x, y, e, graph) ->
        "<p>" + x + "</p>"
      )

    d3.select("#stackedArea_chart svg").datum(lineData).call chart_line
    nv.utils.windowResize chart_line.update
    chart_line

  nv.addGraph ->
    chart_pie = nv.models.pieChart().x((d) -> #Configure how big you want the donut hole size to be.
      d.label
    ).y((d) ->
      d.value
    ).showLabels(true).labelThreshold(.05).labelType("percent").donut(true).donutRatio(0.35).tooltips(false)
    d3.select("#pie_chart svg").datum(pieData).transition().duration(350).call chart_pie
    chart_pie

  $("#map_chart").html("")
  map = new Datamap(
    element: document.getElementById("map_chart")
    scope: "usa"
    geographyConfig:
      # highlightBorderColor: "#bada55"
      popupTemplate: (geography, data) ->
        "<div class=\"hoverinfo\">" + geography.properties.name + " <br/>$" + data.average + " "
      highlightBorderWidth: 3
    fills:
      "Group1": "#C8C8C8"
      "Group2": "#A9C0DE"
      "Group3": "#CA5E5B"
      defaultFill: "#C8C8C8"
    data: mapData

  )