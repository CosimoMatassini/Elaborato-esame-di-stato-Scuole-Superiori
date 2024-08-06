<?php
	$conn = new mysqli("localhost", "root", "", "SistemaSanitario");	 //connessione al server MySQL
	if($conn->connect_errno)	//se non viene aperta la connessione
	{
		echo "Impossibile connettersi al server: " . $conn->connect_error . "\n"; //messaggio di errore
		exit;	//interruzione script
	}
?>

<!--
	Utilizzare un file unico ed includerlo negli altri porta almeno 2 vantaggi:
	• il codice nelle altre pagine risultà più pulito (ci sono meno righe di codice)
	• riutilizzabilità per cambiamenti futuri (le modifiche ad un unico file si applicano a tutti quelli che lo includono)
 -->