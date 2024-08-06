<%@ page language="java" import="java.io.*, java.net.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>

<!-- importo la libreria per gestire la connessione attraverso la rete  -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<!-- importo il file css esterno nel modo in cui possa aggiornarsi ogni volta -->
		<style type = "text/css">
			<%@ include file="stile.css" %>
		</style>
		<title>Sistema Sanitario</title>
	</head>
	<body>
		<h1>Sistema Sanitario</h1>
		
		<br>
		
		<div id="griglia">	<!-- div per gestire il layout delle fieldsets -->
		
			<fieldset>
				<legend>Inserimento paziente</legend>
				<form action="INSERT.jsp" method="post">	<!-- utilizzo il metodo POST (più sicuro di GET) -->
					<label for="nome">Nome: </label>
					<input type="text" id="nome" name="nome"> <!-- inserimento nome -->
					<br>
					<label for="cognome">Cognome: </label>
					<input type="text" id="cognome" name="cognome"> <!-- inserimento cognome -->
					<br>
					<input type="submit" value="INSERISCI"> <!-- bottone di conferma -->
				</form>
			</fieldset>
			
			
			<fieldset>
				<legend>Richiesta visita</legend>
				<form action="REQUEST.jsp" method="post">	<!-- utilizzo il metodo POST (più sicuro di GET) -->
					<label for="id">Id paziente: </label>
					<input type="number" id="id" name="id"> <!-- inserimento id paziente -->
					<br>
					<label for="scopo">Scopo: </label>
					<input type="text" id="scopo" name="scopo"> <!-- inserimento scopo/tipologia visita -->
					<br>
					<label for="data">Data: </label>
					<input type="datetime-local" id="data" name="data">
					<br>
					<input type="submit" value="RICHIEDI"> <!-- bottone di conferma -->
				</form>
			</fieldset>
			
			<fieldset>
				<legend>Visualizza visite</legend>
				<form action="VISITS.jsp" method="post">	<!-- utilizzo il metodo POST (più sicuro di GET) -->
					<label for="idvisual">Id paziente: </label>
					<input type="number" id="idvisual" name="idvisual">
					<br>
					<input type="submit" value="VISUALIZZA"> <!-- bottone di conferma -->
				</form>
			</fieldset>
			
		</div>
		
		<br>
		<br>
		<br>
		
		<% //testo la connessione e eventualmente informo l'utente che la connessione non è avvenuta con successo
		if(session.isNew())	//se la sessione non è ancora stata instaurata
		{
			try	//gestisco le eccezioni
        	{
				Socket connessione = new Socket("localhost", 3333); //connessione al server
				
				//gestione flusso di comunicazione input
	            InputStreamReader in = new InputStreamReader(connessione.getInputStream());
	            BufferedReader sIN = new BufferedReader(in);
	
	          	//gestione flusso di comunicazione output
	            OutputStream outputSocket = connessione.getOutputStream();
	            PrintWriter sOUT = new PrintWriter(outputSocket);
	            
	            session.setAttribute("connessione", connessione);	//memorizza nella sessione la connessione
	            session.setAttribute("sIN", sIN);	//memorizza nella sessione sIN
	            session.setAttribute("sOUT", sOUT);	//memorizza nella sessione sOUT
    		}
	        catch (Exception e)
	        {
	        	out.println("<h4>Errore! Connessione non riuscita!<br>Servizio temporaneamente non disponibile.<br>Contattare l'assistenza se il problema persiste.</h4>");
	            System.out.println(e);
	        }
		}
        %>
	</body>
</html>