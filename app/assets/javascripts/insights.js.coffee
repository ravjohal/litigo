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

$(document).ready ->
  $("#btnFilterReset").click ->
    $.ajax
      url: "/insights/filter_cases"
      method: "get"
      data: {}
      success: (response) ->
        console.log response

        tData = []
        total_count = response.length

        response.forEach (c, i) ->
          # bar Data
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
        console.log line_result

        lineData[0].values.push([0, 0])
        line_result.forEach (c, i) ->
          lineData[0].values.push([c.value, parseFloat(c.total / total_count * 100)]);

        console.log lineData
        renderChart()

      error: ->
        console.log "Something failed"

getLineData = ->
  data = [
    key: "Consumer Discretionary"
    values: [
      [
        1138683600000
        27.38478809681
      ]
      [
        1141102800000
        27.371377218208
      ]
      [
        1143781200000
        26.309915460827
      ]
      [
        1146369600000
        26.425199957521
      ]
      [
        1149048000000
        26.823411519395
      ]
      [
        1151640000000
        23.850443591584
      ]
      [
        1154318400000
        23.158355444054
      ]
      [
        1156996800000
        22.998689393694
      ]
      [
        1159588800000
        27.977128511299
      ]
      [
        1162270800000
        29.073672469721
      ]
      [
        1164862800000
        28.587640408904
      ]
      [
        1167541200000
        22.788453687638
      ]
      [
        1170219600000
        22.429199073597
      ]
      [
        1172638800000
        22.324103271051
      ]
      [
        1175313600000
        17.558388444186
      ]
      [
        1177905600000
        16.769518096208
      ]
      [
        1180584000000
        16.214738201302
      ]
      [
        1183176000000
        18.729632971228
      ]
      [
        1185854400000
        18.814523318848
      ]
      [
        1188532800000
        19.789986451358
      ]
      [
        1191124800000
        17.070049054933
      ]
      [
        1193803200000
        16.121349575715
      ]
      [
        1196398800000
        15.141659430091
      ]
      [
        1199077200000
        17.175388025298
      ]
      [
        1201755600000
        17.286592443521
      ]
      [
        1204261200000
        16.323141626569
      ]
      [
        1206936000000
        19.231263773952
      ]
      [
        1209528000000
        18.446256391094
      ]
      [
        1212206400000
        17.822632399764
      ]
      [
        1214798400000
        15.539366475979
      ]
      [
        1217476800000
        15.255131790216
      ]
      [
        1220155200000
        15.660963922593
      ]
      [
        1222747200000
        13.254482273697
      ]
      [
        1225425600000
        11.920796202299
      ]
      [
        1228021200000
        12.122809090925
      ]
      [
        1230699600000
        15.691026271393
      ]
      [
        1233378000000
        14.720881635107
      ]
      [
        1235797200000
        15.387939360044
      ]
      [
        1238472000000
        13.765436672229
      ]
      [
        1241064000000
        14.6314458648
      ]
      [
        1243742400000
        14.292446536221
      ]
      [
        1246334400000
        16.170071367016
      ]
      [
        1249012800000
        15.948135554337
      ]
      [
        1251691200000
        16.612872685134
      ]
      [
        1254283200000
        18.778338719091
      ]
      [
        1256961600000
        16.75602606542
      ]
      [
        1259557200000
        19.385804443147
      ]
      [
        1262235600000
        22.950590240168
      ]
      [
        1264914000000
        23.61159018141
      ]
      [
        1267333200000
        25.708586989581
      ]
      [
        1270008000000
        26.883915999885
      ]
      [
        1272600000000
        25.893486687065
      ]
      [
        1275278400000
        24.678914263176
      ]
      [
        1277870400000
        25.937275793023
      ]
      [
        1280548800000
        29.46138169384
      ]
      [
        1283227200000
        27.357322961862
      ]
      [
        1285819200000
        29.057235285673
      ]
      [
        1288497600000
        28.549434189386
      ]
      [
        1291093200000
        28.506352379723
      ]
      [
        1293771600000
        29.449241421597
      ]
      [
        1296450000000
        25.796838168807
      ]
      [
        1298869200000
        28.740145449189
      ]
      [
        1301544000000
        22.091744141872
      ]
      [
        1304136000000
        25.079662545409
      ]
      [
        1306814400000
        23.674906973064
      ]
      [
        1309406400000
        23.41800274293
      ]
      [
        1312084800000
        23.243644138871
      ]
      [
        1314763200000
        31.591854066817
      ]
      [
        1317355200000
        31.497112374114
      ]
      [
        1320033600000
        26.672380820431
      ]
      [
        1322629200000
        27.297080015495
      ]
      [
        1325307600000
        20.174315530051
      ]
      [
        1327986000000
        19.631084213899
      ]
      [
        1330491600000
        20.366462219462
      ]
      [
        1333166400000
        17.429019937289
      ]
      [
        1335758400000
        16.75543633539
      ]
      [
        1338436800000
        16.182906906042
      ]
    ]
  ]
  data

renderChart = ->
  colors = d3.scale.category20()
  keyColor = (d, i) ->
    colors d.key

  nv.addGraph ->
    chart_line = nv.models.stackedAreaChart().margin(right: 100).x((d) ->
      d[0]
    ).y((d) ->
      d[1]
    ).useInteractiveGuideline(true).rightAlignYAxis(false).transitionDuration(500).showControls(false).clipEdge(true)
    
    #Format x-axis labels with custom function.
    #chart_line.xAxis.tickFormat (d) ->
    #  d3.time.format("%x") new Date(d)
    chart_line.xAxis.tickFormat d3.format(",.2f")

    chart_line.yAxis.tickFormat d3.format(",.2f")
    d3.select("#stackedArea_chart svg").datum(lineData).call chart_line
    nv.utils.windowResize chart_line.update
    chart_line

  nv.addGraph ->
    chart_pie = nv.models.pieChart().x((d) -> #Configure how big you want the donut hole size to be.
      d.label
    ).y((d) ->
      d.value
    ).showLabels(true).labelThreshold(.05).labelType("percent").donut(true).donutRatio(0.35)
    d3.select("#pie_chart svg").datum(pieData).transition().duration(350).call chart_pie
    chart_pie

  map = new Datamap(
    element: document.getElementById("map_chart")
    scope: "usa"
  )