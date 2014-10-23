pieData = []
lineData = []
mapData = {}

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

$(document).ready ->
  $(document).on "click", "#btnFilterReset", ->
    initDashboard()

    $("#f_state option").each ->
      unless $(this).val() is ""
        mapData[$(this).val()] =
          fillKey: "Group1"
          average: 0

    $.ajax
      url: "/insights/filter_cases"
      method: "get"
      data: {
        state: $("#f_state").val()
        court: $("#f_court").val()
        injury_type: $("#f_injury").val()
        region: $("#f_region").val()
        insurer: $("#f_insuer").val()
      }
      success: (response) ->
        console.log response

        tData = []
        total_count = response.length

        response.forEach (c, i) ->
          # bar Data
          if c.hasOwnProperty("resolution")
            if c.resolution.resolution_type is "settlement"
              pieData[0].value += 1
            else
              pieData[1].value += 1

            # line Data
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
          lineData[0].values.push([c.value, parseFloat(c.total / total_count * 100)]);

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
        console.log "HEHE"
        gData.forEach (c, i) ->
          unless c.state is ""
            mapData[c.state].average = (c.total / c.cnt).toFixed(2)
            mapData[c.state].fillKey = "Group2"

        renderChart()

      error: ->
        console.log "Something failed"

renderChart = ->
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