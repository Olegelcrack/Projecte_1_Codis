function filterFunction(){ //Codi per el buscador, des de una taula buscara dades introduits en el buscador
    
    var input = document.getElementById("cerca"),
        filter = input.value.toUpperCase(),
        taula = document.getElementById("taula"),
        files = taula.getElementsByTagName("tr");
        
    for(i=0; i<files.length; i++){
        
        txtCercat = files[i].textContent || files[i].innerText;

        if(txtCercat.toUpperCase().indexOf(filter) > -1){
            files[i].style.display ="";
        }else{
            files[i].style.display = "none";
        }
    }
}