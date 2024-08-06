import java.net.*;
import java.io.*;

public class Client
{
    public static void main(String args[])
    {
        Socket connessione = null;

        //gestione input e output del client con il server
        InputStreamReader input, in;
        BufferedReader sIN, tastiera;
        OutputStream out;
        PrintWriter sOUT;

        String comandoDaInviare;    //stringa da inviare al server

        try
        {   //gestisco le eccezioni
            connessione = new Socket("localhost", 3333); //connessione al server
            System.out.println("Connessione Stabilita.");
            
            //gestione input e output del client con il server
            in = new InputStreamReader(connessione.getInputStream());
            sIN = new BufferedReader(in);

            out = connessione.getOutputStream();
            sOUT = new PrintWriter(out);

            input = new InputStreamReader(System.in);
            tastiera = new BufferedReader(input);

            while (true)
            {
                System.out.print("Immettere un comando: ");
                comandoDaInviare = tastiera.readLine(); //attende e riceve il comando da tastiera
                
                sOUT.println(comandoDaInviare); //invia il comando al server
                sOUT.flush();   //svuota il buffer

                System.out.println(sIN.readLine()); //stampa ciò che riceve dal server
            }
        } 
        catch (IOException e)
        {
            System.out.println(e);
        }
        try 
        {
            connessione.close();
        }
        catch (IOException e)
        {
            System.out.println(e);
        }
    }
}