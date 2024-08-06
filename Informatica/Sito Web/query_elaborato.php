<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<link rel="stylesheet" href="stile.css?<?php echo time(); ?>" type="text/css"> 	<!-- importo il foglio di stile -->
	<title>Sistema Sanitario</title>
</head>
<body>
	<h1>SISTEMA SANITARIO</h1>
	<h1>Risultati Query:</h1>
	<table align="center">	<!-- Tabella giustificata al centro -->
		<tr id="tableheader">	<!-- riga dei nomi delle colonne -->
	<?php
		include 'connessione.php';	//connessione al server MySQL

		//in base al valore di $_GET['sceltaquery'] viene assegnata la query a $query
		switch ($_GET['sceltaquery'])	
		{
			case 1:
				$query = "	SELECT Medici.cognome AS 'Cognome Medico', Medici.nome AS 'Nome Medico', Patologie.nome AS 'Nome patologia', tipologia AS Tipologia
							FROM Medici INNER JOIN Patologie USING (id_Medico)
							ORDER BY Medici.cognome, Medici.nome, Patologie.nome;";
				break;

			case 2:
				$query = "	SELECT nome AS 'Farmaco', n_richieste AS 'Numero richieste'
							FROM farmaci
							WHERE n_richieste = (SELECT MAX(n_richieste) FROM farmaci);";
				break;

			case 3:
				$query = "	SELECT COUNT(id_paziente) AS 'Numero pazienti'
							FROM Patologie INNER JOIN patologie_pazienti USING (id_patologia)
							WHERE esenzione = True AND nome != 'Asma';";
				break;
		}

		$result = $conn->query($query);	//esecuzione query

		$flag = 0;	//controllo se non è stato stampata la tabella 
		while($row = $result->fetch_assoc())	//elaborazione singolo record
		{
			if ($flag == 0)	//solamente la prima volta
			{
				$nomicolonne = array_keys($row);	//ritorna i nomi delle colonne
				foreach ($nomicolonne as $value)	//ciclo per tutto l'array
					echo "<th>$value</th>";			//stampo il valore header della colonna
				echo"</tr>";						//fine riga
				$flag = 1;							//informo che è già stato eseguito questo blocco di codice
			}
			echo "<tr>";							//inizio riga
			foreach ($row as $value)				//ciclo per tutto l'array
				echo "<td>$value</td>";				//stampo il record
			echo "</tr>";							//fine riga
		}
		
		$conn->close();							//chiudo la connessione
	?>

		</table>	<!-- fine tabella -->
		<br>

		<div>
			<form action="main_elaborato.php">
				<input type="submit" value="Indietro">	<!-- torna alla pagina principale -->
			</form>
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