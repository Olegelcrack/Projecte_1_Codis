<?php include("ConnectionData.php") ?>

<!DOCTYPE html>
<html lang="ca">
    <head>
        <meta charset="UTF-8" />
        <title>Stock PC</title>
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
                <div class="input"><input type="text" id="cerca" placeholder="Busca..." onkeyup="filterFunction()"/></div>
                <table id="taula">
                    <tr>
                        <th>Nom</th>
                        <th>Stock</th>
                        <th>Proveïdor</th>
                        <th>Material</th>
                        <th>Descripció</th>
                        <th>Preu</th>
                    </tr>
                    <?php
                    try{
                        $db = new PDO("mysql:host=localhost:3306;dbname=$database", $user, $password);
                        foreach($db->query("SELECT * FROM productes p, proveidor pro, pertany per where p.Codi_prov=pro.Codi_pro and Codi_cat=3 and p.Codi_id=per.Codi_id") as $row){
                            echo "<tr><td>" . $row['Nom'] . "</td>";
                            echo "<td>" . $row['Stock'] . "</td>";
                            echo "<td>" . $row['Nom_pro'] . "</td>";
                            echo "<td>" . $row['Materials'] . "</td>";
                            echo "<td>" . $row['Descr'] . "</td>";
                            echo "<td>" . $row['Preu'] . "</td></tr>";
                        }
                    } catch (PDOException $e) {
                        print "Error!: " . $e->getMessage() . "<br/>";
                        die();
                    }
                    ?>
                </table>
            </div>
            <div class="content">
                .
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