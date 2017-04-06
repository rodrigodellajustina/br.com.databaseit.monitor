<?php
	
	$dbHost 	= "localhost";
	$dbuser 	= "postgres";
	$dbpass 	= "pgsql";
    $dbdatabase = "paladino";
	$dbport     = "5495";
	
	$Conexao = @pg_connect("host=$dbHost user=$dbuser password=$dbpass dbname=$dbdatabase port=$dbport");			
	
?>


<html xmlns="http://www.w3.org/1999/xhtml" lang="pt-br" xml:lang="pt-br">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1" />
 <title>Information Manager Dawem - So Servico</title>
		<meta name="description" content="description">
		<meta name="author" content="DevOOPS">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<link href="plugins/bootstrap/bootstrap.css" rel="stylesheet">
		<link href="plugins/jquery-ui/jquery-ui.min.css" rel="stylesheet">
		<link href="http://netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
		<link href='http://fonts.googleapis.com/css?family=Righteous' rel='stylesheet' type='text/css'>
		<link href="plugins/fancybox/jquery.fancybox.css" rel="stylesheet">
		<link href="plugins/fullcalendar/fullcalendar.css" rel="stylesheet">
		<link href="plugins/xcharts/xcharts.min.css" rel="stylesheet">
		<link href="plugins/select2/select2.css" rel="stylesheet">
		<link href="css/style.css" rel="stylesheet">
		

</head>

<div class="row">
	<div id="breadcrumb" class="col-md-12">
		<ol class="breadcrumb">
			<li><a href="#">Notas</a></li>
			<li><a href="#">NFE-e</a></li>
			<li><a href="#">Pendentes</a></li>
		</ol>
	</div>
</div>



<h4 class="page-header">Notas Pendentes Paladino</h4>
	

<div class="box-content no-padding">
				<table class="table table-bordered table-striped table-hover table-heading table-datatable" id="datatable-1">
					<thead>
						<tr>
							<th>Cliente</th>
							<th>Quantidade</th>
							<th>Data</th>
						</tr>
					</thead>
					<tbody>
					<!-- Start: list_row -->
						<tr>
							<td><?PHP echo "teste" ?></td>
							<td>1584</a></td>
							<td>300</td>
						</tr>
						<tr>
							<td>Rio de Janeiro</td>
							<td>1584</a></td>
							<td>300</td>
						</tr>
						<tr>
							<td>União da Vitória</td>
							<td>1584</a></td>
							<td>300</td>
						</tr>
						<tr>
							<td>Cascavel</td>
							<td>3589</a></td>
							<td>300</td>
						</tr>
						<tr>
							<td>Dois Vizinhos</td>
							<td>1584</a></td>
							<td>300</td>
						</tr>
					<!-- End: list_row -->
					</tbody>
					<tfoot>
						<tr>
							<th>Cidade</th>
							<th>Venda</th>
							<th>Devolução</th>
						</tr>
					</tfoot>
				</table>
			</div>

			


<script type="text/javascript">
// Run Datables plugin and create 3 variants of settings
function AllTables(){
	TestTable1();
	TestTable2();
	TestTable3();
	LoadSelect2Script(MakeSelect2);
}
function MakeSelect2(){
	$('select').select2();
	$('.dataTables_filter').each(function(){
		$(this).find('label input[type=text]').attr('placeholder', 'Buscar');
	});
}
$(document).ready(function() {
	// Load Datatables and run plugin on tables 
	LoadDataTablesScripts(AllTables);
	// Add Drag-n-Drop feature
	WinMove();
});


</script>


</html>