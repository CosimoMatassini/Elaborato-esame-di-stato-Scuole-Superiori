import java.net.*;
import java.io.*;

public class ConnessioneClient implements Runnable //implementa interfaccia Runnable per la gestione dei thread
{
    Socket connessione = null;

    //gestione input e output del thread con il client
    InputStreamReader input;
    BufferedReader sIN;
    OutputStream out;
    PrintWriter sOUT;
    
    String risposta;    //stringa da inviare al client
    String comandoRicevuto; //stringa che riceve il comando dal client

    public ConnessioneClient(Socket conn)   //costruttore
    {
        this.connessione = conn;    //passa conn (preso dall'argomento nel momento dell'istanziamento della classe) a connessione

        try 
        {
            //gestione input e output del thread con il client
            out = connessione.getOutputStream();
            sOUT = new PrintWriter(out);
            input = new InputStreamReader(connessione.getInputStream());
            sIN = new BufferedReader(input);
        }
        catch (IOException e)
        {
            System.out.println(e);
        }

        new Thread(this).start();
    }

    public void run()   //blocco di codice eseguito dal thread
    {
        try
        {
            while (true) 
            {
                comandoRicevuto = sIN.readLine();   //attende e riceve il comando dal client

                risposta = Protocollo.interpretaComando(comandoRicevuto);   //viene passato il comando alla classe protocollo che elabora la risposta

                sOUT.println(risposta); //invia la risposta al client
                sOUT.flush();   //svuota il buffer
            }
        }
        catch (Exception e) 
        {
            System.out.println(e);
        }
    }
}