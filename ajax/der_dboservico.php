<html>
  <head>
    <script type='text/javascript' src='https://www.google.com/jsapi'></script>
    <script type='text/javascript'>
     google.load('visualization', '1', {'packages': ['geochart']});
     google.setOnLoadCallback(drawMarkersMap);

      function drawMarkersMap() {
      var data = google.visualization.arrayToDataTable([
        ['Cidade',   'Venda', 'Devolução'],
        ['São Paulo',      1584,    31],
        ['Rio de Janeiro',     258,    36],
        ['Salvador',    2585,     36],
        ['Campinas',     190,     0],
        ['Porto Alegre',   5896,     548],
        ['Joinville',     8990,     242],
        ['Dois Vizinhos',   2596,     890],
        ['Curitiba',  3585,     25],
        ['União da Vitoria', 25487,      31],
        ['Capanema',     1259,      43],
        ['Toledo',  38262,      250]
		['Cascavel',  2569,      24]
		['Santa Izabel do Oeste',  2558,     45]
      ]);

      var options = {
        region: 'BR',
        displayMode: 'markers',
        colorAxis: {colors: ['green', 'blue']}
      };

      var chart = new google.visualization.GeoChart(document.getElementById('chart_div'));
      chart.draw(data, options);
    };
    </script>
  </head>
  
  
  <body>
    <div id="chart_div" style="width: 1200px; height: 800px;"></div>
  </body>
</html>