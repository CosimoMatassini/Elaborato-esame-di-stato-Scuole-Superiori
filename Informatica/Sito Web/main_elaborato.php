<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="stile.css?<?php echo time(); ?>" type="text/css">	<!-- importo il file css esterno nel modo in cui possa aggiornarsi ogni volta -->
	<title>Sistema Sanitario</title>
</head>
<body>
	<h1>SISTEMA SANITARIO</h1>
	<h1>Esecuzione Interrogazioni:</h1>

	<?php
		include 'connessione.php';	//connessione al server MySQL
	?>

	<div>
		<fieldset>
			<legend>Scegliere la query desiderata:</legend>
			<form action="query_elaborato.php" method="get">
				<!-- Ogni label è cliccabile per selezionare i bottoni radio -->
				<input type="radio" name="sceltaquery" value="1" id="button1" checked>	<!-- prima opzione -->
				<label for="button1"> Elenco patologie dei pazienti per ogni medico</label>	<!-- label prima opzione -->
				<br>
				<input type="radio" name="sceltaquery" value="2" id="button2">	<!-- seconda opzione -->
				<label for="button2"> Farmaci maggiormente richiesti</label>	<!-- label seconda opzione -->
				<br>
				<input type="radio" name="sceltaquery" value="3" id="button3">	<!-- terza opzione -->
				<label for="button3"> Persone rientranti nel codice di esenzione non per malattie asmatiche</label> 	<!-- label terza opzione -->
				<br>
				<div>
					<input type="submit" value="Conferma">	<!-- bottone di conferma -->
				</div>
			</form>
		</fieldset>
	</div>

	<footer>
		<hr>
  		<p>
			Autore: Cosimo Matassini<br>
			Classe 5°Bif<br>
			Elaborato Maturità 2021<br>
			ITT Galileo Ferraris<br>
			ISIS Valdarno<br>
		</p>
	</footer>
</body>
</html>