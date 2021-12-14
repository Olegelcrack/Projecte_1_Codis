import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import java.nio.file.FileSystem;
import java.nio.file.FileSystems;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.StandardCopyOption;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.Scanner;

public class Projecte {
    
    static Connection connectBD=null;
    static boolean sortir=false;
    static boolean sortir2=false;
    
    public static String PATHPENDENTS = "files/ENTRADES PENDENTS/";
    public static String PATHPROCESSADES = "files/ENTRADES PROCESSADES/";
    public static String Comandes = "comandes/comandes.txt/";
    
    static String [] Proveidor_Array=new String[3];
    static int [] Productes_Array=new int[3];
    
    public static void main (String[] args) throws SQLException, IOException{
        
        Scanner teclat = new Scanner(System.in);
        connexio();
        
        do{
            System.out.println("*****Menu gestor Inventari******");
            System.out.println("1. Gestio productes (A/B/M/C)");
            System.out.println("2. Actualitzar stock");
            System.out.println("3. Preparar comandes");
            System.out.println("4. Analitzar les comandes");
            System.out.println("5. Sortir");
            System.out.println("\nTria una opcio");

            int opcio= teclat.nextInt();

            System.out.println("opcio: " +opcio );

            switch (opcio){
                case 1:
                    gestioProducte();
                    break;
                case 2:
                    updateProductes();
                    break;
                case 3:
                    genComands();
                    break;
                case 4: 
                    analComandes();
                    break;
                case 5:
                    sortir = true;
                    break;
                default:
                    System.out.println("Opció no valida");
            }

            teclat.nextInt();


        }while(!sortir);
        desconexioBD();
    }
    
    static void updateProductes() throws IOException, SQLException{    
        System.out.println("ActualitzarEstock");
        
        File fitxer = new File(PATHPENDENTS);
        
        if (fitxer.isDirectory()){
            File[] files = fitxer.listFiles();
            for(int i=0;i<files.length; i++){
                System.out.println("fitxer: " + files[i]);
                visualitzarActualitrzarFitxer(files[i]);
                moureFitxerAProcessat(files[i]);
            }
        }
    }
    
    static void visualitzarActualitrzarFitxer(File fitxer) throws FileNotFoundException, IOException, SQLException{
        // llegeix caracter a caracter
        FileReader reader = new FileReader(fitxer);
        // llegeix linia a linia, és mes eficient
        BufferedReader buffer = new BufferedReader (reader);
        
        String linea;
        while((linea=buffer.readLine()) !=null){
            System.out.println(linea);
            int Num = linea.indexOf(":");
            
            int Codi_id = Integer.parseInt(linea.substring(0,Num));
            int Stock = Integer.parseInt(linea.substring(Num + 1));
            
            String consulta = "UPDATE productes SET Stock=Stock+? WHERE Codi_id=?";
            PreparedStatement ps = connectBD.prepareStatement (consulta);
            ps.setInt(1, Stock);
            ps.setInt(2, Codi_id);
            ps.executeUpdate();
        }
        buffer.close();
        reader.close();
    }
    
    static void moureFitxerAProcessat(File fitxer) throws IOException{
        FileSystem sistemaFicheros=FileSystems.getDefault();
        Path origen=sistemaFicheros.getPath(PATHPENDENTS +fitxer.getName());
        Path desti=sistemaFicheros.getPath(PATHPROCESSADES +fitxer.getName());
        
        
        Files.move(origen,desti, StandardCopyOption.REPLACE_EXISTING);
        System.out.println("s'ha mogut a PROCESSATS el fitxer: " +fitxer.getName());
        
    }
    
    static void genComands() throws SQLException, IOException{
        
        FileWriter fw = null;
        BufferedWriter bw = null;
        PrintWriter pw = null;
        
        System.out.println("GenComandes");
        String consulta = "SELECT prod.Codi_id, prod.Nom, prod.Stock, prov.Nom FROM productes prod, proveidor prov WHERE prod.Codi_pro=prov.Codi_pro AND Stock <=20 ORDER BY prov.Codi_pro;";
        PreparedStatement ps = connectBD.prepareStatement(consulta);
        ResultSet rs=ps.executeQuery();
        
        int contadorProveidors=0; // indexant el array
        int contadorProductes=0;  // informar l'array de producte
                    
        if (rs.next()){
            
            String Proveidor=rs.getString(4);
            Proveidor_Array[contadorProveidors]=rs.getString(4);                    
            pw=escriureCapçaleraComanda(Proveidor);
            do{
                //comprovem si el proveidor ha canviat
                if(!Proveidor.equals(rs.getString(4))){
                    Productes_Array[contadorProveidors]=contadorProductes;
                    contadorProductes = 0;
                    Proveidor=rs.getString(4);
                    pw.close();
                    contadorProveidors++;
                    Proveidor_Array[contadorProveidors]=rs.getString(4);                    
                    pw=escriureCapçaleraComanda(Proveidor);
                    }
                contadorProductes++;
                System.out.println("Id producte: " +rs.getInt(1) + "\t" + "Nom: " +rs.getString(2) + "\t" + "Stock: " + rs.getInt(3) + "\t" + "Nom proveïdor: " + rs.getString(4));
                pw.println(rs.getInt(1) + "\t\t" + rs.getString(2) + "\t\t" + rs.getInt(3) + "\t\t" + rs.getString(4));
            }while(rs.next());
            Productes_Array[contadorProveidors]=contadorProductes;
            pw.close();
        }
    }
    
    static PrintWriter escriureCapçaleraComanda(String Proveidor) throws IOException{
        FileWriter fw = new FileWriter("comandes/"+Proveidor+LocalDate.now() +".txt");
        BufferedWriter bw = new BufferedWriter(fw);
        PrintWriter pw = new PrintWriter(bw);
        
        pw.println("****** GameStock ******");
        pw.println();
        pw.println("Codi_id:" + "\t" + "Nom:" + "\t\t" + "Stock:" + "\t\t" + "Proveïdor:");
        return pw;
    }
    
    static void analComandes(){
        System.out.println("AnalComandes" + "\n");
        for (int i=0;i<Proveidor_Array.length;i++){
            System.out.println("\n"+"Proveidor: " + Proveidor_Array[i] + "\n" + "Quantitat productes: " + Productes_Array[i] + "\n");
        }
        maxProductes();
        minProductes();
        mitjanaProductes();
    }
    
    static void maxProductes(){
        //Maxim dels Productes:
        int max=Productes_Array[0];
        int y=0;
        
        for(int i=0; i<Productes_Array.length;i++){
            if(Productes_Array[i]>max){
                max=Productes_Array[i];
                y=i;
            }
        }
        System.out.println("El maxim de productes es: " +max+ " de " +Proveidor_Array[y]);
    }
    
    static void minProductes(){
        //Minim dels productes
        int minim=Productes_Array[0];
        int y=0;
        
        for(int i=0;i<Productes_Array.length;i++){
            if(Productes_Array[i]<minim){
                minim=Productes_Array[i];
                y=i;
            }
        }
        System.out.println("El minim de productes es: " +minim+ " de " +Proveidor_Array[y]);
    }
    
    static void mitjanaProductes(){
        //Mitjana dels Productes:
        double mitja=0;
        for(int i=0;i<Productes_Array.length;i++){
            mitja+=Productes_Array[i];
        }
        mitja/=Productes_Array.length;
        System.out.println("La mitjana de productes es: " +mitja);
    }
    
    static void gestioProducte() throws SQLException{
        Scanner teclat = new Scanner(System.in);
        
        do{
            System.out.println("*****Menu gestor Productes******");
            System.out.println("1. Llista tots els productes");
            System.out.println("2. Alta producte");
            System.out.println("3. Modificar producte");
            System.out.println("4. Esborrar producte");
            System.out.println("5. Sortir");
            System.out.println("\nTria una opcio");

            int opcio= teclat.nextInt();
            teclat.nextLine();

            switch (opcio){
                case 1:
                    Llistaproductes();
                    sortir2=false;
                    break;
                case 2:
                    Altaproducte();
                    sortir2=false;
                    break;
                case 3:
                    Modificaproductes();
                    sortir2=false;
                    break;
                case 4: 
                    Esborraproductes();
                    sortir2=false;
                    break;
                case 5: 
                    sortir2=true;
                    break;
                default:
                    System.out.println("Opció no valida");
            }

        }while(!sortir2);
    }
    
    static void Llistaproductes() throws SQLException{

        //preparem la consulta
        String consulta = "SELECT * FROM productes ORDER BY Codi_id";
        PreparedStatement ps = connectBD.prepareStatement(consulta);
        //llencem consulta
        ResultSet rs=ps.executeQuery();
        
        while (rs.next()){
            System.out.println("Codi_id: " +rs.getInt("Codi_id"));
            System.out.println("Nom: " + rs.getString("Nom"));
            System.out.println("Stock: " + rs.getInt("Stock"));
            System.out.println("Codi_pro: " + rs.getInt("Codi_pro"));
        }    
    }
    
    static void Altaproducte(){
        Scanner teclat = new Scanner (System.in);
        String consulta = "INSERT INTO productes (Nom, Stock, Codi_pro) VALUES (?, ?, ?)";
        
        
        System.out.println("Posar el nom del nou producte: ");
        String Nom=teclat.nextLine();
        System.out.println("Posar la quantitat en el stock: ");
        int Stock=teclat.nextInt();
        System.out.println("Posar el proveïdor: ");
        int Codi_pro=teclat.nextInt();
        
        PreparedStatement sentencia = null;
        
        try {
            sentencia = connectBD.prepareStatement(consulta);
            sentencia.setString(1, Nom);
            sentencia.setInt(2, Stock);
            sentencia.setInt(3, Codi_pro);
            sentencia.executeUpdate();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            //Tanquem els recursos oberts
            if (sentencia != null)
            try {
                sentencia.close();
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            }
        }
    }
    
    static void Modificaproductes(){
        Scanner teclat = new Scanner (System.in);
        String consulta = "UPDATE productes SET Nom = ?, Stock = ?, Codi_pro = ? WHERE Nom = ?";
        
        
        System.out.println("Posar el nom del producte que vols modificar: ");
        String Nom_id=teclat.nextLine();
        System.out.println("Nou nom del producte: ");
        String Nom=teclat.nextLine();
        System.out.println("Quantitat en el stock: ");
        int Stock=teclat.nextInt();
        System.out.println("El proveïdor: ");
        int Codi_pro=teclat.nextInt();
        
        PreparedStatement sentencia = null;
        
        try {
            sentencia = connectBD.prepareStatement(consulta);
            sentencia.setString(4,Nom_id);
            sentencia.setString(1, Nom);
            sentencia.setInt(2, Stock);
            sentencia.setInt(3, Codi_pro);
            sentencia.executeUpdate();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            //Tanquem els recursos oberts
            if (sentencia != null)
            try {
                sentencia.close();
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            }
        }
    }
    
    static void Esborraproductes(){
        Scanner teclat = new Scanner (System.in);
        String consulta = "DELETE FROM productes WHERE Nom = ?";
        
        
        System.out.println("Posar el nom del producte que vols eliminar: ");
        String Nom=teclat.nextLine();
        
        PreparedStatement sentencia = null;
        
        try {
            sentencia = connectBD.prepareStatement(consulta);
            sentencia.setString(1, Nom);
            sentencia.executeUpdate();
        } catch (SQLException sqle) {
            sqle.printStackTrace();
        } finally {
            //Tanquem els recursos oberts
            if (sentencia != null)
            try {
                sentencia.close();
            } catch (SQLException sqle) {
                sqle.printStackTrace();
            }
        }
    }
    
    static void connexio() throws SQLException{
        
        String servidor="jdbc:mysql://localhost:3306/";
        String bbdd="projecte";
        String user="root";
        String password="";
        try{
            connectBD = DriverManager.getConnection(servidor + bbdd, user, password);
        }catch (SQLException ex){
            ex.printStackTrace();
        }
    }
    
    static void desconexioBD() throws SQLException{
        connectBD.close();
    }
}
