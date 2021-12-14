<?php 

include("ConnectionData.php"); /*linia per importar els dades necessaries per la connexió*/

$db = mysqli_connect($server, $user, $password, $database) /*connexió*/

?>

<!DOCTYPE html>
<html lang="ca">
    <head>
        <meta charset="UTF-8" />
        <title>Stock</title>
        <link rel="stylesheet" href="Pr1_estil.css">
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Karla:wght@300;400;500;700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <header>
            <div class="logo">
                <a>logo</a>
            </div>
            <div class="opcions">
                <ul class="totalopcions">
                    <a href="index.php"><li class="cadaopcio">Inici
                    </li></a>
                    <li class="cadaopcio"><a href="Productes.html">Productes</a>
                        <ul class="desp">
                            <li><a href="EnStock.php">Solo en stock</a></li>
                            <li class="last_op"><a href="TotsProductes.php">Tots Productes</a></li>  
                        </ul>
                    </li>
                    <li class="cadaopcio">Categories
                        <ul class="desp">
                            <li><a href="CatPeriferic.php">Periferics</a></li>
                            <li><a href="CatPC.php">PC sobretaula</a></li>
                            <li><a href="CatComponents.php">Components</a></li>
                            <li class="last_op"><a href="CatElectroDom.php">Electrodomestics</a></li>
                        </ul>
                    </li>
                </ul>
            </div>
        </header>
        <div class="fake"></div>
        <main>
            <div class="table">
                <div class="input"> <!-- input per tenir la busqueda sobre de la taula amb productes -->
                    <input type="text" id="cerca" placeholder="Busca..." onkeyup="filterFunction()"/>
                </div>
                
                <form action="" method="GET"> <!-- Formulari per tria filtre de taula -->
                
                    <select name="sort_alphabet">
                        <option value="">Filtres</option> <!-- Depent del resulat que posa, canvia l'ordre de taula -->
                        <option value="a-z" <?php if(isset($_GET['sort_alphabet']) && $_GET['sort_alphabet'] == "a-z"){echo "selected";} ?> >Ordenar de A-Z</option> <!-- Resultat es igual de a-z -->
                        <option value="z-a" <?php if(isset($_GET['sort_alphabet']) && $_GET['sort_alphabet'] == "z-a"){echo "selected";} ?> >Ordenar de Z-A</option> <!-- Resultat es igual de z-a -->
                    </select>
                    <button type="submit" name="search"> <!-- boto del filtre, despres de clica el boto, s'aplique el filtre -->
                        Filtrar
                    </button>
                </form>
                <table id="taula"> <!-- Taula de productes solo en stock-->
                    <tr>
                        <th>Nom</th>
                        <th>Stock</th>
                        <th>Proveïdor</th>
                        <th>Material</th>
                        <th>Descripció</th>
                        <th>Preu</th>
                    </tr>
                    <?php
                    
                    $sort_option = ""; 
                    if(isset($_GET['sort_alphabet'])){ /* Aqui esta la funcio que utilitza el formulari d'abans */
                        if($_GET['sort_alphabet'] == "a-z"){ /* Si el resultat es a-z */
                            $sort_option = "Nom ASC"; /* ens ficara en ordre alfabetic ascendent */
                        }elseif($_GET['sort_alphabet'] == "z-a"){ /* Si el resultat es z-a */
                            $sort_option = "Nom DESC"; /* ens ficara en ordre alfabetic descendent */
                        }else{
                            $sort_option = "Codi_id"; /* si es tria qualsevol altre opcio ordre per el ID */
                        }
                    }else{
                        $sort_option = "Codi_id"; /* abans de tria opcio l'ordre tambe es per el ID */
                    }
                    $query = "SELECT * FROM productes p, proveidor pro where p.Codi_prov=pro.Codi_pro ORDER BY $sort_option"; /* depent del que fiquen en formulari, el resultat pot variar */
                    $query_run = mysqli_query($db, $query); /* agafa els resultats de la connexio bd */
                    
                    /* Si hi han registres ens ensenya */
                    if(mysqli_num_rows($query_run) > 0){ 
                        foreach($query_run as $row){ /* ens mostra linia a linia */
                            if($row['Stock']>0){ /* si en alguna linia el stock no es major que es 0 no s'ensenya */
                                ?>
                        <tr>
                            <td><?= $row['Nom']; ?></td>    <!-- dades que es mostren -->
                            <td><?= $row['Stock']; ?></td>
                            <td><?= $row['Nom_pro']; ?></td>
                            <td><?= $row['Materials']; ?></td>
                            <td><?= $row['Descr']; ?></td>
                            <td><?= $row['Preu']; ?></td>
                        </tr>
                                <?php
                            }
                        }
                    }else{
                        ?>
                    <tr>
                        <td colspan="6">No s'ha trobat cap registre</td> <!-- en cas de que no trova registres surt el missatge -->
                    </tr>
                    <?php
                    }   
                    ?>
                </table>
            </div>
        </main>
        <footer>
            <div class="quisom">
                <b>Qui som?</b>
                <br />
                <br />
                <a href="#">Qui som?</a>
                <br />
                <a href="#">Nostres botigues</a>
                <br />
                <a href="#">Condicions de compra</a>
                <br />
                <a href="#">Marques</a>
                <br />
                <a href="#">Privacitat</a>
            </div>
            <div class="ajuda">
                <b>Ajuda</b>
                <br />
                <br />
                <a href="#">Centre de Soport</a>
                <br />
                <a href="#">Contacte</a>
                <br />
                <a href="#">Publicitat</a>
                <br />
                <a href="#">Politica de cookies</a>
            </div>
            <div class="altres">
                <b>Altres</b>
                <br />
                <br />
                <a href="#">Ofertes</a>
                <br />
                <a href="#">Black friday</a>
                <br />
                <a href="#">Outlet</a>
                <br />
                <a href="#">Servei de reparacions</a>
            </div>
            <div class="xarxes">
                <b>Xarxes</b>
                <br />
                <br />
                <a href="#" class="fa fa-facebook"></a>
                <a href="#" class="fa fa-instagram"></a>
                <a href="#" class="fa fa-twitter"></a>
                <a href="#" class="fa fa-google"></a>
            </div>
            <div class="under_footer">
                <a>Copyright © 2021 GameStock, Inc.</a>
            </div>
        </footer>
        <script src="busqueda.js"></script>
    </body>
</html>