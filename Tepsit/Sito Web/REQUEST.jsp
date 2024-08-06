<%@ page language="java" import="java.io.*, java.net.*" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<!-- importo la libreria per gestire la connessione attraverso la rete e i flussi di comunicazione input/output -->

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<!-- importo il file css esterno nel modo in cui possa aggiornarsi ogni volta -->
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<style type = "text/css">
			<%@ include file="stile.css" %>
		</style>
		<title>Sistema Sanitario</title>
	</head>
	<body>
		<h1>Sistema Sanitario</h1>
		<%
	        String comandoDaInviare;  //stringa da inviare al server
	        
	        try //gestisco le eccezioni
	        {
	        	//continua con la stessa sessione precedentemente instaurata
	        	Socket connessione = (Socket)session.getAttribute("connessione");
	            BufferedReader sIN = (BufferedReader)session.getAttribute("sIN");
	            PrintWriter sOUT = (PrintWriter)session.getAttribute("sOUT");
	            
            	comandoDaInviare = "REQUEST "; //il comando inizia con REQUEST
				comandoDaInviare += request.getParameter("id"); //ci viene aggiunto id dal form
				comandoDaInviare += " "; //spazio per differenziare le informazioni
				comandoDaInviare += request.getParameter("scopo"); //ci viene aggiunto scopo dal form
				comandoDaInviare += " "; //spazio per differenziare le informazioni
				
				String data = request.getParameter("data"); //ci vengono aggiunte data e ora dal form
				
				/*
					pattern data e ora --> yyyy-MM-ddThh:mm
					che devo trasformare in dd-MM-yyyy hh:mm
				*/
				comandoDaInviare += (data.charAt(8));	//prima cifra di dd
				comandoDaInviare += (data.charAt(9));	//seconda cifra di dd
				comandoDaInviare += "-";
				comandoDaInviare += (data.charAt(5));	//prima cifra di MM
				comandoDaInviare += (data.charAt(6));	//seconda cifra di MM
				comandoDaInviare += "-";
				for(int c = 0; c < 4; c++)	//cifre di yyyy
					comandoDaInviare += (data.charAt(c));
				
				comandoDaInviare += " ";
				
				for(int c = 11; c < 16; c++)	//cifre di hh:mm
					comandoDaInviare += (data.charAt(c));
				
	            sOUT.println(comandoDaInviare); //invia il comando al server
	            sOUT.flush(); //svuota il buffer
	            out.println("<h3>"+ sIN.readLine() + "</h3>"); //ricevo e stampo la risposta come h3
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