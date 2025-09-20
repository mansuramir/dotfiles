const PERIOD = 'week';
const REGION = 'SGR01';
const URL = 'https://www.e-solat.gov.my/index.php?r=esolatApi/TakwimSolat&zone=' + REGION + '&period=' + PERIOD;

fetch(URL)
  .then(response => response.text())
  .then(text => console.log(text))
