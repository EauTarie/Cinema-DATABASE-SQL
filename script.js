function btn_postalCodeGET() {
  let queryLocate = document.getElementById('postalCode').value
  const url = "https://api-adresse.data.gouv.fr/search/?q=postcode=" + queryLocate
  $.get(url, postalCode).done(function() {
    //alert( "second success" );
  })
    .fail(function() {
      alert("error");
    })
    .always(function() {
      //alert( "finished" );
    });
}

const postalCode = function(data) {
  let sectionID = document.getElementById('city')
  console.log("données API ", data)
  // TEST DE L'API//
  let donnee = data.features[4].properties.city
  console.log(donnee)
  // FIN TEST //

  
  console.log(sectionID) //<= Regarde ce que donne ça ;), Alex : Merci Jérémy //

  //Construction du select HTML //
  sectionID.innerHTML = `<label for="select-city">Choisissez une ville : </label>
  <select name="city" id="select-city" onclick="select_cityGET()">
    <option value="">Choisissez une ville</option>`
  selectID = document.getElementById('select-city')
  //fin construction SELECT HTML //

  // Construction des options de la ville //
    // test constructeur tableau pour condition if//
    let City = []
  data.features.forEach((e,i) => {
    console.log(City) // console.log pour donnée tableau
    console.log(data.features[i].properties.city)
    // fin test//
    if(!City.includes(data.features[i].properties.city)) {
    City.push(data.features[i].properties.city)
    selectID.innerHTML += `<option class="city" id="` + i + `" value="`+ data.features[i].properties.city + `">` + data.features[i].properties.city +"</option>"
    } else {
      
    }
  })
  // Fin construction des options villes //

}


// Construction du bouton onclick VILLE //
function select_cityGET() {
  let selectLocate = document.querySelector('select')
  console.log(selectLocate)

  // TEST //
  selectLocate.addEventListener('change', (event) => {
    const result = document.querySelector('option')

    const paraID = document.getElementById('cityResult')
    let test = result.innerHTML = `You like ${event.target.value}`;
    console.log(test)
  console.log(paraID)
    paraID.innerHTML = result.innerHTML
    //fin test//
  });
                                
  // let queryLocateCity = queryLocate.querySelector('main > div > p > button').value //
  //console.log(queryLocateCity)  CONSOLE LOG QUE LEVES (Code postal : 28 300)








  // A UTILISER POUR PLUS TARD ? REQUETE VILLE + CODE POSTAL //
/*  const url = "https://api-adresse.data.gouv.fr/search/?q=city=" + queryLocateCity
  $.get(url).done(function() {
    //alert( "second success" );
  })
    .fail(function() {
      alert("error");
    })
    .always(function() {
      //alert( "finished" );
    }); */
} 