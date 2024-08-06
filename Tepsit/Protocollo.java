import java.util.*;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

public class Protocollo
{
    static List<Paziente> pazienti = new ArrayList<Paziente>();   //lista dei pazienti che deve essere statica
    static int contatorepazienti = 1;   //gestione del numero dei pazienti e l'assegnazione di codici a nuovi (statico)
    static List<Visita> visite = new ArrayList<Visita>();   //lista delle visite che deve essere statica

    static String interpretaComando(String comando)
    {
        String _return = "";    //stringa che rappresenta la rispsta per il client
        comando = comando.replaceAll("\\s+", " "); //tolgo eventuali spazi di troppo o altri caratteri speciali dal comando (formatto la stringa nel modo in cui deve essere)


        if (comando.startsWith("INSERT "))    //se il comando inizia con INSERT
        {
            Paziente paz = new Paziente();   //istanzio un oggetto della classe Paziente per poter immagazzinarlo correttamente e passarlo alla lista

            //TEMPLATE DEL COMANDO --> INSERT *nome* *cognome*
            comando = comando.substring(7); //la stringa diventa --> *nome* *cognome* (rimuovo *INSERT *)
            paz.nome = comando.substring(0, comando.indexOf(" ")); //ricavo *nome* (acquisisco tutti i caratteri fino al primo spazio)
            comando = comando.substring(comando.indexOf(" ") + 1); //la stringa diventa --> *cognome* (rimuovo *nome *)
            paz.cognome = comando; //ricavo *cognome* (è ciò che rimane in comando)
            paz.id = contatorepazienti++;   //assegnazione automatica dell'id e aumento del contatore di 1

            pazienti.add(paz); //aggiungo il paziente alla lista

            //risposta (conferma all'utente)
            _return = "Inserimento del paziente " + paz.nome + " " + paz.cognome + " avvenuto con successo. Codice paziente (da memorizzare): " + paz.id;
        }
        else if (comando.startsWith("REQUEST "))    //se il comando inizia con REQUEST
        { 
            Visita vis = new Visita();   //istanzio un oggetto della classe Visita per poter immagazzinarla correttamente e passarla alla lista

            //TEMPLATE DEL COMANDO --> REQUEST *id* *scopo* *data* (data gg-MM-yyyy hh:mm)
            comando = comando.substring(8); //la stringa diventa --> *id* *scopo* *data* (rimuovo *REQUEST *)
            vis.paziente = Integer.parseInt(comando.substring(0, comando.indexOf(" "))); //ricavo *id*  (acquisisco tutti i caratteri fino al primo spazio)

            if(vis.paziente < 1 || vis.paziente >= contatorepazienti)   //se viene inserito l'id di un paziente non valido
                return "Utente non esistente!";

            comando = comando.substring(comando.indexOf(" ") + 1); //la stringa diventa --> *scopo* *data* (rimuovo *id *)
            vis.scopo = comando.substring(0, comando.indexOf(" ")); //ricavo *scopo* (acquisisco tutti i caratteri fino al primo spazio)
            comando = comando.substring(comando.indexOf(" ") + 1); //la stringa diventa --> *data* (rimuovo *scopo *)
            vis.data = LocalDateTime.parse(comando, DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")); //ricavo la data (è ciò che rimane in comando)

            if (vis.data.isBefore(LocalDateTime.now())) //se la data richiesta è prima di adesso non è valida
                return "Inserire una data valida!";

            for (int c = 0; c < visite.size(); c++) //cerco nelle visite (con un ciclo controllo tutti gli elementi al suo interno)
			{
                if(visite.get(c).data.isEqual(vis.data) && visite.get(c).scopo.equals(vis.scopo))   //se la data è già stata inserita per quel tipo di visita
                    return "Posto gia' occupato! Scegliere un'altra data/ora.";
			}
            visite.add(vis);    //se si è riusciti ad uscire dal ciclo vuol dire che quella data può essere inserita
            _return = " Visita aggiunta: --> " + comando + " per " + vis.scopo;  //messaggio di conferma
        }
        else if (comando.startsWith("VISITS "))   //se il comando inizia con VISITS
        {
            //TEMPLATE DEL COMANDO --> VISITS *id*
			comando = comando.substring(7); //la stringa diventa --> *id* (rimuovo *visits *)
            int n_paziente = Integer.parseInt(comando); //ricavo *id* convertendolo in intero da stringa (è ciò che rimane in comando)

            if(n_paziente < 1 || n_paziente >= contatorepazienti)   //se viene inserito l'id di un paziente non valido
                return "Utente non esistente!";

            int visitetrovate = 0;    //contatore delle visite 
            for (int c = 0; c < visite.size(); c++) //cerco nelle visite (con un ciclo controllo tutti gli elementi al suo interno)
			{
                if(visite.get(c).paziente == n_paziente) //cerco le visite del paziente in questione
                {
                    visitetrovate++;
                    if(visitetrovate != 1)
                        _return += " ___ "; //distanziamento di una visita dall'altra (\n non può essere utilizzato altrimenti "spezzerebbe" la stringa)
                    _return += " Visita: --> " + visite.get(c).data.format(DateTimeFormatter.ofPattern("dd-MM-yyyy HH:mm")) + " per " + visite.get(c).scopo;  //concatena il messaggio alla risposta da inviare al client
                }
             }
            if (_return == "")  //se non viene inserita nessuna visita
                _return = "Nessuna visita presente del paziente selezionato.";
        }
        else
            _return = "Comando sconosciuto!";
        
        return _return;
    }
}