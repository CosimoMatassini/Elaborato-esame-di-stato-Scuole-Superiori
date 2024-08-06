<%@ page language="java" import="java.io.*, java.net.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!-- importo la libreria per gestire la connessione attraverso la rete e i flussi di comunicazione input/output -->

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
		
		<%
	        String comandoDaInviare; //stringa da inviare al server
	        
	        try //gestisco le eccezioni
	        {
	        	//continua con la stessa sessione precedentemente instaurata
	        	Socket connessione = (Socket)session.getAttribute("connessione");
	            BufferedReader sIN = (BufferedReader)session.getAttribute("sIN");
	            PrintWriter sOUT = (PrintWriter)session.getAttribute("sOUT");
	        	
            	comandoDaInviare = "VISITS "; //il comando inizia con VISITS
				comandoDaInviare += request.getParameter("idvisual"); //ci viene aggiunto idvisual dal form
				
	            sOUT.println(comandoDaInviare); //invia il comando al server
	            sOUT.flush();	//svuota il buffer
	            
	            String risposta = sIN.readLine(); //riceve la risposta dal server
	            risposta = risposta.replace(" ___ ","<br>");	//cambio tutte le occorrenze di " ___ " in <br> per andare a capo nella pagina web
	            out.println("<h3>"+ risposta + "</h3>"); //stampo la risposta come h3
    		}
	        catch (IOException e)
	        {
	            System.out.println(e);
	        }
        %>
        
        <form action="main.jsp">
			<input type="submit" value="INDIETRO"> <!-- bottone per tornare alla pagina principale -->
		</form>
	</body>
</html>